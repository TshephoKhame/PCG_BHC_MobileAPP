import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/common/ui_helpers.dart';
import 'package:bhc_mobile/ui/views/payments/payments_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final PaymentsViewModel vm;
  const PaymentProcessingScreen({required this.vm, super.key});

  @override
  _PaymentProcessingScreenState createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    // Stop the animation after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      _controller.stop();
      widget.vm.successfulyPayedDialog();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/dpo_logo.svg',
              height: 80.0,
            ),
            verticalSpaceMedium,
            RotationTransition(
              turns: _controller,
              child: const CircularProgressIndicator(),
            ),
            const SizedBox(height: 10.0),
            Text('Processing payment', style: tinyText(context)),
          ],
        ),
      ),
    );
  }
}
