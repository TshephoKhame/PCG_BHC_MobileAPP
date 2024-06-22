import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../app/app.logger.dart';
import 'base_text_input_field.dart';

class TextInputField extends StatefulWidget {
  final Map<String, dynamic> config;
  final FormGroup? parentForm;
  const TextInputField({super.key, required this.config, this.parentForm});

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  final _logger = getLogger('TextInputField');
  late Map<String, dynamic> config;
  late FormGroup? parentForm;
  late FormGroup ffg; //field form group
  late String cn; //controlName
  late String? value;
  late String label;
  String? description;
  String? tooltip;
  int? maxLength;

  @override
  void initState() {
    super.initState();

    config = widget.config;
    cn = config['name'] ?? config['id'];
    label = config['label'] ?? config['type'];
    description = config['description'];
    tooltip = config['tooltip'];
    maxLength = (config['properties']?['maxLength'] ?? "").toString().isNotEmpty
        ? int.parse(config['properties']?['maxLength'])
        : null;
    // Add validators to the FormControl
    final validators = <Validator<dynamic>>[
      if (maxLength != null) Validators.maxLength(maxLength!),
    ];
    parentForm = widget.parentForm;
    ffg = FormGroup(
        {cn: FormControl<String>(value: value, validators: validators)});

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
        tooltip: tooltip,
        validationMessages: {
          ValidationMessage.maxLength: (error) =>
              'Maximum length is $maxLength characters'
        },
        maxLength: maxLength,
      ),
    );
  }
}
