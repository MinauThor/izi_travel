import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 30,),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Bonjour ! Où allons-nous ?',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
        )
      ],
    );
  }
}
