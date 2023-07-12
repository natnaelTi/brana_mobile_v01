import 'package:berana/shared/base_colors.dart';
import 'package:berana/widgets/berana_loading_spinners.dart';
import 'package:flutter/material.dart';

class BeranaButton extends StatelessWidget{
  final Function pressedFunc;
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double width;
  final bool isLoading;
  BeranaButton({
    required this.pressedFunc,
    required this.child,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
    this.width = 125,
    this.isLoading = false
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: borderColor)
                )
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            foregroundColor: MaterialStateProperty.all(foregroundColor)
        ),
        onPressed: () {
          pressedFunc();
        },
        child: SizedBox(
            width: width,
            child: () {
              switch(isLoading) {
                case true:
                  return Center(
                      child: beranaCircularProgressIndicatorButton()
                  );
                default:
                  return child;
              }
            } ()
        )
    );
  }
}

class Button extends StatelessWidget {
  final Function pressedFunc;
  final Widget child;
  final bool isSelected;

  Button({
    required this.pressedFunc,
    required this.child,
    required this.isSelected
  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.white)
                )
            ),
            shadowColor: MaterialStateProperty.all(
                Colors.transparent
            ),
            backgroundColor: MaterialStateProperty.all(
                    () {
                  if(isSelected) {
                    return BaseColors.primaryBerana;
                  } else {
                    return Colors.transparent;
                  }
                } ()
            ),
            foregroundColor: MaterialStateProperty.all(
                BaseColors.primaryBerana
            )
        ),
        onPressed: () {
          pressedFunc();
        },
        child: SizedBox(
            width: 125,
            child: child
        )
    );
  }
}