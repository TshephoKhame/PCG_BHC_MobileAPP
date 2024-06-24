import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../common/text_styles.dart';
import 'home_viewmodel.dart';

class TenantHomeView extends ViewModelWidget<HomeViewModel> {
  const TenantHomeView({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: Center(
          child: Text(
        'TenantHomeView',
        style: titleLarge(context),
      )),
    );
  }
}
