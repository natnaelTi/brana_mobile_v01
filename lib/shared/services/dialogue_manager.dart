import 'package:flutter/material.dart';
import 'package:berana/helpers.dart';
import 'package:berana/locator.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:berana/shared/base_fonts.dart';
import 'package:berana/shared/services/dialogue_service.dart';

class DialogueManager extends StatefulWidget {
  final Widget child;
  DialogueManager({Key? key, required this.child}) : super(key: key);

  _DialogueManagerState createState() => _DialogueManagerState();
}

class _DialogueManagerState extends State<DialogueManager> {
  DialogueService _dialogService = locator<DialogueService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
        context: context,
        builder: (context) => Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0)), //this right here
              child: Padding(
                padding: const EdgeInsets.only(top: 17.0, left: 17, right: 17, bottom: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalSpaceSmall,
                    verticalSpaceTiny,
                    Text(
                      request.title,
                      style: BaseFonts.title3(),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceSmall,
                    Text(
                      request.description,
                      style: BaseFonts.subHead(color: BaseColors.grey2),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceMedium,
                    verticalSpaceTiny,
                    if (isConfirmationDialog) Divider(height: 2),
                    if (isConfirmationDialog)
                      InkWell(
                        borderRadius: BorderRadius.circular(5),
                        splashColor: BaseColors.tertiaryPink,
                        child: Ink(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(request.buttonTitle,
                                textAlign: TextAlign.center,
                                style: BaseFonts.headline(color: BaseColors.mainColor))),
                        onTap: () {
                          _dialogService.dialogComplete(DialogResponse(confirmed: true));
                        },
                      ),
                    Divider(
                      height: 2,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      splashColor: BaseColors.tertiaryPink,
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          request.cancelTitle == null ? "Cancel" : request.cancelTitle!,
                          textAlign: TextAlign.center,
                          style: BaseFonts.headline2(color: BaseColors.black),
                        ),
                      ),
                      onTap: () {
                        _dialogService.dialogComplete(DialogResponse(confirmed: false));
                      },
                    ),
                  ],
                ),
              ),
            ));
  }
}
