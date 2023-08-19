import 'package:flutter/material.dart';
import 'package:izi_travel/main%20frames/main_menu/home_frame.dart';

class AfterPayment extends StatefulWidget {
  final String? selectedDeparture;
  const AfterPayment({super.key, required this.selectedDeparture});

  @override
  State<AfterPayment> createState() => _AfterPaymentState();
}

class _AfterPaymentState extends State<AfterPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "Merci pour votre confiance. Vous avez été enregistré dans le départ de ${widget.selectedDeparture}"),
            const SizedBox(
              height: 10.0,
            ),
            FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => const HomeFrame()));
                },
                label: const Text('Retourner à la page d\'accueil'))
          ],
        )));
  }
}
