import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  PaymentsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PaymentsViewModel();
}
