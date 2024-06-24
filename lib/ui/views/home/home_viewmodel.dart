import 'package:bhc_mobile/app/app.bottomsheets.dart';
import 'package:bhc_mobile/app/app.dialogs.dart';
import 'package:bhc_mobile/app/app.locator.dart';
import 'package:bhc_mobile/ui/common/app_strings.dart';
import 'package:bhc_mobile/ui/views/home/home_view.dart';
import 'package:bhc_mobile/ui/views/information_center/information_center_view.dart';
import 'package:bhc_mobile/ui/views/maintenance_requests/maintenance_requests_view.dart';
import 'package:bhc_mobile/ui/views/payments/payments_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.logger.dart';
import '../../../services/feedback_service.dart';

class HomeViewModel extends BaseViewModel {
  final _logger = getLogger('HomeViewModel');
  final _feedbackService = locator<FeedbackService>();

  BuildContext context;
  HomeViewModel(this.context) {
    _feedbackService.init(context);
  }

  bool get isTenant => false;

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set setPageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  List<Widget> get pages => _pages;
  final List<Widget> _pages = const [
    HomeView(),
    PaymentsView(),
    MaintenanceRequestsView(),
    InformationCenterView()
  ];
}
