import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/text_styles.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/common/buttons.dart';
import '../../widgets/common/form_fields/text_input_field.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo.png', width: 200),
              verticalSpaceLarge,
              SizedBox(
                width: 90.sw,
                child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(kPadding),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Login', style: titleMedium(context)),
                            verticalSpaceMedium,
                            Theme(
                              data: inputFieldTheme(context: context),
                              child: ReactiveForm(
                                  formGroup: viewModel.loginForm,
                                  child: Column(
                                    children: [
                                      TextInputField(
                                          config: {
                                            'name': 'email',
                                            'label': 'Email Address',
                                            'validationMessages': {
                                              ValidationMessage.email: (error) =>
                                              'Enter a valid email address',
                                              ValidationMessage.required: (error) =>
                                              'Please enter an email address'
                                            }
                                          },
                                          parentForm: viewModel.loginForm,
                                          prefixIcon: const Icon(
                                              FontAwesomeIcons.envelope)),
                                      verticalSpaceTiny,
                                      TextInputField(
                                          config: {
                                            'name': 'password',
                                            'label': 'Password',
                                            'validationMessages': {
                                              ValidationMessage.minLength:
                                                  (error) =>
                                              'Password too short',
                                              ValidationMessage.required:
                                                  (error) =>
                                              'Password is required'
                                            }
                                          },
                                          parentForm: viewModel.loginForm,
                                          isPassword: true,
                                          prefixIcon: const Icon(
                                              Icons.lock_outline)),
                                      verticalSpaceMedium,
                                      ReactiveFormConsumer(
                                          builder: (_, form, child) =>
                                              BusyButton(
                                                  onTap: form.valid
                                                      ? () =>
                                                      viewModel.login()
                                                      : null,
                                                  width: 80.sw,
                                                  label: 'Login',
                                                  isBusy: viewModel.isBusy)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () =>
                                                  viewModel.recoverPassword(),
                                              child: Text(
                                                'Recover Password',
                                                style: bodyText2(context)
                                                    .copyWith(
                                                  decoration: TextDecoration.underline,
                                                    decorationThickness: .2,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: bhcRed),
                                              ))
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Don\'t have an account yet?',
                                            style: bodyText2(context)
                                                .apply(fontSizeFactor: .85),
                                          ),
                                          TextButton(
                                              onPressed: () =>
                                                  viewModel.goToRegistrationPage(),
                                              child: Text(
                                                'Register ',
                                                style: bodyText2(context)
                                                    .copyWith(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: bhcRed),
                                              ))
                                        ],
                                      )
                                    ],
                                  )),
                            )
                          ]),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel(context);
}
