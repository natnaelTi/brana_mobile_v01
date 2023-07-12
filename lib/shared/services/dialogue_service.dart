import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:berana/locator.dart';
import 'package:berana/shared/services/navigation_service.dart';

class DialogueService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();
  Function(DialogRequest)? _showDialogListener;
  Completer<DialogResponse>? _dialogCompleter;
  final NavigationService _navigationService = locator<NavigationService>();

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  bool isDialogueShowing() {
    return _dialogCompleter != null;
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<DialogResponse> showErrorDialogue({
    required String title,
    required String description,
    String buttonTitle = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    if (_showDialogListener == null) return _dialogCompleter!.future;
    _showDialogListener!(DialogRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
    ));
    return _dialogCompleter!.future;
  }

  Future<DialogResponse> showSuccessDialogue({
    required String title,
    required String description,
    String buttonTitle = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    if (_showDialogListener == null) return _dialogCompleter!.future;
    _showDialogListener!(DialogRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
    ));
    return _dialogCompleter!.future;
  }

  /// Shows a confirmation dialog
  Future<DialogResponse> showConfirmationDialog(
      {required String title,
      required String description,
      String confirmationTitle = 'Ok',
      String cancelTitle = 'Cancel',
      BuildContext? context}) {
    _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

    if (context != null && _isThereCurrentDialogShowing(context)) {
      _navigationService.pop();
    }

    _dialogCompleter = Completer<DialogResponse>();
    if (_showDialogListener == null) return _dialogCompleter!.future;
    _showDialogListener!(DialogRequest(
        title: title,
        description: description,
        buttonTitle: confirmationTitle,
        cancelTitle: cancelTitle));
    return _dialogCompleter!.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState?.pop();
    _dialogCompleter?.complete(response);
    _dialogCompleter = null;
  }
}

class DialogRequest {
  final String title;
  final String description;
  final String buttonTitle;
  final String? cancelTitle;

  DialogRequest(
      {required this.title,
      required this.description,
      required this.buttonTitle,
      this.cancelTitle});
}

class DialogResponse {
  final String? fieldOne;
  final String? fieldTwo;
  final bool confirmed;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    required this.confirmed,
  });
}
