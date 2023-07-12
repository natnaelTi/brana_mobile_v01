import 'package:berana/features/language_selection/language_selection_view.dart';
import 'package:berana/features/splash_screen/splash_screen_viewmodel.dart';
import 'package:berana/layouts/root_layout/root_layout.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:berana/widgets/berana_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      builder: ((context, viewModel, child) {
        return RootLayout(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg/splash_screen_bg.png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BeranaButton(
                  pressedFunc: () {
                    viewModel.navigationService.navigateTo(LanguageSelectionView());
                  },
                  foregroundColor: BaseColors.primaryBerana,
                  backgroundColor: Colors.transparent,
                  borderColor: BaseColors.primaryBerana,
                  child: SizedBox(
                      width: 125,
                      child: Center(
                          child: Text('Get Started',
                              style: TextStyle(
                                  color: BaseColors.primaryBerana,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)))
                  ),
              ),
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ));
      }),
    );
  }
}

class SplashScreenButton extends StatelessWidget {
  final Function pressedFunc;

  SplashScreenButton({required this.pressedFunc});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: BaseColors.primaryBerana))),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor:
                MaterialStateProperty.all(BaseColors.primaryBerana)),
        onPressed: () {
          pressedFunc();
        },
        child: const SizedBox(
            width: 125,
            child: Center(
                child: Text('Get Started',
                    style: TextStyle(
                        color: BaseColors.primaryBerana,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)))));
  }
}
