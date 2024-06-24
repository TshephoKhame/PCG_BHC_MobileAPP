import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/text_styles.dart';
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
      body: Center(
          child: Text(
        'MaintenanceRequestsView',
        style: titleLarge(context),
      )),
    );
  }

  @override
  MaintenanceRequestsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MaintenanceRequestsViewModel();
}
