import 'package:flutter/material.dart';

typedef ViewModelCreatorFunction<S> = S Function();

const Widget horizontalSpaceTiny = SizedBox(width: 3.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

BorderRadius roundedBorderSmall = BorderRadius.circular(7);
BorderRadius roundedBorderMedium = BorderRadius.circular(15);

Widget loadingSpinner = Container(
  width: double.infinity,
  height: double.infinity,
  color: Colors.white,
  child: const Center(
    child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: Color.fromRGBO(255, 0, 0, 1),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          strokeWidth: 3,
        )),
  ),
);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context, {int dividedBy = 1, double offsetBy = 0}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(BuildContext context, {int dividedBy = 1, double offsetBy = 0}) =>
    (screenWidth(context) - offsetBy) / dividedBy;

double halfScreenWidth(BuildContext context) => screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) => screenWidthFraction(context, dividedBy: 3);
