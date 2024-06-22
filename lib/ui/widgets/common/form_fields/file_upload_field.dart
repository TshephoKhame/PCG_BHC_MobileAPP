import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../app/app.logger.dart';
import '../../../common/text_styles.dart';
import '../../../common/ui_helpers.dart';

class FileUploadField extends StatefulWidget {
  final Map<String, dynamic> config;
  final FormGroup? parentForm;
  final Map<String, dynamic>? value;
  const FileUploadField(
      {super.key, required this.config, this.parentForm, this.value});

  @override
  State<FileUploadField> createState() => _FileUploadFieldState();
}

class _FileUploadFieldState extends State<FileUploadField> {
  final _logger = getLogger('FileUploadField');
  late Map<String, dynamic> config;
  late FormGroup? parentForm;
  late String cn; //controlName
  late Map<String, dynamic>? value;
  late String label;
  String? description;
  String? tooltip;
  PlatformFile? file;
  List<String>? allowedExtensions;

  @override
  void initState() {
    config = widget.config;
    cn = config['name'] ?? config['id'];
    label = config['label'] ?? config['type'];
    description = config['description'];
    tooltip = config['tooltip'];
    value = widget.value;
    parentForm = widget.parentForm;
    allowedExtensions = config['properties']
        ?['allowedExtensions']; //todo: add field-specific props for extensions

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: bodyText1(context)),
          if ((description ?? "").isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 3),
              child: Text(description!,
                  style:
                      bodyText2(context).copyWith(color: kcComplimentaryGrey)),
            ),
          file == null
              ? SizedBox(
                  width: 180,
                  child: MaterialButton(
                      height: 45,
                      color: bhcRed,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kBorderRadius)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.upload_rounded,
                            color: kcWhiteColor,
                          ),
                          horizontalSpaceSmall,
                          Expanded(
                              child: Text('Choose a file',
                                  style: bodyText1(context)
                                      .copyWith(color: kcWhiteColor))),
                          if (tooltip != null && tooltip != "")
                            Tooltip(
                              message: tooltip,
                              child: const Icon(
                                FontAwesomeIcons.circleInfo,
                                color: kcWhiteColor,
                                size: 15,
                              ),
                            )
                        ],
                      ),
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowedExtensions: allowedExtensions,
                        );
                        if (result != null) {
                          PlatformFile pf = result.files.first;
                          print(pf.name);
                          // print(pf.bytes);
                          print(formatBytes(pf.size, 2));
                          setState(() {
                            file = pf;
                          });
                          try {
                            parentForm!.control(cn).value = {
                              "bucket": "formbuilder-test",
                              "extension": "${pf.extension}",
                              "original-name": "${pf.name}",
                              "key": "04beb76b-571a-4b39-82ff-70739c0327e4"
                            };
                          } catch (e) {
                            _logger.e(e);
                          }
                        }
                      }),
                )
              : Row(
                  children: [
                    // const Icon(FontAwesomeIcons.check, color: Colors.green, size: 15,),
                    // horizontalSpaceSmall,
                    Flexible(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: file!.name,
                            style: bodyText1(context).copyWith(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                            text: "    ${formatBytes(file!.size, 2)} ",
                            style: tinyText(context).copyWith(
                                color: bhcRed, fontWeight: FontWeight.w600))
                      ])),
                    ),
                    horizontalSpaceMedium,
                    IconButton(
                        tooltip: 'Remove file',
                        onPressed: () {
                          setState(() {
                            file == null;
                          });
                        },
                        icon: const Icon(
                          FontAwesomeIcons.circleXmark,
                          color: Colors.redAccent,
                          size: 20,
                        ))
                  ],
                )
        ],
      ),
    );
  }
}
