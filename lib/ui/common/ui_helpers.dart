import 'dart:convert';
import 'dart:math';

import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:reactive_file_picker/reactive_file_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'app_colors.dart';

const double _tinySize = 5.0;
const double _smallSize = 10.0;
const double _mediumSize = 25.0;
const double _largeSize = 50.0;
const double _massiveSize = 120.0;
const double kPadding = 30.0;
const double minButtonWidth = 150;
const double buttonHeight = 45;
double maxDialogWidthDesktop = 600;
double maxDialogWidthPhone = 90.sw;
double maxDialogHeight = 80.sh;
double maxDialogWidth = 80.sh;
double kTopBarButtonHeight = 45;
const double fieldHeight = kIsWeb ? 55 : 45;
const kDefaultBlur = 5.0;
const kBorderRadius = 12.0;
const kSpacing = 20.0;
const double generalIconSizeSmall = 14;

const Widget horizontalSpaceTiny = SizedBox(width: _tinySize);
const Widget horizontalSpaceSmall = SizedBox(width: _smallSize);
const Widget horizontalSpaceMedium = SizedBox(width: _mediumSize);
const Widget horizontalSpaceLarge = SizedBox(width: _largeSize);

const Widget verticalSpaceTiny = SizedBox(height: _tinySize);
const Widget verticalSpaceSmall = SizedBox(height: _smallSize);
const Widget verticalSpaceMedium = SizedBox(height: _mediumSize);
const Widget verticalSpaceLarge = SizedBox(height: _largeSize);
const Widget verticalSpaceMassive = SizedBox(height: _massiveSize);

Widget spacedDivider = const Column(
  children: <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double quarterScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 4);

double getResponsiveHorizontalSpaceMedium(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 10);
double getResponsiveSmallFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 14, max: 15);

double getResponsiveMediumFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 16, max: 17);

double getResponsiveLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 21, max: 31);

double getResponsiveExtraLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 25);

double getResponsiveMassiveFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 30);

double getResponsiveFontSize(BuildContext context,
    {double? fontSize, double? max}) {
  max ??= 100;

  var responsiveSize = min(
      screenWidthFraction(context, dividedBy: 6) * ((fontSize ?? 100) / 100),
      max);

  return responsiveSize;
}

double getResponsiveSize(BuildContext context, {double? size, double? max}) {
  max ??= 100;

  var responsiveSize = min(
      screenWidthFraction(context, dividedBy: 10) * ((size ?? 100) / 100), max);

  return responsiveSize;
}

BoxDecoration kElevatedDecoration() => BoxDecoration(
      color: kcWhiteColor,
      boxShadow: const [
        BoxShadow(
          blurRadius: 2,
          color: Color(0x33000000),
          offset: Offset(0, 2),
        )
      ],
      borderRadius: BorderRadius.circular(kBorderRadius),
    );

String prettyJSON(jsonObject) {
  dynamic toEncodable(dynamic item) {
    if (item is MultiFile<PlatformFile>) {
      return item.platformFiles[0].name;
    }
    if (item is DateTime) {
      return item.formatddMMyyyy();
    }
    if (item is PhoneNumber) {
      return item.completeNumber;
    }
    return item;
  }

  var encoder = JsonEncoder.withIndent("  ", toEncodable);

  return encoder.convert(jsonObject);
}

Map<String, dynamic> sanitizeTypes(dynamic rawData) {
  if (rawData is! Map) {
    return rawData;
  }

  Map<String, dynamic> sanitized = {};
  rawData.forEach((key, value) {
    if (value is MultiFile<PlatformFile>) {
      sanitized[key] = value.platformFiles[0].name;
    } else if (value is DateTime) {
      sanitized[key] = value.formatddMMyyyy();
    } else if (value is PhoneNumber) {
      sanitized[key] = value.completeNumber;
    } else if (value is Map) {
      // Recursively sanitize Map values.
      sanitized[key] = sanitizeTypes(value);
    } else if (value is List) {
      // Recursively sanitize List elements.
      sanitized[key] = value.map((v) => sanitizeTypes(v)).toList();
    } else {
      sanitized[key] = value;
    }
  });

  return sanitized;
}

String convertDateFormat(String date) {
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}

String initialsAvatar(String name,
        {String color = '69c5ec', String bg = 'fff'}) =>
    "https://ui-avatars.com"
    "/api/?name=$name"
    "&background=$bg&color=$color&rounded=true&bold=true&size=128";

String computeAge(DateTime birthDate) {
  DateTime now = DateTime.now();
  int years = now.year - birthDate.year;
  int months = now.month - birthDate.month;
  int days = now.day - birthDate.day;

  if (months < 0 || (months == 0 && days < 0)) {
    years--;
    months += (days < 0 ? 11 : 12);
  }

  return years.toString();
}

