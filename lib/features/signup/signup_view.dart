import 'package:auto_size_text/auto_size_text.dart';
import 'package:berana/features/signup/signup_viewmodel.dart';
import 'package:berana/layouts/root_layout/root_layout.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:berana/widgets/berana_button.dart';
import 'package:berana/widgets/berana_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
        viewModelBuilder: () => SignupViewModel(),
        builder: (context, viewModel, child) {
          return RootLayout(
            showBackButton: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/bg/signup_signin_screen_bg.png"),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SignupViewHeader(viewModel: viewModel)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 25, color: Colors.white)
                          )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      () {
                        switch(viewModel.indexSignupPage) {
                          case 0:
                            return SignupFirstStep(viewModel: viewModel);
                          default:
                            return SignupSecondStep(viewModel: viewModel);
                        }
                      } (),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: viewModel.indexSignupPage == 1,
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              child: BeranaButton(
                                  pressedFunc: () {
                                    viewModel.toggleIndex();
                                  },
                                  foregroundColor: Colors.white,
                                  backgroundColor: BaseColors.secondaryBerana,
                                  borderColor: BaseColors.secondaryBerana,
                                  width: 75,
                                  child: Center(
                                      child: Text('Prev')
                                  ),
                              ),
                            ),
                            BeranaButton(
                              pressedFunc: () {
                                switch(viewModel.indexSignupPage) {
                                  case 0:
                                    viewModel.toggleIndex();
                                    break;
                                  default:
                                    viewModel.submit();
                                }
                              },
                              foregroundColor: Colors.white,
                              backgroundColor: BaseColors.secondaryBerana,
                              borderColor: BaseColors.secondaryBerana,
                              width: 75,
                              child: Center(
                                  child: () {
                                    switch(viewModel.indexSignupPage) {
                                      case 0:
                                        return Text('Next');
                                      default:
                                        return Text('Sign Up');
                                    }
                                  } ()
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class SignupFirstStep extends StatelessWidget {
  final SignupViewModel viewModel;
  SignupFirstStep({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Column(
        children: [
          BeranaTextField(
            labelText: 'First Name',
            textEditingController: viewModel.firstNameTEC,
          ),
          BeranaTextField(
            labelText: 'Last Name',
            textEditingController: viewModel.lastNameTEC,
          ),
          BeranaTextField(
            labelText: 'Phone number (optional)',
            textEditingController: viewModel.phoneNumberTEC,
          ),
        ],
      ),
    );
  }
}

class SignupSecondStep extends StatelessWidget {
  final SignupViewModel viewModel;
  SignupSecondStep({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Column(
        children: [
          BeranaTextField(
            labelText: 'Email',
            textEditingController: viewModel.emailTEC,
          ),
          BeranaTextField(
            labelText: 'Password',
            textEditingController: viewModel.passwordTEC,
          ),
          BeranaTextField(
            labelText: 'Confirm Password',
            textEditingController: viewModel.confirmPasswordTEC,
          ),
        ],
      ),
    );
  }
}

class SignupViewHeader extends StatelessWidget {
  final SignupViewModel viewModel;
  SignupViewHeader({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: 120,
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            child: GestureDetector(
              onTap: () => viewModel.navigationService.pop(),
              child: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
