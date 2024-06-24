import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/views/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CustomerHomeView extends ViewModelWidget<HomeViewModel> {
  const CustomerHomeView({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: Center(
          child: Text(
        'CustomerHomeView',
        style: titleLarge(context),
      )),
    );
  }
}
