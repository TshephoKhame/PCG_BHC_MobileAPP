import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/app_colors.dart';
import '../../../common/text_styles.dart';
import '../../../common/ui_helpers.dart';

class RTextField extends StatefulWidget {
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
  final bool isPassword;
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
      this.isPassword = false,
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
  State<RTextField> createState() => _RTextFieldState();
}

class _RTextFieldState extends State<RTextField> {
  late bool passwordVisible;
  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.required)
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
            formControlName: widget.controlName,
            maxLines: widget.maxLines,
            controller: widget.controller,
            maxLengthEnforcement:
                widget.maxLength != null ? MaxLengthEnforcement.enforced : null,
            maxLength: widget.maxLength,
            readOnly: widget.readOnly ?? false,
            autofocus: widget.autofocus,
            validationMessages: widget.validationMessages,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.textInputType,
            obscureText: widget.isPassword && !passwordVisible,
            obscuringCharacter: '*',
            style: bodyText1(context).apply(fontSizeFactor: 1),
            decoration: InputDecoration(
                labelText: widget.label,
                isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                helperText: widget.description,
                hintText: widget.placeholder,
                hintStyle:
                    bodyText2(context).copyWith(color: kcVeryLightGreyColor),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.isPassword ? IconButton(onPressed: (){
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                }, icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility)): widget.suffixIcon ??
                    ((widget.tooltip != null && widget.tooltip != "")
                        ? Tooltip(
                            message: widget.tooltip,
                            child: const Icon(FontAwesomeIcons.circleInfo),
                          )
                        : null)),
          ),
        ],
      ),
    );
  }
}
