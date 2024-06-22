import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'app_colors.dart';

TextStyle titleLarge(BuildContext context) {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize:
          getValueForScreenType(context: context, mobile: 20, desktop: 25));
}

TextStyle titleMedium(BuildContext context) {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize:
          getValueForScreenType(context: context, mobile: 18, desktop: 23));
}

TextStyle titleSmall(BuildContext context) {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize:
          getValueForScreenType(context: context, mobile: 16, desktop: 20));
}

TextStyle subtitle1(BuildContext context) {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize:
          getValueForScreenType(context: context, mobile: 14, desktop: 18));
}

TextStyle subtitle1light(BuildContext context) {
  return TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade700,
      fontSize:
          getValueForScreenType(context: context, mobile: 14, desktop: 18));
}

TextStyle subtitle2(BuildContext context) {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize:
          getValueForScreenType(context: context, mobile: 12, desktop: 17));
}

TextStyle bodyText1(BuildContext context) {
  return TextStyle(
      fontWeight: FontWeight.w500,
      color: primaryTextColorLight,
      fontSize:
          getValueForScreenType(context: context, mobile: 12, desktop: 13));
}

TextStyle bodyText2(BuildContext context) {
  return TextStyle(
      fontWeight: FontWeight.w400,
      color: secondaryTextColorLight,
      fontSize:
          getValueForScreenType(context: context, mobile: 12, desktop: 13));
}

TextStyle tinyText(BuildContext context) {
  return TextStyle(
      fontWeight: FontWeight.w800,
      color: kcDarkGreyColor,
      fontSize: getValueForScreenType(context: context, mobile: 9, desktop: 9));
}

TextStyle fieldLabel(BuildContext context) {
  return TextStyle(
      color: primaryTextColorLight,
      fontWeight: FontWeight.w600,
      fontSize:
          getValueForScreenType(context: context, mobile: 12, desktop: 13));
}

TextStyle fieldDescription(BuildContext context) {
  return TextStyle(
      color: secondaryTextColorLight,
      fontWeight: FontWeight.w500,
      fontSize:
          getValueForScreenType(context: context, mobile: 10, desktop: 11));
}
