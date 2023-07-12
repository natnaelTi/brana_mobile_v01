import 'package:berana/features/genre_selection/genre_selection_view.dart';
import 'package:berana/features/language_selection/language_selection_viewmodel.dart';
import 'package:berana/features/signin_w_password/signin_w_password_view.dart';
import 'package:berana/features/test/test_view.dart';
import 'package:berana/layouts/root_layout/root_layout.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:berana/widgets/berana_button.dart';
import 'package:berana/widgets/berana_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LanguageSelectionView extends StatelessWidget {
  const LanguageSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LanguageSelectionViewModel>.reactive(
        viewModelBuilder: () => LanguageSelectionViewModel(),
        builder: ((context, viewModel, child) {
          return RootLayout(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/bg/language_selection_bg.png"),
                          fit: BoxFit.cover
                      )
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LanguageSelectionBox(viewModel: viewModel),
                          LanguageSelectionDropDown(viewModel: viewModel),
                          // BeranaDropDown(
                          //     dropDownItems: [
                          //       Text('test'), Text('test1')
                          //     ],
                          //     onChanged: () {
                          //       print('test');
                          //     },
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Image.asset(
                          //           viewModel.languages[viewModel.selectedLanguageIndex].iconPath,
                          //           width: 35,
                          //           height: 35,
                          //         ),
                          //         Text(viewModel.languages[viewModel.selectedLanguageIndex].name),
                          //             () {
                          //           switch(viewModel.dropDownOpen) {
                          //             case true:
                          //               return Icon(Icons.keyboard_arrow_up);
                          //             default:
                          //               return Icon(Icons.keyboard_arrow_down);
                          //           }
                          //         } ()
                          //       ],
                          //     )
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BeranaButton(
                              foregroundColor: BaseColors.primaryBerana,
                              backgroundColor: Colors.white,
                              pressedFunc: () {
                                viewModel.navigationService.navigateTo(SignInWPasswordView());
                              },
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Continue',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.arrow_forward)
                                    ],
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                  ]
                ),
              )
          );
        })
    );
  }
}

class LanguageSelectionBox extends StatelessWidget {
  final LanguageSelectionViewModel viewModel;
  LanguageSelectionBox({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
          children: [
            Text(
              viewModel.languageSelectionBoxHeader,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
              ),
            ),
            BeranaButton(
              backgroundColor: Colors.white,
              foregroundColor: BaseColors.primaryBerana,
              pressedFunc: () => viewModel.toggleDropDown(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    viewModel.languages[viewModel.selectedLanguageIndex].iconPath,
                    width: 35,
                    height: 35,
                  ),

                  Text(viewModel.languages[viewModel.selectedLanguageIndex].name),

                  () {
                    switch(viewModel.dropDownOpen) {
                      case true:
                        return Icon(Icons.keyboard_arrow_up);
                      default:
                        return Icon(Icons.keyboard_arrow_down);
                    }
                  } ()
                ],
              ),
            )
          ]
      ),
    );
  }
}

class LanguageSelectionDropDown extends StatelessWidget {
  final LanguageSelectionViewModel viewModel;
  LanguageSelectionDropDown({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return  Visibility(
      maintainState: true,
      maintainSize: true,
      maintainAnimation: true,
      visible: viewModel.dropDownOpen,
      child: Container(
          width: 150,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView.builder(
              itemCount: viewModel.languages.length,
              itemBuilder: (context, index) {
                return LanguageSelectionDropDownItem(
                  iconPath: viewModel.languages[index].iconPath,
                  name: viewModel.languages[index].name,
                );
              }
          )
      ),
    );
  }
}

class LanguageSelectionDropDownItem extends StatelessWidget {
  final String iconPath;
  final String name;
  LanguageSelectionDropDownItem({
    required this.iconPath,
    required this.name
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
            iconPath,
            height: 35,
            width: 35
        ),
        Text(name),
        Visibility(
            visible: false,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Icon(Icons.keyboard_arrow_up)
        )
      ],
    );
  }
}
