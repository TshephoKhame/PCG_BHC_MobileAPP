import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/views/payments/payments_viewmodel.dart';
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
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      leading: Image.asset('assets/images/visa_card.png',
                          width: 40), // Placeholder for Visa logo
                      title: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Card ending with **** 1234',
                          style: tinyText(context),
                        ),
                      ),
                      subtitle: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Expired',
                          style: tinyText(context),
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          textStyle: tinyText(context)
                              .copyWith(fontWeight: FontWeight.w100),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          backgroundColor: bhcRed,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Remove'),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      leading: Image.asset('assets/images/visa_card.png',
                          width: 40), // Placeholder for Visa logo
                      title: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Card ending with **** 5874',
                          style: tinyText(context),
                        ),
                      ),
                      subtitle: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '07/25',
                          style: tinyText(context),
                        ),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: tinyText(context)
                              .copyWith(fontWeight: FontWeight.w100),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          backgroundColor: bhcYellow,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: Text('Pay'),
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
                Image.asset('assets/images/master_card.png',
                    width: 55), // Placeholder for MasterCard logo
                Image.asset('assets/images/visa_card.png',
                    width: 55), // Placeholder for Visa logo
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop('OrangeMoney');
                  },
                  child:
                      Image.asset('assets/images/Orange_money.png', width: 55),
                ), // Placeholder for another payment option logo
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pop('MyZaka');
                    vm.showAlternatePaymentDialog(context, 'MyZaka');
                  },
                  child: Image.asset('assets/images/my_zaka.png', width: 55),
                ), // Placeholder for MyZaka logo
              ],
            ),
            verticalSpaceSmall,
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  textStyle:
                      tinyText(context).copyWith(fontWeight: FontWeight.w100),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  backgroundColor: bhcYellow,
                  foregroundColor: Colors.white,
                ),
                child: Text(
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
                onPressed: () {},
                child: Text('Add New Card'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: bhcRed,
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
