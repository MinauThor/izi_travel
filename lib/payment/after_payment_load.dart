import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:izi_travel/payment/after_payment.dart';
import 'package:flutter/material.dart';

class AfterPaymentLoad extends StatefulWidget {
  final String? selectedDeparture;
  const AfterPaymentLoad({
    super.key,
    required this.selectedDeparture
    });

  @override
  State<AfterPaymentLoad> createState() => _AfterPaymentLoadState();
}

class _AfterPaymentLoadState extends State<AfterPaymentLoad> {

  @override
  void initState() {
    Timer(
      const Duration(
        milliseconds: 10000
      ), () => Navigator.push(
        context, CupertinoPageRoute(builder: (_) => AfterPayment(selectedDeparture: widget.selectedDeparture,))
      )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(color: Colors.blue,),
            )
          ],
        ),
      ),
    );
  }
}