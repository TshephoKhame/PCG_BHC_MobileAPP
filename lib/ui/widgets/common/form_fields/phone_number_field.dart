import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../app/app.logger.dart';
import '../../../common/app_colors.dart';
import '../../../common/text_styles.dart';

class PhoneNumberField extends StatefulWidget {
  final Map<String, dynamic> config;
  final FormGroup? parentForm;
  final String? value;
  const PhoneNumberField(
      {super.key, required this.config, this.parentForm, this.value});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final _logger = getLogger('PhoneNumberField');
  late Map<String, dynamic> config;
  late FormGroup? parentForm;
  late String cn; //controlName
  late String? value;
  late String label;
  String? description;
  String? tooltip;
  late bool landlineAllowed;
  Widget? prefixIcon;

  @override
  void initState() {
    config = widget.config;
    cn = config['name'] ?? config['id'];
    label = config['label'] ?? 'Phone Number';
    description = config['description'];
    tooltip = config['tooltip'];
    value = widget.value;

    parentForm = widget.parentForm;
    landlineAllowed = false; //TODO: add setting to field-specific config

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntlPhoneField(
            style: bodyText1(context).apply(fontSizeFactor: 1),
            disableLengthCheck: landlineAllowed,
            decoration: InputDecoration(
                labelText: label,
                isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                helperText: description,
                hintText: 'placeholder',
                hintStyle:
                    bodyText2(context).copyWith(color: kcVeryLightGreyColor),
                prefixIcon: prefixIcon,
                suffixIcon: (tooltip != null && tooltip != "")
                    ? Tooltip(
                        message: tooltip,
                        child: const Icon(FontAwesomeIcons.circleInfo),
                      )
                    : null),
            languageCode: "en",
            pickerDialogStyle: PickerDialogStyle(
              width: 450,
            ),
            initialCountryCode: 'BW',
            showCountryFlag: false,
            onChanged: (phone) {
              // print(phone.completeNumber);
              if (parentForm != null) {
                try {
                  parentForm!.control(cn).value = phone.completeNumber;
                  _logger.i("${parentForm!.control(cn).value}");
                } catch (e) {
                  _logger.e(e);
                }
              }
            },
            onCountryChanged: (country) {
              // print('Country changed to: ' + country.name);
            },
          ),
        ],
      ),
    );
  }
}
