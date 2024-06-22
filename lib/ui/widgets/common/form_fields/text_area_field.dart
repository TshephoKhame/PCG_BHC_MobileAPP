import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../app/app.logger.dart';
import '../../../common/app_colors.dart';
import '../../../common/text_styles.dart';

class TextAreaField extends StatefulWidget {
  final Map<String, dynamic> config;
  final FormGroup? parentForm;
  final String? value;
  const TextAreaField(
      {super.key, required this.config, this.parentForm, this.value});

  @override
  State<TextAreaField> createState() => _TextAreaFieldState();
}

class _TextAreaFieldState extends State<TextAreaField> {
  final _logger = getLogger('TextAreaField');
  late TextEditingController controller;
  late Map<String, dynamic> config;
  late FormGroup? parentForm;
  late String cn; //controlName
  late String? value;
  late String label;
  String? description;
  String? tooltip;
  int? maxLength;
  double height = 120;

  void _updateSize(Offset offset) {
    setState(() {
      height += offset.dy;
      if (height < 120) {
        height = 120;
      }
    });
  }

  @override
  void initState() {
    config = widget.config;
    parentForm = widget.parentForm;
    cn = config['name'] ?? config['id'];
    label = config['label'] ?? config['type'];
    description = config['description'];
    tooltip = config['tooltip'];
    value = widget.value;
    controller = TextEditingController(text: value);
    maxLength = (config['properties']?['maxLength'] ?? "").toString().isNotEmpty
        ? int.parse(config['properties']?['maxLength'])
        : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (description != null)
              Text("$description",
                  style:
                      bodyText2(context).copyWith(color: kcComplimentaryGrey)),
            Container(
              clipBehavior: Clip.antiAlias,
              height: height,
              constraints: BoxConstraints(
                maxHeight: height,
              ),
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(top: 10, bottom: 8),
              child: TextField(
                expands: true,
                controller: controller,
                minLines: null,
                maxLines: null,
                maxLength: maxLength,
                maxLengthEnforcement: maxLength != null
                    ? MaxLengthEnforcement.enforced
                    : MaxLengthEnforcement.none,
                decoration: InputDecoration(
                  labelText: config['label'] ?? config['type'],
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Enter text here...',
                  suffixIcon:
                      (config['tooltip'] != null && config['tooltip'] != "")
                          ? Tooltip(
                              message: config['tooltip'],
                              child: const Icon(FontAwesomeIcons.circleInfo),
                            )
                          : null,
                ),
                textAlign: TextAlign.start,
                onChanged: (input) {
                  if (parentForm != null) {
                    parentForm?.control(cn).value =
                        input.isEmpty ? null : input;
                  }
                },
              ),
            ),
          ],
        ),
        Positioned(
            bottom: maxLength != null ? 8 : 10,
            right: maxLength != null ? -1 : 2,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeUpLeftDownRight,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanUpdate: (details) {
                  _updateSize(details.delta);
                },
                child: Transform.rotate(
                  angle: -48,
                  child: const Icon(
                    Icons.expand_outlined,
                    size: 12,
                    color: kcVeryLightGreyColor,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
