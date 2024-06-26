import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/views/payments/payments_view_tps.dart';
import 'package:bhc_mobile/ui/views/payments/widgets/tps_history_card.dart';
import 'package:bhc_mobile/ui/widgets/common/buttons.dart';
import 'package:bhc_mobile/ui/widgets/common/payment_history_card/payment_history_card.dart';
import 'package:flutter/material.dart';
import 'package:gleap_sdk/gleap_sdk.dart';
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
                    ...viewModel.paymentOption.map(
                      (paymentOption) {
                        return PaymentHistoryCard(
                            paymentOption: paymentOption!);
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
  return ClipRRect(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    ),
    child: Container(
      decoration: BoxDecoration(
          gradient: createLinearGradient(color1: bhcYellow, color2: bhcRed)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Column(
            children: [
              Text(
                'Rent Payment Status',
                style: titleSmall(context)
                    .copyWith(color: kcWhiteColor, fontWeight: FontWeight.bold),
              ),
              Text(
                'P1,200,000',
                style: titleSmall(context)
                    .copyWith(color: kcWhiteColor, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  color: kcWhiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
                  viewModel.isTPSPayment = 'Rent';
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
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const TPSView(),
                    ),
                  );
                },
                label: const Text('go'),
                style: ElevatedButton.styleFrom(
                  textStyle: tinyText(context),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  backgroundColor: bhcRed,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement download functionality
                  viewModel.clearDB();
                },
                label: const Text('clear db'),
                style: ElevatedButton.styleFrom(
                  textStyle: tinyText(context),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  backgroundColor: bhcRed,
                  foregroundColor: Colors.white,
                ),
              ),
              GleapBtn(),
            ],
          ),
        ),
      ),
    ),
  );
}

class GleapBtn extends StatefulWidget {
  const GleapBtn({super.key});

  @override
  State<GleapBtn> createState() => _GleapBtnState();
}

class _GleapBtnState extends State<GleapBtn> {
  final double padding = 25;
  bool State = false;
  void toggleMenu() {
    setState(() {
      State = !State;
      print(State);
    });
  }

  @override
  Widget build(BuildContext context) {
    Gleap.registerListener(
      actionName: 'widgetClosed',
      callbackHandler: (_) {
        toggleMenu();
      },
    );
    Gleap.registerListener(
      actionName: 'widgetOpened',
      callbackHandler: (_) {
        toggleMenu();
      },
    );

    return ElevatedButton(
      onPressed: () async => {
        State ? Gleap.close() : Gleap.open(),
      },
      style: ElevatedButton.styleFrom(
        textStyle: tinyText(context),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        backgroundColor: bhcYellow,
        foregroundColor: Colors.white,
      ),
      child: State ? const Text('Close') : const Text('Open'),
    );
  }
}
