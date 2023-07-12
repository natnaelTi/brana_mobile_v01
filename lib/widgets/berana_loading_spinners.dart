import 'package:flutter/material.dart';

Widget beranaCircularProgressIndicatorButton({
  Color backgroundColor = Colors.transparent,
  Color foregroundColor = Colors.white,
  double width = 20,
  double height = 20
}) {
  return SizedBox(
    width: width,
    height: height,
    child: CircularProgressIndicator(
      backgroundColor: backgroundColor,
      color: foregroundColor,
    ),
  );
}

Widget beranaLinearProgressIndicatorButton({
  Color backgroundColor = Colors.transparent,
  Color foregroundColor = Colors.white,
  double width = 20,
  double height = 20
}) {
  return SizedBox(
    width: width,
    height: height,
    child: LinearProgressIndicator(
      backgroundColor: backgroundColor,
      color: foregroundColor,
    ),
  );
}