inputFieldTheme(
        {required BuildContext context,
        double borderRadius = kBorderRadius,
        Color? fillColor,
        Color? borderColor,
        double? thickness}) =>
    Theme.of(context).copyWith(
        disabledColor: kcVeryLightGreyColor,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: fillColor,
          filled: fillColor != null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: bhcRed, width: 0.5),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: borderColor ?? kcMediumGreyColor,
                width: thickness ?? 0.5),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: kcVeryLightGreyColor, width: 0.5),
              borderRadius: BorderRadius.circular(borderRadius)),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kcRed, width: 0.5),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kcRed, width: 0.5),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          hoverColor: fillColor ?? Colors.white,
        ));

inputFieldThemeOutline(
        {required BuildContext context,
        double borderRadius = kBorderRadius,
        bool dataTable = false}) =>
    Theme.of(context).copyWith(
      disabledColor: kcVeryLightGreyColor,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: kcLightGreyColor.withOpacity(0.2),
        filled: false,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: bhcRed, width: 0.5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: dataTable ? kcTransparent : kcComplimentaryGrey,
              width: 0.5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kcRed, width: 0.5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kcRed, width: 0.5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );

InputDecoration inputDecoration({
  required String labelText,
  Widget? suffixIcon,
  Widget? prefixIcon,
  bool obscureText = false,
}) =>
    InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefix: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: labelText,
    );

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return "";
    }
    return split(' ')
        .map((str) => str[0].toUpperCase() + str.substring(1).toLowerCase())
        .join(' ');
    // return split(' ')
    //     .map((word) => word.isNotEmpty
    //         ? '${word[0].toUpperCase()}${word.substring(1)}'
    //         : '')
    //     .join(' ');
  }

  String getInitialName([int max = 2]) {
    String val = this;

    List<String> explode = val.split(" ");
    explode.removeWhere((element) => element.trim().isEmpty);

    String result = "";

    for (int i = 0; i < max; i++) {
      if (i < explode.length) {
        result += explode[i].split("").first;
      } else {
        break;
      }
    }

    return result;
  }

  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsLowercase => contains(RegExp(r'[a-z]'));
  bool get containsDigit => contains(RegExp(r'[0-9]'));
  bool get containsSpecialChars => contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
}

extension DateTimeExtension on DateTime {
  String formatdMMMMY() {
    return DateFormat('d MMMM y').format(this);
  }

  String formatddMMMyyyy() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String formatddMMMyyyyHHMM() {
    return DateFormat('dd MMM yyyy - HH:mm').format(this);
  }

  String formatddMMyyyy() {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String formatHhMmSs() {
    return DateFormat(' HH:mm:ss').format(this);
  }

  String dueDate() {
    DateTime due = this;
    Duration diff = due.difference(DateTime.now());

    if (diff.inDays > 1) {
      return "${diff.inDays} Days";
    } else if (diff.inHours > 1) {
      return "${diff.inHours} Hours";
    } else if (diff.inMinutes > 1) {
      return "${diff.inMinutes} Minutes";
    } else if (diff.inSeconds > 1) {
      return "${diff.inSeconds} Seconds";
    } else {
      return "Is Overdue";
    }
  }
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

Widget tooltipWrapper({required Widget child, required String tip}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Flexible(child: child),
      if (tip.isNotEmpty) horizontalSpaceSmall,
      tip.isNotEmpty
          ? Tooltip(
              message: tip,
              child: const Icon(FontAwesomeIcons.circleInfo,
                  color: bhcRed, size: 15))
          : const SizedBox(
              height: 0,
              width: 0,
            )
    ],
  );
}

Future openBottomSheet(
  BuildContext context, {
  required String title,
  required Widget content,
  double? height,
  EdgeInsets? padding,
  EdgeInsets? margin,
  BorderRadius? borderRadius,
  bool? dismissible,
}) async {
  return await showModalBottomSheet(
    context: context,
    backgroundColor: kcTransparent,
    showDragHandle: true,
    isScrollControlled: true,
    isDismissible: dismissible ?? true,
    builder: (BuildContext context) {
      return Container(
        padding: padding ?? const EdgeInsets.all(kPadding / 2),
        margin: margin,
        height: height ?? 100.sh,
        width: 100.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(kBorderRadius),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Text(
                  title,
                  style: titleSmall(context).copyWith(
                      fontSize: getResponsiveExtraLargeFontSize(context)),
                  textAlign: TextAlign.center,
                )),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon:
                        const Icon(FontAwesomeIcons.circleXmark, color: kcRed))
              ],
            ),
            const Divider(
              thickness: 1.5,
              height: kPadding,
            ),
            content
          ],
        ),
      );
    },
  );
}

Gradient createLinearGradient({
  required Color color1,
  required Color color2,
  Color? color3,
  Color? color4,
  Color? color5,
}) {
  // Filter out null values
  final colors = [
    color1,
    color2,
    if (color3 != null) color3,
    if (color4 != null) color4,
    if (color5 != null) color5,
  ];

  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: colors,
  );
}
