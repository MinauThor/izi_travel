import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
//Il est utilisé pour les champs de texte avec les labels, les couleurs et les icônes

  final TextEditingController controller;
  final String label;
  const CustomTextField(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(12.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(12.0)),
            label: Text(
              label.toString(),
              style: const TextStyle(color: Colors.orange),
            ),
            border: InputBorder.none),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

/*for (int i=0; i<snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];
                      destinationItems.add(
                        DropdownMenuItem(
                          value: snap.id,
                          child: Text(
                            snap.id
                          ),
                        )
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.location_on_rounded, size: 25, color: Colors.orange,),
                        const SizedBox(width: 50.0,),
                      ],
                    );*/
