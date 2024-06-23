import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'complete_profile_viewmodel.dart';

class CompleteProfileView extends StackedView<CompleteProfileViewModel> {
  const CompleteProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CompleteProfileViewModel viewModel,
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
  CompleteProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CompleteProfileViewModel();
}
