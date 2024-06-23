import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'maintenance_requests_viewmodel.dart';

class MaintenanceRequestsView
    extends StackedView<MaintenanceRequestsViewModel> {
  const MaintenanceRequestsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MaintenanceRequestsViewModel viewModel,
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
  MaintenanceRequestsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MaintenanceRequestsViewModel();
}
