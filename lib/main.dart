import 'package:bhc_mobile/services/local_database_service.dart';
import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bhc_mobile/app/app.bottomsheets.dart';
import 'package:bhc_mobile/app/app.dialogs.dart';
import 'package:bhc_mobile/app/app.locator.dart';
import 'package:bhc_mobile/app/app.router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked_services/stacked_services.dart';

final _db = locator<LocalDatabaseService>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  await _db.init();
  // await _db.cleanDb();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
        builder: (_) => MaterialApp(
              initialRoute: Routes.startupView,
              onGenerateRoute: StackedRouter().onGenerateRoute,
              navigatorKey: StackedService.navigatorKey,
              debugShowCheckedModeBanner: false,
              // debugShowMaterialGrid: true,
              // showPerformanceOverlay: true,
              theme: ThemeData(
                  scaffoldBackgroundColor: kcMainBackgroundColor,
                  fontFamily: 'Nunito',
                  primaryColor: bhcRed),
              navigatorObservers: [
                StackedService.routeObserver,
              ],
            ));
  }
}
