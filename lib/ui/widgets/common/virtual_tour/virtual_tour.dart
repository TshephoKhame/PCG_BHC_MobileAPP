import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'virtual_tour_model.dart';

class VirtualTour extends StackedView<VirtualTourModel> {
  const VirtualTour({super.key});

  @override
  Widget builder(
    BuildContext context,
    VirtualTourModel viewModel,
    Widget? child,
  ) {
    return const SizedBox.shrink();
  }

  @override
  VirtualTourModel viewModelBuilder(
    BuildContext context,
  ) =>
      VirtualTourModel();
}
