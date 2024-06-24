import 'package:bhc_mobile/ui/views/home/home_view.customer.dart';
import 'package:bhc_mobile/ui/views/home/home_view.tenant.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: viewModel.pageIndex == 0
          ? viewModel.isTenant
              ? const TenantHomeView()
              : const CustomerHomeView()
          : viewModel.pages[viewModel.pageIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        barColor: bhcRed,
        controller: FloatingBottomBarController(initialIndex: 0),
        bottomBar: [
          BottomBarItem(
            icon: const Icon(Icons.home, size: 25),
            iconSelected: const Icon(Icons.home, color: bhcYellow, size: 25),
            dotColor: bhcYellow,
            onTap: (value) {
              viewModel.setPageIndex = 0;
            },
          ),
          BottomBarItem(
            icon: const Icon(Icons.payment, size: 25),
            iconSelected: const Icon(Icons.payment, color: bhcYellow, size: 25),
            dotColor: bhcYellow,
            onTap: (value) {
              viewModel.setPageIndex = 1;
            },
          ),
          BottomBarItem(
            icon: const Icon(FontAwesomeIcons.screwdriverWrench, size: 25),
            iconSelected: const Icon(FontAwesomeIcons.screwdriverWrench,
                color: bhcYellow, size: 25),
            dotColor: bhcYellow,
            onTap: (value) {
              viewModel.setPageIndex = 2;
            },
          ),
          BottomBarItem(
            icon: const Icon(Icons.help_outline, size: 25),
            iconSelected:
                const Icon(Icons.help_outline, color: bhcYellow, size: 25),
            title: 'Information',
            dotColor: bhcYellow,
            onTap: (value) {
              viewModel.setPageIndex = 3;
            },
          ),
        ],
        bottomBarCenterModel: BottomBarCenterModel(
          centerBackgroundColor: bhcRed,
          centerIcon: const FloatingCenterButton(
            child: Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
          centerIconChild: [
            FloatingCenterButtonChild(
              child: const Icon(
                Icons.home,
                color: AppColors.white,
              ),
              onTap: () {},
            ),
            FloatingCenterButtonChild(
              child: const Icon(
                Icons.access_alarm,
                color: AppColors.white,
              ),
              onTap: () {},
            ),
            FloatingCenterButtonChild(
              child: const Icon(
                Icons.ac_unit_outlined,
                color: AppColors.white,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel(context);
}
