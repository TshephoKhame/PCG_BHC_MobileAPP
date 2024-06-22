import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../app/app.logger.dart';
import 'base_text_input_field.dart';

class EmailField extends StatefulWidget {
  final Map<String, dynamic> config;
  final FormGroup? parentForm;
  final String? value;
  const EmailField(
      {super.key, required this.config, this.parentForm, this.value});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final _logger = getLogger('EmailField');
  late Map<String, dynamic> config;
  late FormGroup? parentForm;
  late FormGroup ffg; //field form group
  late String cn; //controlName
  late String? value;
  late String label;
  String? description;
  String? tooltip;

  @override
  void initState() {
    config = widget.config;
    cn = config['name'] ?? config['id'];
    label = config['label'] ?? config['type'];
    description = config['description'];
    tooltip = config['tooltip'];
    value = widget.value;
    parentForm = widget.parentForm;
    ffg = FormGroup({
      cn: FormControl<String>(
          value: value, validators: [Validators.email, Validators.minLength(6)])
    });

    if (parentForm != null) {
      ffg.valueChanges.listen((ctrl) {
        try {
          parentForm!.control(cn).value = ctrl![cn];
          // _logger.i("${parentForm!.control(cn).value}");
        } catch (e) {
          _logger.e(e);
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: ffg,
      child: RTextField(
        controlName: cn,
        label: label,
        description: description,
        prefixIcon: const Icon(FontAwesomeIcons.envelope),
        tooltip: tooltip,
        validationMessages: {
          ValidationMessage.email: (error) => 'Enter a valid email address',
          ValidationMessage.minLength: (error) => 'Invalid email address',
          ValidationMessage.required: (error) => 'This field is required',
        },
      ),
    );
  }
}
