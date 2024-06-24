import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/views/payments/payments_viewmodel.dart';
import 'package:bhc_mobile/ui/views/payments/widgets/saved_payment_cards.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'payment_options_widget_model.dart';

class PaymentOptionsWidget extends StackedView<PaymentOptionsWidgetModel> {
  final PaymentsViewModel vm;
  const PaymentOptionsWidget({required this.vm, super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Saved Cards',
                        style: subtitle1(context),
                      ),
                    ),
                    ...vm.savedCards.map(
                      (savedCards) {
                        return SavedPaymentCards(
                            savedCards: savedCards, vm: vm);
                      },
                    ),
                    if (vm.savedCards.isEmpty)
                      Container(
                        height: 60,
                        child: Center(
                          child: Text('No Cards Available'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Other Payment options',
                style: titleSmall(context),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pop('OrangeMoney');
                    vm.showAlternatePaymentDialog('OrangeMoney');
                  },
                  child:
                      Image.asset('assets/images/Orange_money.png', width: 70),
                ), // Placeholder for another payment option logo
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pop('MyZaka');
                    vm.showAlternatePaymentDialog('MyZaka');
                  },
                  child: Image.asset('assets/images/my_zaka.png', width: 70),
                ), // Placeholder for MyZaka logo
              ],
            ),
            verticalSpaceSmall,
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  vm.showBankDepositDialog();
                },
                style: ElevatedButton.styleFrom(
                  textStyle:
                      tinyText(context).copyWith(fontWeight: FontWeight.w100),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  backgroundColor: bhcYellow,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Bank Deposit',
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: titleMedium(context),
                ),
                Text(
                  'P 1,200.00',
                  style: titleMedium(context),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  vm.showAddCardDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: bhcRed,
                  textStyle: titleSmall(context).copyWith(
                      fontWeight: FontWeight.w100, color: kcWhiteColor),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                ),
                child: Text(
                  'Add New Card',
                  style: titleSmall(context).copyWith(
                      fontWeight: FontWeight.w100, color: kcWhiteColor),
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
