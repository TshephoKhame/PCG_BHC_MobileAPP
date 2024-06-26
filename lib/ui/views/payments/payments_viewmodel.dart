import 'dart:async';
import 'dart:math';

import 'package:bhc_mobile/app/app.locator.dart';
import 'package:bhc_mobile/app/app.logger.dart';
import 'package:bhc_mobile/services/appwrite_service.dart';
import 'package:bhc_mobile/services/http_service.dart';
import 'package:bhc_mobile/services/local_database_service.dart';
import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/views/payments/widgets/add_payment_card.dart';
import 'package:bhc_mobile/ui/views/payments/widgets/pay_screen.dart';
import 'package:bhc_mobile/ui/widgets/alternate_payments.dart';
import 'package:bhc_mobile/ui/widgets/common/form_fields/text_input_field.dart';
import 'package:bhc_mobile/ui/widgets/common/payment_options_widget/payment_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class PaymentsViewModel extends BaseViewModel {
  late String paymentTenDaysAway;
  final _logger = getLogger('paymentModel');
  final _httpSvc = locator<HttpService>();
  final _appwriteSvc = locator<AppwriteService>();
  final _dbService = locator<LocalDatabaseService>();
  List<Map<String, dynamic>> paymentOption = [];
  List<Map<String, dynamic>> savedCards = [];
  String isTPSPayment = '';
  final Random _random = Random();
  BuildContext context;
  PaymentsViewModel(this.context) {
    initPayments();
    paymentTenDaysAway = formatTenDaysAway();
  }

  FormGroup get uploadPoPForm => _uploadPoPForm;
  final FormGroup _uploadPoPForm = fb.group({
    'upload': [Validators.required],
  });

  FormGroup get bankDepositForm => _bankDepositForm;
  final FormGroup _bankDepositForm = fb.group({
    'accountNumber': [Validators.required],
    'bankName': [Validators.required],
    'depositAmount': [Validators.required],
  });

  Future<void> initPayments() async {
    await getPayments();
    await getCard();
    //notifyListeners();
  }

  bool get isTPS => true; // Sample date

  String get paymentDueDate => "10/07/2024"; // Sample date

  double get totalPaid => 5000.00;
  double get remainingBalance => 7000.00;

  List<Map<String, dynamic>> tpsOptions = [
    {
      'Amount': 'P2,500.00',
      'Status': 'Successful',
      'DatePaid': '01/06/2024',
      'PaymentMethod': 'Bank Transfer',
      'ReceiptNumber': '123456789'
    },
    {
      'Amount': 'P2,500.00',
      'Status': 'Successful',
      'DatePaid': '01/05/2024',
      'PaymentMethod': 'Credit Card',
      'ReceiptNumber': '987654321'
    },
  ];

  // void showPayNowDialog() {
  //   // Implement the functionality to show payment dialog
  // }

  Future<void> savePayments(
      {required String paymentMethod, required String amount}) async {
    String message = "";
    String receiptNumber = await generateString();
    String date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    Map<String, dynamic> savingPaymentOption = {
      'ReceiptNumber': receiptNumber,
      'Amount': amount,
      'PaymentMethod': paymentMethod,
      'DatePayed': date,
      'IsTPS': isTPSPayment == '' ? 'Rent' : isTPSPayment,
    };
    paymentOption.add(savingPaymentOption);
    await _dbService.save(key: 'payment', value: paymentOption, log: true);

    _logger.d('Saved payment with receipt number : $receiptNumber');
    notifyListeners();
  }

  Future<void> saveCard(
      {required String cardNumber, required String expiryDate}) async {
    String processedExpiryDate = checkExpiryDate(expiryDate);

    Map<String, dynamic> cardType = {
      'CardNumber': cardNumber,
      'ExpiryDate': processedExpiryDate,
    };
    savedCards.add(cardType);
    await _dbService.save(key: 'card', value: savedCards, log: true);
    _logger.d('Saved Card : $cardNumber');
    notifyListeners();
  }

  Future<void> getPayments() async {
    try {
      final payments = await _dbService.get(key: 'payment');
      if (payments != null && payments is List) {
        paymentOption = payments.map((payment) {
          if (payment is Map && payment['IsTPS'] == 'Rent') {
            return Map<String, dynamic>.from(payment);
          } else {
            _logger.e('Unexpected data format in payments: $payment');
            return <String, dynamic>{};
          }
        }).toList();
        tpsOptions = payments.map((payment) {
          if (payment is Map && payment['IsTPS'] == 'TPS') {
            return Map<String, dynamic>.from(payment);
          } else {
            _logger.e('Unexpected data format in payments: $payment');
            return <String, dynamic>{};
          }
        }).toList();
        _logger.d('Pulled payments: $tpsOptions');
        _logger.d('Pulled payments: $paymentOption');
      } else {
        _logger.d('Payments is: $payments');
        paymentOption = [];
      }
    } catch (e) {
      _logger.e('Error fetching payments: $e');
      paymentOption = [];
    }
    notifyListeners();
  }

  Future<void> getCard() async {
    try {
      final card = await _dbService.get(key: 'card');
      if (card != null && card is List) {
        savedCards = card.map((card) {
          if (card is Map) {
            return Map<String, dynamic>.from(card);
          }
          if (card is Null) {
            return <String, dynamic>{};
          } else {
            _logger.e('Unexpected data format in card: $card');
            return <String, dynamic>{};
          }
        }).toList();
        _logger.d('Pulled cards: $savedCards');
      } else {
        _logger.d('Card is: $card');
        savedCards = [];
      }
    } catch (e) {
      _logger.e('Error fetching card: $e');
      savedCards = [];
    }
    notifyListeners();
  }

  Future<void> deleteCard(cardNumber, index) async {
    try {
      final card = await _dbService.delete(key: 'CardNumber');
      savedCards.removeAt(index);
    } catch (e) {
      _logger.e('Error deleting card: $e');
      savedCards = [];
    }
    notifyListeners();
  }

  clearDB() async {
    await _dbService.cleanDb();
  }

  showPayNowDialog() async {
    await openBottomSheet(context,
        title: 'Payment Options',
        // ignore: prefer_const_constructors
        content: Center(
          child: PaymentOptionsWidget(vm: this),
        ));
  }

  showAlternatePaymentDialog(String paymentOptions) async {
    Navigator.pop(context);
    await openBottomSheet(context,
        title: '',
        // ignore: prefer_const_constructors
        content: Center(
          child: AlternatePaymentOptionsWidget(
            vm: this,
            paymentOptions: paymentOptions,
          ),
        ));
  }

  showAddCardDialog() async {
    Navigator.pop(context);

    await openBottomSheet(context,
        title: 'Add Card',
        // ignore: prefer_const_constructors
        content: Center(
          child: AddPaymentCard(
            vm: this,
          ),
        ));
  }

  showCardProccessingPaymentDialog() async {
    Navigator.pop(context);
    await openBottomSheet(context,
        title: '',
        height: 300,
        content: Center(
          child: PaymentProcessingScreen(
            vm: this,
          ),
        ));
  }

  successfulyPayedDialog() async {
    Navigator.pop(context);

    await openBottomSheet(
      context,
      title: '',
      height: 250,
      // ignore: prefer_const_constructors
      content: Center(
        child: Column(
          children: [
            const Icon(
              Icons.check,
              size: 45,
              color: bhcGreen,
            ),
            verticalSpaceTiny,
            Text(
              textAlign: TextAlign.center,
              'Payment Successful',
              style: titleLarge(context),
            ),
            verticalSpaceTiny,
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
                style: bodyText1(context).copyWith(color: bhcRed),
              ),
            )
          ],
        ),
      ),
    );
  }

  showBankDepositDialog() async {
    Navigator.pop(context);

    await openBottomSheet(
      context,
      title: '',
      height: 300,
      // ignore: prefer_const_constructors
      content: Center(
        child: Column(
          children: [
            Theme(
              data: inputFieldTheme(context: context),
              child: ReactiveForm(
                formGroup: bankDepositForm,
                child: Column(
                  children: [
                    TextInputField(
                      config: {
                        'name': 'accountNumber',
                        'label': 'Account Number',
                        'validationMessages': {
                          ValidationMessage.required: (error) =>
                              'This field is required'
                        }
                      },
                      parentForm: bankDepositForm,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextInputField(
                            config: {
                              'name': 'bankName',
                              'label': 'Bank Name',
                              'validationMessages': {
                                ValidationMessage.required: (error) =>
                                    'This field is required'
                              }
                            },
                            parentForm: bankDepositForm,
                          ),
                        ),
                        horizontalSpaceSmall,
                        Expanded(
                          child: TextInputField(
                            config: {
                              'name': 'depositAmount',
                              'label': 'Amount',
                              'validationMessages': {
                                ValidationMessage.required: (error) =>
                                    'This field is required'
                              }
                            },
                            parentForm: bankDepositForm,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          //print(bankDepositForm.control('depositAmount').value);
                          await savePayments(
                              paymentMethod: 'Bank deposit',
                              amount: 'P 1,200,000');
                          successfulyPayedDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bhcRed,
                          textStyle: titleSmall(context).copyWith(
                              fontWeight: FontWeight.w100, color: kcWhiteColor),
                          padding: EdgeInsets.symmetric(
                              horizontal: 70, vertical: 15),
                        ),
                        child: Text(
                          'Pay',
                          style: titleSmall(context).copyWith(
                              fontWeight: FontWeight.w100, color: kcWhiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTenDaysAway() {
    DateTime date = DateTime.now().subtract(const Duration(days: 10));
    String formattedDate = DateFormat('dd-MMM-yyyy').format(date);
    return formattedDate; // format ----- 30-Jun-2024
  }

  String generateString() {
    String currentDate = DateFormat('yyyyMMdd').format(DateTime.now());
    int randomNumber = _random.nextInt(999) + 1;
    String sequenceString = randomNumber.toString().padLeft(3, '0');
    return 'RNT-$currentDate-$sequenceString';
  }

  String checkExpiryDate(String expiryDate) {
    // Parse the expiry date
    final now = DateTime.now();
    final parts = expiryDate.split('/');

    if (parts.length == 2) {
      final month = int.tryParse(parts[0]);
      final year = int.tryParse(parts[1]);

      if (month != null && year != null) {
        // Create a DateTime object for the last day of the expiry month
        final expiryDateTime = DateTime(2000 + year, month + 1, 0);

        // Compare the expiry date with the current date
        if (expiryDateTime.isBefore(now)) {
          return 'Expired';
        } else {
          return expiryDate;
        }
      }
    }

    // Return 'Expired' if the format is invalid
    return 'Expired';
  }
}
