import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'reporting_analytics_viewmodel.dart';

class ReportingAnalyticsView extends StackedView<ReportingAnalyticsViewModel> {
  const ReportingAnalyticsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ReportingAnalyticsViewModel viewModel,
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
  ReportingAnalyticsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ReportingAnalyticsViewModel();
}
