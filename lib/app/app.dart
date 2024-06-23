import 'package:bhc_mobile/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:bhc_mobile/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:bhc_mobile/ui/views/home/home_view.dart';
import 'package:bhc_mobile/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bhc_mobile/services/local_database_service.dart';
import 'package:bhc_mobile/services/http_service.dart';
import 'package:bhc_mobile/services/feedback_service.dart';
import 'package:bhc_mobile/services/environment_service.dart';
import 'package:bhc_mobile/ui/views/register/register_view.dart';
import 'package:bhc_mobile/ui/views/login/login_view.dart';
import 'package:bhc_mobile/services/auth_service.dart';
import 'package:bhc_mobile/services/appwrite_service.dart';
import 'package:bhc_mobile/ui/views/complete_profile/complete_profile_view.dart';
import 'package:bhc_mobile/ui/views/maintenance_requests/maintenance_requests_view.dart';
import 'package:bhc_mobile/ui/views/payments/payments_view.dart';
import 'package:bhc_mobile/ui/views/information_center/information_center_view.dart';
import 'package:bhc_mobile/ui/views/reporting_analytics/reporting_analytics_view.dart';
// @stacked-import

@StackedApp(routes: [
  MaterialRoute(page: HomeView),
  MaterialRoute(page: StartupView),
  MaterialRoute(page: RegisterView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: CompleteProfileView),
  MaterialRoute(page: MaintenanceRequestsView),
  MaterialRoute(page: PaymentsView),
  MaterialRoute(page: InformationCenterView),
  MaterialRoute(page: ReportingAnalyticsView),
// @stacked-route
], dependencies: [
  LazySingleton(classType: BottomSheetService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: LocalDatabaseService),
  LazySingleton(classType: HttpService),
  LazySingleton(classType: FeedbackService),
  LazySingleton(classType: EnvironmentService),
  LazySingleton(classType: AuthService),
  LazySingleton(classType: AppwriteService),
// @stacked-service
], bottomsheets: [
  StackedBottomsheet(classType: NoticeSheet),
  // @stacked-bottom-sheet
], dialogs: [
  StackedDialog(classType: InfoAlertDialog),
  // @stacked-dialog
], logger: StackedLogger())
class App {}
