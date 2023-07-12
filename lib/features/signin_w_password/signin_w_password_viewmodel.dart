import 'package:flutter/material.dart';
import 'package:berana/features/signin_w_password/signin_w_service.dart';
import 'package:berana/shared/custom_reactive_viewmodel.dart';
import 'package:berana/shared/extensions.dart';
import 'package:stacked/stacked.dart';

class SignInWithPasswordViewModel extends CustomReactiveViewModel {
  bool _showPassword = false;
  bool get showPassword => _showPassword;
  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void validate() {
    String email = emailController.text;
    String password = passwordController.text;
    if (email.isEmpty || password.isEmpty)
      throw ('Email & Password are required');
    if (!email.validateEmail()) throw ('Invalid Email');
    if (!password.validatePassword()) throw ('Invalid Password');
  }

  void submit() async {
    try {
      validate();
      String email = emailController.text;
      String password = passwordController.text;

      var response = await SignInService.signInWithPassword(
          email: email, password: password);

      if (response.success == false) throw ('Failed to Sign In, Try Again');
      // userStore.setAccessToken(value: response.accessToken!);
      dialogueService.showSuccessDialogue(
          title: 'Success',
          description: 'Signed In Successfully' +
              '\n' +
              'Access Token: ' +
              response.accessToken!);
    } catch (e) {
      dialogueService.showErrorDialogue(
          title: 'Error', description: e.toString());
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
