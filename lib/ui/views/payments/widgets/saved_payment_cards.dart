import 'package:bhc_mobile/ui/common/app_colors.dart';
import 'package:bhc_mobile/ui/common/text_styles.dart';
import 'package:bhc_mobile/ui/views/payments/payments_viewmodel.dart';
import 'package:bhc_mobile/ui/widgets/common/payment_options_widget/payment_options_widget_model.dart';
import 'package:flutter/material.dart';

class SavedPaymentCards extends StatefulWidget {
  final Map<String, dynamic> savedCards;
  final PaymentsViewModel vm;
  const SavedPaymentCards(
      {super.key, required this.savedCards, required this.vm});

  @override
  State<SavedPaymentCards> createState() => _SavedPaymentCardsState();
}

class _SavedPaymentCardsState extends State<SavedPaymentCards> {
  String formattedCardNumber(cardNumber) {
    return '**** ' + cardNumber.substring(cardNumber.length - 4);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      leading: Image.asset('assets/images/visa_card.png',
          width: 40), // Placeholder for Visa logo
      title: Align(
        alignment: Alignment.topRight,
        child: Text(
          'Card ending with ${formattedCardNumber(widget.savedCards['CardNumber'])}',
          style: tinyText(context),
        ),
      ),
      subtitle: Align(
        alignment: Alignment.topRight,
        child: Text(
          widget.savedCards['ExpiryDate'],
          style: tinyText(context).copyWith(
            color:
                widget.savedCards['ExpiryDate'] == 'Expired' ? bhcRed : kcBlack,
          ),
        ),
      ),
      trailing: widget.savedCards['ExpiryDate'] == 'Expired'
          ? ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                textStyle:
                    tinyText(context).copyWith(fontWeight: FontWeight.w100),
                padding: EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: bhcRed,
                foregroundColor: Colors.white,
              ),
              child: Text('Remove'),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle:
                    tinyText(context).copyWith(fontWeight: FontWeight.w100),
                padding: EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: bhcYellow,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                //Navigator.of(context).pop('OrangeMoney');
                await widget.vm.savePayments(
                  paymentMethod: 'Credit Card (Visa)',
                  amount: 'P1,200,000',
                );
                widget.vm.showCardProccessingPaymentDialog();
              },
              child: Text('Pay'),
            ),
    );
  }
}
