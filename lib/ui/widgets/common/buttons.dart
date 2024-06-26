import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../common/app_colors.dart';
import '../../common/text_styles.dart';
import '../../common/ui_helpers.dart';

class RegularButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final Color buttonColor, labelColor;
  const RegularButton(
      {Key? key,
      required this.onTap,
      required this.label,
      this.buttonColor = bhcRed,
      this.labelColor = kcWhiteColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minButtonWidth,
      height: buttonHeight,
      child: MaterialButton(
        onPressed: onTap,
        color: buttonColor,
        disabledColor: kcLightGreyColor,
        disabledTextColor: kcMediumGreyColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius)),
        child: Text(
          label,
          style: bodyText1(context)
              .copyWith(color: labelColor, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final Color color, labelColor;
  final double width, height, borderRadius;
  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.label,
      this.color = bhcRed,
      this.labelColor = kcWhiteColor,
      this.width = minButtonWidth,
      this.height = buttonHeight,
      this.borderRadius = kBorderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: width,
      height: height,
      child: MaterialButton(
        onPressed: onTap,
        color: color,
        disabledColor: kcVeryLightGreyColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Text(
          label,
          style: titleSmall(context)
              .copyWith(color: labelColor, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class CustomMaterialButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final Color color, labelColor, iconColor;
  final TextStyle textStyle;
  final IconData icon;
  final double width, height, borderRadius, iconSize;
  const CustomMaterialButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.color = bhcRed,
    this.labelColor = kcWhiteColor,
    this.iconColor = kcWhiteColor,
    this.width = minButtonWidth,
    this.height = buttonHeight,
    this.borderRadius = kBorderRadius,
    this.iconSize = generalIconSizeSmall,
    this.textStyle = const TextStyle(
      color: kcWhiteColor,
    ),
    this.icon = Icons.abc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        // border: Border.all(
        //   width: 8,
        // ),
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      height: height,
      width: width,
      child: Center(
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
            horizontalSpaceTiny,
            Text(
              label,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class BusyButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final Color color, busyColor;
  final double width, height, borderRadius;
  final bool isBusy;
  const BusyButton(
      {Key? key,
      required this.onTap,
      required this.label,
      this.color = bhcRed,
      this.width = minButtonWidth,
      this.height = buttonHeight,
      this.borderRadius = kBorderRadius,
      required this.isBusy,
      this.busyColor = kcWhiteColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isBusy
        ? SizedBox(
            width: width / 3,
            height: 20,
            child: const LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [bhcRed, bhcGreen, bhcYellow],
            ),
          )
        : ButtonTheme(
            minWidth: width,
            height: height,
            child: MaterialButton(
              onPressed: isBusy ? null : onTap,
              disabledColor: isBusy ? color : kcLightGreyColor,
              color: color,
              disabledTextColor: kcWhiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: Text(
                label,
                style: bodyText1(context)
                    .copyWith(color: busyColor, fontWeight: FontWeight.w700),
              ),
            ),
          );
  }
}
