import 'package:bhc_mobile/app/app.router.dart';
import 'package:bhc_mobile/services/feedback_service.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  final _logger = getLogger('LoginViewModel');
  final _navigationService = locator<NavigationService>();
  final _feedbackService = locator<FeedbackService>();
  final _authService = locator<AuthService>();

  BuildContext context;
  LoginViewModel(this.context) {
    _feedbackService.init(context);
  }

  final FormGroup _loginForm = fb.group({
    'email': [Validators.required, Validators.email],
    'password': [Validators.required, Validators.minLength(6)],
  });

  FormGroup get loginForm => _loginForm;

  login() async {
    String email = _loginForm.control('email').value;
    String password = _loginForm.control('password').value;
    await runBusyFuture(_authService.login(e: email, p: password)).then((res) {
      bool success = res['success'];
      String msg = res['message'];
      if (success) {
        _feedbackService.showToast(context, ToastType.success, 'Welcome back!');
        _navigationService.replaceWithHomeView();
      } else {
        _feedbackService.showToast(
            context, ToastType.error, 'Login failed. $msg');
        _logger.e('Login failed $msg');
      }
    });
  }

  goToRegistrationPage() => _navigationService.replaceWithRegisterView();

  recoverPassword() async {
    await openBottomSheet(context,
        height: 50.sh,
        title: 'Recover Password', content: Container());
  }
}
