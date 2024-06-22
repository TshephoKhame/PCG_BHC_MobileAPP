import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../services/auth_service.dart';

class RegisterViewModel extends BaseViewModel {
  final _logger = getLogger('RegisterViewModel');
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();


}
