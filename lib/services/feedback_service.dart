import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../ui/common/app_colors.dart';
import '../ui/common/text_styles.dart';
import '../ui/common/ui_helpers.dart';

enum DialogType { success, error, info, warning, custom }

enum ToastType { success, error, info, warning }

class FeedbackService {
  final FToast fToast = FToast();

  init(BuildContext context) {
    fToast.init(context);
  }

  showToast(BuildContext context, ToastType type, String message,
      {int durationMs = 4000}) {
    Widget toast = Container(
      constraints: BoxConstraints(maxWidth: 90.sw),
      padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: _toastColor(type),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _toastIcon(type),
            color: kcWhiteColor,
          ),
          horizontalSpaceSmall,
          Flexible(
              child: Text(
            message,
            style: bodyText1(context).copyWith(color: kcWhiteColor),
          )),
          IconButton(
            icon: const Icon(
              Icons.close,
            ),
            color: Colors.white,
            onPressed: () {
              fToast.removeCustomToast();
            },
          )
        ],
      ),
    );

    fToast.showToast(
        child: toast,
        // gravity: ToastGravity.TOP,
        toastDuration: Duration(milliseconds: durationMs),
        positionedToastBuilder: (context, child) {
          return Positioned(
            top: kPadding * 1.5,
            right: kPadding * 2,
            child: child,
          );
        });
  }

  Color _toastColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Colors.green.shade400;
      case ToastType.error:
        return kcRed;
      case ToastType.warning:
        return Colors.amber.shade600;
      default:
        return bhcRed;
    }
  }

  IconData _toastIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return FontAwesomeIcons.circleCheck;
      case ToastType.error:
        return FontAwesomeIcons.triangleExclamation;
      case ToastType.warning:
        return FontAwesomeIcons.triangleExclamation;
      default:
        return FontAwesomeIcons.info;
    }
  }

  Future<dynamic> showCustomDialog(
      {required BuildContext context,
      required String title,
      required Widget content,
      required DialogType type,
      bool showOk = false,
      IconData? customIcon,
      bool showIcon = true,
      List<Widget> actions = const []}) async {
    return await showDialog(
      context: context,
      barrierDismissible: actions.isEmpty,
      builder: (BuildContext context) {
        return AlertDialog(
          icon:
              showIcon ? Icon(customIcon ?? _dialogIcon(type), size: 50) : null,
          iconColor: _dialogColor(type),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius)),
          title: title.isNotEmpty
              ? Text(
                  title,
                  style: titleSmall(context),
                )
              : null,
          content: Container(
              constraints: BoxConstraints(
                  maxWidth: getValueForScreenType(
                      context: context,
                      mobile: maxDialogWidthPhone,
                      desktop: maxDialogWidthDesktop)),
              child: content),
          actions: actions.isNotEmpty
              ? actions
              : showOk
                  ? [
                      Center(
                        child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'OK',
                              style: bodyText2(context).copyWith(color: bhcRed),
                            )),
                      )
                    ]
                  : [],
        );
      },
    );
  }

  Future<dynamic> showDynamicProcess(
      {required BuildContext context,
      required String processName,
      required Future<dynamic> process,
      bool dismissible = false,
      double blur = kDefaultBlur,
      int? transitionDuration}) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
        max: 100,
        msg: processName,
        barrierColor: Colors.black87.withOpacity(.8),
        barrierDismissible: dismissible,
        hideValue: true,
        progressValueColor: bhcRed);

    return await process.then((processResult) {
      pd.close();
      // debugPrint(
      // 'Returning from ${processName.replaceAll('.', '')} | PD Closed: ${pd.isOpen()}');
      return processResult;
    }).catchError((error, stackTrace) {
      pd.close();
      debugPrint(
          "Error occurred in '${processName.replaceAll('.', '')}': $error");
      showToast(
          context,
          ToastType.error,
          durationMs: 3500,
          "An error occurred while '${processName.replaceAll('.', '')}'. "
          "Please try again later or contact support if the problem persists.");
      return null;
    });
  }

  Color _dialogColor(DialogType type) {
    switch (type) {
      case DialogType.success:
        return kcDarkGreen;
      case DialogType.error:
        return kcRed;
      case DialogType.warning:
        return kcAmber;
      default:
        return kcRed;
    }
  }

  IconData _dialogIcon(DialogType type) {
    switch (type) {
      case DialogType.success:
        return FontAwesomeIcons.circleCheck;
      case DialogType.error:
        return FontAwesomeIcons.triangleExclamation;
      case DialogType.warning:
        return FontAwesomeIcons.triangleExclamation;
      default:
        return FontAwesomeIcons.info;
    }
  }
}
