import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/views/payments/payments_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddPaymentCard extends StatefulWidget {
  final PaymentsViewModel vm;
  const AddPaymentCard({super.key, required this.vm});

  @override
  State<AddPaymentCard> createState() => _AddPaymentCardState();
}

class _AddPaymentCardState extends State<AddPaymentCard> {
  bool isLightTheme = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = false;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
          showBackView: true,
          onCreditCardWidgetChange: (_) {},
          // floatingConfig: const FloatingConfig(
          //   isGlareEnabled: true,
          //   isShadowEnabled: true,
          //   shadowConfig: FloatingShadowConfig(
          //     offset: Offset(10, 10),
          //     color: kcBlack,
          //     blurRadius: 15,
          //   ),
          // ),
          enableFloatingCard: true,
          cardNumber: cardNumber, // Required
          expiryDate: expiryDate, // Required
          cardHolderName: cardHolderName, // Required
          cvvCode: cvvCode, // Required
          backgroundImage: 'assets/images/card_bg.png',
          glassmorphismConfig: Glassmorphism(
            blurX: 1.0,
            blurY: 1.0,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.grey.withAlpha(20),
                Colors.white.withAlpha(20),
              ],
              stops: const <double>[
                0.3,
                0,
              ],
            ),
          ),
        ),
        CreditCardForm(
          formKey: formKey, // Required
          cardNumber: cardNumber, // Required
          expiryDate: expiryDate, // Required
          cardHolderName: cardHolderName, // Required
          cvvCode: cvvCode, // Required

          onCreditCardModelChange: onCreditCardModelChange,
          obscureCvv: true,
          obscureNumber: true,
          isHolderNameVisible: true,
          isCardNumberVisible: true,
          isExpiryDateVisible: true,
          enableCvv: true,
          cvvValidationMessage: 'Please input a valid CVV',
          dateValidationMessage: 'Please input a valid date',
          numberValidationMessage: 'Please input a valid number',
          cardNumberValidator: (String? cardNumber) {},
          expiryDateValidator: (String? expiryDate) {},
          cvvValidator: (String? cvv) {},
          cardHolderValidator: (String? cardHolderName) {},
          onFormComplete: () {
            // callback to execute at the end of filling card data
          },
          autovalidateMode: AutovalidateMode.always,
          disableCardNumberAutoFillHints: false,
          inputConfiguration: InputConfiguration(
            cardNumberDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Number',
              hintText: 'XXXX XXXX XXXX XXXX',
              labelStyle: tinyText(context),
              constraints: BoxConstraints(maxHeight: 35),
            ),
            expiryDateDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Expired Date',
              hintText: 'XX/XX',
              labelStyle: tinyText(context),
              constraints: BoxConstraints(maxHeight: 35),
            ),
            cvvCodeDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CVV',
              hintText: 'XXX',
              labelStyle: tinyText(context),
              constraints: BoxConstraints(maxHeight: 35),
            ),
            cardHolderDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Card Holder',
              labelStyle: tinyText(context),
              constraints: BoxConstraints(maxHeight: 35),
            ),
            cardNumberTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
            cardHolderTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
            expiryDateTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
            cvvCodeTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        ),
        verticalSpaceSmall,
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await widget.vm.saveCard(
                  cardNumber:
                      cardNumber.isEmpty ? '1234567890123456' : cardNumber,
                  expiryDate: expiryDate);
              widget.vm.showCardProccessingPaymentDialog();
            },
            child: Text('Submit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: bhcRed,
              foregroundColor: kcWhiteColor,
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    print(creditCardModel.cardNumber);
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
