import 'package:flutter/material.dart';
import 'package:berana/shared/base_fonts.dart';

class AlertDialogue {
  final BuildContext context;
  final String title;
  final String description;

  final Color? titleColor;

  final String? buttonLabel;
  final Function onCancelTapped;

  AlertDialogue({
    required this.context,
    required this.title,
    required this.description,
    this.buttonLabel,
    this.titleColor,
    required this.onCancelTapped,
  }) {
    showAlertDialog(context);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = GestureDetector(
        child: Text(
          buttonLabel ?? 'Cancel',
          style: BaseFonts.body(),
        ),
        onTap: () => onCancelTapped());

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      titleTextStyle: BaseFonts.title3(),
      content: Text(description),
      contentTextStyle: BaseFonts.body(),
      actions: [
        cancelButton,
        // continueButton,
      ],
      actionsPadding: EdgeInsets.all(3),
      buttonPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
