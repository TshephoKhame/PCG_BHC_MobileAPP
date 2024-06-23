import 'package:bhc_mobile/app/app.router.dart';
import 'package:bhc_mobile/services/feedback_service.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../services/auth_service.dart';

class RegisterViewModel extends BaseViewModel {
  final _logger = getLogger('RegisterViewModel');
  final _feedbackService = locator<FeedbackService>();
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  BuildContext context;
  RegisterViewModel(this.context) {
    _feedbackService.init(context);
  }

  final FormGroup _registerForm = fb.group({
    'email': [Validators.required, Validators.email],
    'password': [Validators.required, Validators.minLength(6)],
    'confirmPassword': [Validators.required],
    'terms': FormControl<bool>(value: false, validators: [Validators.required])
  }, [
    Validators.mustMatch('password', 'confirmPassword')
  ]);

  FormGroup get registerForm => _registerForm;

  register() async {
    _logger.i(prettyJSON(_registerForm.value));
  }

  goToLoginPage() => _navigationService.replaceWithLoginView();
}
