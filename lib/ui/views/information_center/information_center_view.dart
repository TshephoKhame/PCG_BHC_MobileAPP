import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'information_center_viewmodel.dart';

class InformationCenterView extends StackedView<InformationCenterViewModel> {
  const InformationCenterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InformationCenterViewModel viewModel,
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
  InformationCenterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      InformationCenterViewModel();
}
