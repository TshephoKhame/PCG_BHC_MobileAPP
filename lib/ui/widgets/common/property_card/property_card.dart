import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'property_card_model.dart';

class PropertyCard extends StackedView<PropertyCardModel> {
  const PropertyCard({super.key});

  @override
  Widget builder(
    BuildContext context,
    PropertyCardModel viewModel,
    Widget? child,
  ) {
    return const SizedBox.shrink();
  }

  @override
  PropertyCardModel viewModelBuilder(
    BuildContext context,
  ) =>
      PropertyCardModel();
}
