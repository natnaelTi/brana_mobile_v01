import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:berana/models/bottom_sheet_action.dart';
import 'package:berana/helpers.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop<T extends Object>([T? result]) {
    return _navigationKey.currentState?.pop(result);
  }

  canPop() {
    return _navigationKey.currentState?.canPop();
  }

  navigateTo(Widget widget, {dynamic arguments}) async {
    return await _navigationKey.currentState
        ?.push(MaterialPageRoute(builder: (builderContext) => widget));
  }

  popUntil<T extends Object>([T? result]) {
    return _navigationKey.currentState?.popUntil((route) => route.isFirst);
  }

  // popUntilFirstPageAndReplace(Widget widget) {
  //   _navigationKey.currentState?.popUntil((route) => route.isFirst);
  //   _navigationKey.currentState
  //       ?.pushReplacement(MaterialPageRoute(builder: (builderContext) => Home()));
  //   return _navigationKey.currentState
  //       ?.pushReplacement(MaterialPageRoute(builder: (builderContext) => widget));
  // }

  pushReplacement(Widget widget, {dynamic arguments}) async {
    return await _navigationKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (builderContext) => widget));
  }

  Future<void> popUntilFirstAndReplace(Widget widget) async {
    _navigationKey.currentState!.popUntil((route) => route.isFirst);
    _navigationKey.currentState!.pushReplacement(
      CupertinoPageRoute(builder: (context) => widget),
    );
  }

  bool? isRootOfNavigationStack() {
    return ModalRoute.of((_navigationKey.currentState?.context)!)?.isCurrent;
  }

  Future<dynamic> showBottomSheetScrollableModal(
      {String title = '',
        String description = '',
        required Widget widget,
        required onComplete}) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        context: navigationKey.currentContext!,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
        builder: (builderContext) {
          return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.7,
              maxChildSize: 0.7,
              minChildSize: 0.4,
              builder: (builderContext, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: widget),
                );
              });
        }).whenComplete(() => onComplete());
  }

  Future<dynamic> showBottomSheet({
    String title = '',
    String description = '',
    required List<BottomSheetAction> actions,
    double height = 0.4,
  }) async {
    return await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
      isScrollControlled: true,
      context: navigationKey.currentContext!,
      builder: (builderContext) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpaceMedium,
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontSize: 20),
                ),
                verticalSpaceTiny,
                verticalSpaceTiny,
                Text(
                  description,
                  textAlign: TextAlign.center,
                ),
                verticalSpaceMedium,
                const Divider(
                  thickness: 0.5,
                  height: 0,
                ),
                verticalSpaceSmall,
                ..._generateActionTiles(actions),
                verticalSpaceSmall,
                const Divider(
                  thickness: 0.5,
                  height: 0,
                ),
                verticalSpaceSmall,
                InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      pop();
                    },
                    child: Ink(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        child: const Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                        ))),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Column> _generateActionTiles(List<BottomSheetAction> actions) {
    return actions.map((action) {
      return Column(
        children: [
          InkWell(
            splashColor: Colors.red,
            onTap: () {
              pop();
              action.action();
            },
            child: Ink(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Text(
                action.title,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      );
    }).toList();
  }

  Future showCupertinoModal({required Widget widget, Widget? cancelWidget}) async {
    return await showCupertinoModalPopup(
      barrierColor: Colors.black.withOpacity(.6),
      useRootNavigator: false,
      context: navigationKey.currentContext!,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [widget],
          cancelButton: cancelWidget,
        );
      },
    );
  }

  showErrorDialogue({required String title, required String description}) {
    showDialog(
      context: navigationKey.currentContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Container(
          child: Text(
            title,
            style: TextStyle(color: Colors.red, fontFamily: GoogleFonts.montserrat().fontFamily),
          ),
        ),
        content: Text(description, textAlign: TextAlign.center),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Okay'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  showSuccessDialogue({required String title, required String description}) {
    showDialog(
        context: navigationKey.currentContext!,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            title,
            style:
            TextStyle(color: Colors.green, fontFamily: GoogleFonts.montserrat().fontFamily),
          ),
          content: Text(description,
              style: TextStyle(fontFamily: GoogleFonts.montserrat().fontFamily)),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Okay'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ));
  }

  showSnackBar({required String description, Duration duration = const Duration(seconds: 1)}) {
    ScaffoldMessenger.of(navigationKey.currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          description,
          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.greenAccent,
        duration: duration,
      ),
    );
  }

  showTopSnackBarWithoutContext(
      {required String description, Duration duration = const Duration(seconds: 1)}) {
    ScaffoldMessenger.of(navigationKey.currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.montserrat().fontFamily),
        ),
        backgroundColor: Colors.red,
        duration: duration,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(navigationKey.currentContext!).size.height - 150,
            right: 20,
            left: 20),
      ),
    );
  }

  showTopSnackBar(
      {required context,
        required String description,
        Duration duration = const Duration(seconds: 4)}) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    bool isFocused = !currentFocus.hasPrimaryFocus;
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    ScaffoldMessenger.of(navigationKey.currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.montserrat().fontFamily),
        ),
        backgroundColor: Colors.red,
        duration: duration,
        margin:
        EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 100, right: 20, left: 20),
      ),
    );
  }

  setState() {
  }
}
