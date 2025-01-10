import 'package:flutter/cupertino.dart';

const extraSmallSize = 4.0;
const smallSize = 8.0;
const normalSize = 14.0;
const mediumSize = 16.0;
const largeSize = 20.0;
const extraLargeSize = 30.0;
const extraExtraLargeSize = 40.0;

class AppTextStyles {
  static var largeHeaderStyle =
      TextStyle(fontSize: extraLargeSize, fontWeight: FontWeight.bold);
  static var headerStyle = TextStyle(
    fontSize: largeSize,
    fontWeight: FontWeight.w500,
  );

  static var largeSubHeaderStyle = TextStyle(
    fontSize: mediumSize,
    fontWeight: FontWeight.w500,
  );
  static var subHeaderStyle = TextStyle(
    fontSize: normalSize,
    fontWeight: FontWeight.w500,
  );

  static const largeVerticalSpacing = SizedBox(
    height: 30,
  );

  static const extraLargeVerticalSpacing = SizedBox(
    height: 60,
  );

  static const mediumVerticalSpacing = SizedBox(
    height: 16,
  );

  static const smallVerticalSpacing = SizedBox(
    height: 10,
  );

  static const extraSmallVerticalSpacing = SizedBox(
    height: 5,
  );

  static const largeHorizontalSpacing = SizedBox(
    width: 30,
  );

  static const mediumHorizontalSpacing = SizedBox(
    width: 20,
  );

  static const smallHorizontalSpacing = SizedBox(
    width: 10,
  );
}
