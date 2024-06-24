import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/widgets/common/buttons.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'payment_history_card_model.dart';

class PaymentHistoryCard extends StackedView<PaymentHistoryCardModel> {
  const PaymentHistoryCard({super.key});

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
                          '₱ 1,200.00',
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
                          'February 1, 2024',
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
                          'Credit Card (Visa)',
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
                          'RNT-20240101-001',
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
