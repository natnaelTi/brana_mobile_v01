import 'package:berana/features/signin_w_password/signin_w_password_viewmodel.dart';
import 'package:berana/features/signup/signup_view.dart';
import 'package:berana/layouts/root_layout/root_layout.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:berana/widgets/berana_button.dart';
import 'package:berana/widgets/berana_textfield.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignInWPasswordView extends StatelessWidget {
  const SignInWPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInWithPasswordViewModel>.reactive(
        viewModelBuilder: () => SignInWithPasswordViewModel(),
        builder: (context, viewModel, child) {
          return RootLayout(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg/signup_signin_screen_bg.png"),
                    fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: BeranaTextField(
                                textEditingController: viewModel.emailController,
                                labelText: 'Email',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: BeranaTextField(
                                textEditingController: viewModel.passwordController,
                                labelText: 'Password',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BeranaButton(
                                      pressedFunc: () {
                                        viewModel.submit();
                                      },
                                      foregroundColor: Colors.white,
                                      backgroundColor: BaseColors.secondaryBerana,
                                      borderColor: BaseColors.secondaryBerana,
                                      width: 75,
                                      child: Center(
                                          child: Text('Sign In')
                                      ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23
                              )
                          ),
                          TextButton(
                            onPressed: () {
                              viewModel.navigationService.navigateTo(SignupView());
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 23,
                                  color: BaseColors.secondaryBerana,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 100)
                    ],
                  ),
                ],
              ),
            ));
        });
  }
}
