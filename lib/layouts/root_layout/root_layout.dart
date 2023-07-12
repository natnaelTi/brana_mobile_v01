import 'package:berana/shared/services/dialogue_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:berana/locator.dart';
import 'package:berana/shared/base_app_bar.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:loader_overlay/loader_overlay.dart';

class RootLayout extends StatelessWidget {
  final String? navTitle;
  final Widget child;
  final String? trailingButtonTitle;
  final Function? trailingButtonAction;
  final bool isTransparent;
  final bool isGradient;
  final Color backgroundColor;
  final Color navBackgroundColor;
  final Color barThemeColor;
  final PreferredSizeWidget? navBottomWidget;
  final BottomNavigationBar? bottomNavBar;
  final bool centered;
  final bool showBackButton;
  final bool hideBottomNavBar;

  const RootLayout(
      {
        super.key,
        this.navTitle,
        required this.child,
        this.trailingButtonTitle,
        this.trailingButtonAction,
        this.isTransparent = false,
        this.centered = false,
        this.isGradient = true,
        this.backgroundColor = BaseColors.white,
        this.navBackgroundColor = Colors.white,
        this.barThemeColor = BaseColors.black,
        this.navBottomWidget,
        this.bottomNavBar,
        this.hideBottomNavBar = false,
        this.showBackButton = false
      });

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      disableBackButton: true,
      closeOnBackButton: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: isTransparent,
        appBar: navTitle == null
            ? null
            : BaseAppBar(
          hasBackButton: showBackButton,
          bottomWidget: navBottomWidget,
          elevation: isTransparent ? 0 : 0,
          barThemeColor: isTransparent ? Colors.white : barThemeColor,
          pageTitle: navTitle,
          centered: centered,
          trailing: trailingButtonTitle == null
              ? const SizedBox()
              : TextButton(
              onPressed: () => trailingButtonAction!(),
              child: Text(trailingButtonTitle!,
                  style: const TextStyle(color: BaseColors.mainColor))),
          backgroundColor: isTransparent ? Colors.transparent : navBackgroundColor,
          backgroundWidget: !isTransparent
              ? null
              : Container(
            decoration: BoxDecoration(
              color: Colors.red,
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.01),
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.98),
                    Colors.black.withOpacity(0.98),
                    Colors.black.withOpacity(0.98),
                    Colors.black,
                    Colors.black,
                    Colors.black,
                  ]),
            ),
          ),
        ),
        body: SafeArea(top: !isTransparent, child: child),
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }

  Future<bool> onWillPop({BuildContext? context}) async {
    DateTime? currentBackPressTime;
    final DialogueService dialogueService = locator<DialogueService>();

    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;

      if (dialogueService.isDialogueShowing()) {
        dialogueService.dialogNavigationKey.currentState?.pop();
      }

      var confirmed = await dialogueService.showConfirmationDialog(
        title: 'Are you sure you want to exit?',
        description: 'Confirm by clicking Ok',
        context: context,
      );
      if (confirmed.confirmed) {
        SystemNavigator.pop();
      }
      return Future.value(false);
    }
    return Future.value(true);
  }
}
