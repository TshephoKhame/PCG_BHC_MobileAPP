import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/widgets/alternate_payments.dart';
import 'package:bhc_mobile/ui/widgets/common/payment_options_widget/payment_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class PaymentsViewModel extends BaseViewModel {
  late String paymentTenDaysAway;

  BuildContext context;
  PaymentsViewModel(this.context) {
    paymentTenDaysAway = formatTenDaysAway();
  }
  showPayNowDialog(context) async {
    await openBottomSheet(context,
        title: 'Payment Options',
        // ignore: prefer_const_constructors
        content: Center(
          child: PaymentOptionsWidget(vm: this),
        )).then(
      (paymentOptions) => {
        if (paymentOptions == 'OrangeMoney' || paymentOptions == 'MyZaka')
          {
            showAlternatePaymentDialog(context, paymentOptions),
          },
      },
    );
  }

  showAlternatePaymentDialog(context, String paymentOptions) async {
    Navigator.pop(context);
    await openBottomSheet(context,
        title: '',
        // ignore: prefer_const_constructors
        content: Center(
          child: AlternatePaymentOptionsWidget(paymentOptions: paymentOptions),
        )).then(
      (payed) => {
        if (payed == true)
          {
            successfulyPayedDialog(context),
          },
      },
    );
  }

  showAddCardDialog(context) async {
    await openBottomSheet(context,
        title: 'Payment Options',
        // ignore: prefer_const_constructors
        content: Center(
          child: PaymentOptionsWidget(vm: this),
        )).then(
      (paymentOptions) => {
        Navigator.pop(context),
        if (paymentOptions == '') {},
      },
    );
  }

  successfulyPayedDialog(context) async {
    await openBottomSheet(context,
        title: '',
        height: 200,
        // ignore: prefer_const_constructors
        content: Center(
          child: Column(
            children: [
              const Icon(
                Icons.check,
                size: 25,
                color: bhcGreen,
              ),
              verticalSpaceTiny,
              Text(
                'Payment Successful',
                style: titleMedium(context),
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
        )).then(
      (paymentOptions) => {
        Navigator.pop(context),
        if (paymentOptions == '') {},
      },
    );
  }

  String formatTenDaysAway() {
    DateTime date = DateTime.now().subtract(const Duration(days: 50));
    String formattedDate = DateFormat('dd-MMM-yyyy').format(date);
    return formattedDate; // Outputs: 30-Jun-2024 (assuming today is 19-Aug-2024)
  }
}
