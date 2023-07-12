import 'package:flutter/material.dart';

class BeranaTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String labelText;
  final String errorText;
  late final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool isDense;
  final bool isRequired;
  final bool isEmail;
  final bool isPhone;
  final bool isNumber;
  final bool isPassword;
  final bool isMultiline;
  final bool isSearch;
  final bool isUrl;
  final bool isCapitalized;
  final bool isAutoCorrect;
  final bool isAutoFocus;
  final bool isSpellCheck;

  BeranaTextField({
    required this.textEditingController,
    this.hintText='',
    this.labelText='',
    this.errorText='',
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.isDense = false,
    this.isRequired = false,
    this.isEmail = false,
    this.isPhone = false,
    this.isNumber = false,
    this.isPassword = false,
    this.isMultiline = false,
    this.isSearch = false,
    this.isUrl = false,
    this.isCapitalized = false,
    this.isAutoCorrect = false,
    this.isAutoFocus = false,
    this.isSpellCheck = false
  });


  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
            controller: textEditingController,
            obscureText: obscureText,
            enabled: enabled,
            readOnly: readOnly,
            maxLines: isMultiline ? null : 1,
            keyboardType: isEmail ? TextInputType.emailAddress : isPhone ? TextInputType.phone : isNumber ? TextInputType.number : isUrl ? TextInputType.url : isSearch ? TextInputType.text : TextInputType.text,
            textCapitalization: isCapitalized ? TextCapitalization.words : TextCapitalization.none,
            autocorrect: isAutoCorrect,
            autofocus: isAutoFocus,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: hintText,
              labelText: labelText,
              errorText: errorText,
              isDense: isDense,
              suffixIcon: () {
                switch(isPassword) {
                  case true:
                    switch(textEditingController.text.isNotEmpty) {
                      case true:
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  textEditingController.clear();
                                },
                                icon: Icon(Icons.clear)
                            ),
                            IconButton(
                              icon: Icon(
                                obscureText ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                obscureText = !obscureText;
                              },
                            )
                          ],
                        );
                      default:
                        return IconButton(
                          icon: Icon(
                            obscureText ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            obscureText = !obscureText;
                          },
                        );
                    }
                  default:
                    switch(textEditingController.text.isNotEmpty) {
                      case true:
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  textEditingController.clear();
                                },
                                icon: Icon(Icons.clear)
                            )
                          ],
                        );
                      default:
                        return SizedBox();
                    }
                }
              } (),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
            ),
          ),
    );
  }

}