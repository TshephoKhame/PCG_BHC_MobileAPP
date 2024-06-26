import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/views/payments/payments_viewmodel.dart';
import 'package:bhc_mobile/ui/views/payments/widgets/tps_history_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/text_styles.dart';

class TPSView extends StackedView<PaymentsViewModel> {
  const TPSView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PaymentsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Column(
        children: [
          _topBanner(context, viewModel),
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
                        'TPS History',
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Total Paid: P${viewModel.totalPaid}',
                        style: subtitle2(context),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Remaining Balance: P${viewModel.remainingBalance}',
                        style: subtitle2(context),
                      ),
                    ),
                    verticalSpaceSmall,
                    if (viewModel.tpsOptions.contains(null))
                      ...viewModel.tpsOptions.map(
                        (tpsOption) {
                          return TPSHistoryCard(tpsOption: tpsOption!);
                        },
                      ),
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

_topBanner(context, viewModel) {
  double percentageCompleted = viewModel.totalPaid / viewModel.remainingBalance;
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        gradient: createLinearGradient(color1: bhcYellow, color2: bhcRed),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Column(
            children: [
              Text(
                'TPS Payment Status',
                style: titleSmall(context).copyWith(
                  color: kcWhiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'P1,200,000',
                style: titleSmall(context).copyWith(
                  color: kcWhiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: kcWhiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Text(
                  'Due: ${viewModel.paymentDueDate}',
                  style: bodyText2(context).copyWith(
                    color: bhcRed,
                  ),
                ),
              ),
              verticalSpaceSmall,
              ElevatedButton.icon(
                onPressed: () {
                  viewModel.isTPSPayment = 'TPS';
                  viewModel.showPayNowDialog();
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
  );
}
