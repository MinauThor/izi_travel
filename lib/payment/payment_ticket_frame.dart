import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentTickectFrame extends StatefulWidget {
  const PaymentTickectFrame({super.key});

  @override
  State<PaymentTickectFrame> createState() => _PaymentTickectFrameState();
}

class _PaymentTickectFrameState extends State<PaymentTickectFrame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
          'Paiement',
          style: GoogleFonts.lobster(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
  }
}
