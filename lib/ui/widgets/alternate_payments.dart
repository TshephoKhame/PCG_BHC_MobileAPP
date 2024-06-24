import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/widgets/common/payment_options_widget/payment_options_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AlternatePaymentOptionsWidget
    extends StackedView<PaymentOptionsWidgetModel> {
  final String paymentOptions;
  const AlternatePaymentOptionsWidget(
      {required this.paymentOptions, super.key});

  @override
  Widget builder(
    BuildContext context,
    PaymentOptionsWidgetModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: paymentOptions == 'OrangeMoney'
                      ? Image.asset('assets/images/Orange_money.png',
                          width: screenWidth(context))
                      : Image.asset('assets/images/my_zaka.png',
                          width: screenWidth(
                              context)), // Placeholder for MyZaka logo,),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Payment Details',
              style: titleMedium(context),
            ),
            verticalSpaceMedium,
            Text(
              'Phone Number',
              style: bodyText1(context),
            ),
            Text(
              '72 348 306',
              style: bodyText1(context),
            ),
            verticalSpaceMedium,
            Text(
              'Once you have completed the payment, please upload a proof of payment document.',
              style: tinyText(context),
            ),
            verticalSpaceSmall,
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: bhcRed,
                  foregroundColor: kcWhiteColor,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  PaymentOptionsWidgetModel viewModelBuilder(
    BuildContext context,
  ) =>
      PaymentOptionsWidgetModel();
}
