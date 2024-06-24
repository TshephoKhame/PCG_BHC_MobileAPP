import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/widgets/common/buttons.dart';
import 'package:bhc_mobile/ui/widgets/common/payment_history_card/payment_history_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/text_styles.dart';
import 'payments_viewmodel.dart';

class PaymentsView extends StackedView<PaymentsViewModel> {
  const PaymentsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PaymentsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient:
                      createLinearGradient(color1: bhcYellow, color2: bhcRed)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Rent Payment Status',
                        style: titleSmall(context).copyWith(
                            color: kcWhiteColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'P1,200,000',
                        style: titleSmall(context).copyWith(
                            color: kcWhiteColor, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: kcWhiteColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Text(
                          'Due: ${viewModel.paymentTenDaysAway}',
                          style: bodyText2(context).copyWith(
                            color: bhcRed,
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement download functionality
                          viewModel.showPayNowDialog(context);
                        },
                        label: const Text('Pay Now'),
                        style: ElevatedButton.styleFrom(
                          textStyle: tinyText(context),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          backgroundColor: bhcYellow,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    verticalSpaceSmall,
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Payment History',
                        style: subtitle1(context),
                      ),
                    ),
                    verticalSpaceTiny,
                    const Divider(
                      color: kcAmber,
                      endIndent: 0,
                      indent: 0,
                      height: 0.2,
                      thickness: 0.2,
                    ),
                    PaymentHistoryCard(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PaymentsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PaymentsViewModel(context);
}

Widget _paymentHistoryCard(context) {
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
