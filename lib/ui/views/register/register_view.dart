import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/widgets/common/buttons.dart';
import 'package:bhc_mobile/ui/widgets/common/form_fields/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'register_viewmodel.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
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
                            Text('Register', style: titleMedium(context)),
                            verticalSpaceMedium,
                            Theme(
                              data: inputFieldTheme(context: context),
                              child: ReactiveForm(
                                  formGroup: viewModel.registerForm,
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
                                          parentForm: viewModel.registerForm,
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
                                          parentForm: viewModel.registerForm,
                                          isPassword: true,
                                          prefixIcon: const Icon(
                                              Icons.lock_outline)),
                                      verticalSpaceTiny,
                                      TextInputField(
                                          config: {
                                            'name': 'confirmPassword',
                                            'label': 'Confirm Password',
                                            'validationMessages': {
                                              ValidationMessage.minLength:
                                                  (error) =>
                                                      'Password too short',
                                              ValidationMessage.required:
                                                  (error) =>
                                                      'Password is required',
                                              ValidationMessage.mustMatch:
                                                  (error) =>
                                                      'Passwords do not match'
                                            }
                                          },
                                          parentForm: viewModel.registerForm,
                                          isPassword: true,
                                          prefixIcon: const Icon(
                                              Icons.lock_outline)),
                                      verticalSpaceMedium,
                                      ReactiveCheckboxListTile(
                                        formControlName: 'terms',
                                        subtitle: Text(
                                          'By registering, I confirm that I have read and I agree with the Terms & Conditions',
                                          style: bodyText2(context)
                                              .apply(fontSizeFactor: 0.85),
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        activeColor: bhcRed,
                                        checkColor: kcWhiteColor,
                                      ),
                                      ReactiveFormConsumer(
                                          builder: (_, form, child) =>
                                              BusyButton(
                                                  onTap: form.valid
                                                      ? () =>
                                                          viewModel.register()
                                                      : null,
                                                  width: 80.sw,
                                                  label: 'Register',
                                                  isBusy: viewModel.isBusy)),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Already have an account?',
                                            style: bodyText2(context)
                                                .apply(fontSizeFactor: .85),
                                          ),
                                          TextButton(
                                              onPressed: () =>
                                                  viewModel.goToLoginPage(),
                                              child: Text(
                                                'Login ',
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
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel(context);
}
