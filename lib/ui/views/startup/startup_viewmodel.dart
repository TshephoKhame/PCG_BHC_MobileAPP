import 'package:bhc_mobile/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:bhc_mobile/app/app.locator.dart';
import 'package:bhc_mobile/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.logger.dart';

class StartupViewModel extends BaseViewModel {
  final _logger = getLogger('StartupViewModel');
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    if(_authService.authenticated){
      _navigationService.replaceWithHomeView();
    }else{
      _logger.d('User not logged in...');
      _navigationService.replaceWithRegisterView();
    }
  }
}
