import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/views/payments/payments_viewmodel.dart';
import 'package:bhc_mobile/ui/widgets/common/buttons.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'payment_history_card_model.dart';

class PaymentHistoryCard extends StackedView<PaymentHistoryCardModel> {
  final Map<String, dynamic> paymentOption;
  const PaymentHistoryCard({super.key, required this.paymentOption});

  @override
  Widget builder(
    BuildContext context,
    PaymentHistoryCardModel viewModel,
    Widget? child,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Rent Payment',
                          style: bodyText1(context)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount:',
                          style: tinyText(context),
                        ),
                        horizontalSpaceTiny,
                        Text(
                          paymentOption['Amount'],
                          style: tinyText(context),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status:',
                          style: tinyText(context),
                        ),
                        horizontalSpaceTiny,
                        Text(
                          'Successful',
                          style: tinyText(context).copyWith(color: bhcGreen),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          size: generalIconSizeSmall,
                          color: bhcYellow,
                        ),
                        horizontalSpaceTiny,
                        Text(
                          paymentOption['DatePayed'],
                          style: tinyText(context),
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Method:',
                          style: tinyText(context),
                        ),
                        horizontalSpaceTiny,
                        Text(
                          paymentOption['PaymentMethod'],
                          style: tinyText(context),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Receipt Number:',
                          style: tinyText(context),
                        ),
                        horizontalSpaceTiny,
                        Text(
                          paymentOption['ReceiptNumber'],
                          style: tinyText(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                  ],
                )
              ],
            ),
            CustomMaterialButton(
              onTap: () {},
              label: 'Download',
              labelColor: kcWhiteColor,
              color: bhcYellow,
              height: 30,
              textStyle: tinyText(context).copyWith(
                color: kcWhiteColor,
              ),
              width: 90,
              icon: Icons.download,
              borderRadius: 25,
            ),
          ],
        ),
      ),
    );
  }

  @override
  PaymentHistoryCardModel viewModelBuilder(
    BuildContext context,
  ) =>
      PaymentHistoryCardModel();
}
