import 'package:bhc_mobile/services/auth_service.dart';
import 'package:bhc_mobile/services/local_database_service.dart';
import 'package:gleap_sdk/gleap_sdk.dart';
import 'package:stacked/stacked.dart';
import 'package:bhc_mobile/app/app.locator.dart';
import 'package:bhc_mobile/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.logger.dart';

class StartupViewModel extends BaseViewModel {
  final _logger = getLogger('StartupViewModel');
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _dbService = locator<LocalDatabaseService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    // if (_authService.authenticated) {
    //   bool profileCreated =
    //       await _dbService.get(key: 'profileCreated') ?? false;
    //   if (profileCreated) {
    //     _navigationService.replaceWithHomeView();
    //   } else {
    //     _logger.d('Profile not created..going to profile creation page');
    //     _navigationService.replaceWithCompleteProfileView();
    //   }
    // } else {
    //   _logger.d('User not logged in...');
    //   _navigationService.replaceWithRegisterView();
    // }

    _navigationService.replaceWithPaymentsView();
  }
}
