import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/views/payments/payments_viewmodel.dart';
import 'package:bhc_mobile/ui/widgets/common/form_fields/file_upload_field.dart';
import 'package:bhc_mobile/ui/widgets/common/payment_options_widget/payment_options_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class AlternatePaymentOptionsWidget
    extends StackedView<PaymentOptionsWidgetModel> {
  final String paymentOptions;
  final PaymentsViewModel vm;

  const AlternatePaymentOptionsWidget(
      {required this.vm, required this.paymentOptions, super.key});

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
                    color: kcWhiteColor,
                    child: paymentOptions == 'OrangeMoney'
                        ? Container(
                            height: 100,
                            child: Image.asset(
                              'assets/images/Orange_money.png',
                              width: screenWidth(context),
                              fit: BoxFit.fitWidth,
                            ),
                          )
                        : Container(
                            height: 100,
                            child: Image.asset(
                              'assets/images/my_zaka.png',
                              width: screenWidth(context),
                            ),
                          )),
              ),
            ),
            const SizedBox(height: 20),
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
              textAlign: TextAlign.center,
              'Once you have completed the payment, please upload a proof of payment document.',
              style: tinyText(context),
            ),
            verticalSpaceSmall,
            ReactiveForm(
              formGroup: vm.uploadPoPForm,
              child: Column(
                children: [
                  FileUploadField(
                    config: {
                      'name': 'upload',
                      'label': 'Uplaod File',
                      'validationMessages': {
                        ValidationMessage.required: (error) =>
                            'Please enter an email address'
                      }
                    },
                    parentForm: vm.uploadPoPForm,
                  ),
                ],
              ),
            ),
            verticalSpaceSmall,
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await vm.savePayments(
                      paymentMethod: paymentOptions, amount: 'P1,200,000');
                  vm.successfulyPayedDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: bhcRed,
                  foregroundColor: kcWhiteColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                ),
                child: const Text('Submit'),
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
