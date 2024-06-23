import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../app/app.logger.dart';
import 'base_text_input_field.dart';

class TextInputField extends StatefulWidget {
  final Map<String, dynamic> config;
  final FormGroup? parentForm;
  final Widget? prefixIcon;
  final bool isPassword;
  const TextInputField(
      {super.key, required this.config, this.parentForm, this.prefixIcon, this.isPassword = false});

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  final _logger = getLogger('TextInputField');
  late Map<String, dynamic> config;
  late FormGroup? parentForm;
  late FormGroup ffg; //field form group
  late String cn; //controlName
  late String label;
  String? description;
  String? tooltip;
  int? maxLength;
  int? section;
  late String ctrlPath;
  late Map<String, String Function(dynamic)> validationMessages;

  @override
  void initState() {
    super.initState();

    config = widget.config;
    cn = config['name'] ?? config['id'];
    label = config['label'] ?? config['type'];
    description = config['description'];
    tooltip = config['tooltip'];
    validationMessages = config['validationMessages'] ?? {
      ValidationMessage.required: (error) =>
      'This field is required'
    };
    maxLength = (config['properties']?['maxLength'] ?? "").toString().isNotEmpty
        ? int.parse(config['properties']?['maxLength'])
        : null;
    // Add validators to the FormControl

    parentForm = widget.parentForm;
    section = config['section'];
    ctrlPath = section != null
        ? '${parentForm!.value.keys.toList()[section!]}.$cn'
        : cn;
    final validators = parentForm?.control(ctrlPath).validators ?? [];
    dynamic val = parentForm?.control(ctrlPath).value;
    ffg = FormGroup(
        {cn: FormControl<String>(value: val, validators: validators)});

    if (parentForm != null) {
      ffg.valueChanges.listen((ctrl) {
        try {
          parentForm!.control(ctrlPath).value = ctrl![cn];
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
        prefixIcon: widget.prefixIcon,
        isPassword: widget.isPassword,
        validationMessages: validationMessages,
        maxLength: maxLength,
      ),
    );
  }
}
