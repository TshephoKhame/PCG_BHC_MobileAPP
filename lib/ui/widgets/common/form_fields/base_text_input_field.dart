import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/app_colors.dart';
import '../../../common/text_styles.dart';
import '../../../common/ui_helpers.dart';

class RTextField extends StatelessWidget {
  final String controlName;
  final String label;
  final String? description;
  final String? placeholder;
  final String? tooltip;
  final int? maxLines;
  final int? maxLength;
  late Map<String, String Function(dynamic e)>? validationMessages;
  final bool? show;
  final bool? readOnly;
  final bool required;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;

  RTextField(
      {super.key,
      required this.controlName,
      required this.label,
      this.description = "",
      this.tooltip = "",
      this.validationMessages,
      this.show = true,
      this.maxLines = 1,
      this.required = false,
      this.readOnly,
      this.maxLength,
      this.autofocus = false,
      this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.placeholder,
      this.textInputType,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (required)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.asterisk,
                      size: 8, color: Colors.redAccent),
                  horizontalSpaceTiny,
                  Text(
                    'required',
                    style: TextStyle(fontSize: 8, color: Colors.redAccent),
                  )
                ],
              ),
            ),
          ReactiveTextField(
            formControlName: controlName,
            maxLines: maxLines,
            controller: controller,
            maxLengthEnforcement:
                maxLength != null ? MaxLengthEnforcement.enforced : null,
            maxLength: maxLength,
            readOnly: readOnly ?? false,
            autofocus: autofocus,
            validationMessages: validationMessages,
            inputFormatters: inputFormatters,
            keyboardType: textInputType,
            style: bodyText1(context).apply(fontSizeFactor: 1),
            decoration: InputDecoration(
                labelText: label,
                isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                helperText: description,
                hintText: placeholder,
                hintStyle:
                    bodyText2(context).copyWith(color: kcVeryLightGreyColor),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon ??
                    ((tooltip != null && tooltip != "")
                        ? Tooltip(
                            message: tooltip,
                            child: const Icon(FontAwesomeIcons.circleInfo),
                          )
                        : null)),
          ),
        ],
      ),
    );
  }
}
