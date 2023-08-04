import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:izi_travel/payment/payment_ticket_frame.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({super.key});

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  List images = [];
  var nameUser = FirebaseAuth.instance.currentUser;
  var emailUser = FirebaseAuth.instance.currentUser;
  final birthDateController = TextEditingController();
  final phoneController = TextEditingController();
  final luggageController = TextEditingController();
  final addressController = TextEditingController();

  getNameUser(String? name) {
    name = nameUser?.displayName;
    return name;
  }

  /*fetchImage() async {
    var firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firestoreInstance.collection('Destination').get();
  }*/

  void emptyContentError() {
    showDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: const Text(
                'Remplissez tous les champs avant de procéder au paiement'),
            actions: [
              CupertinoDialogAction(
                  child: const Text('D\'accord'),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: Text('Enregistrement passager',
              style: GoogleFonts.lobster(color: Colors.white, fontSize: 20.0)),
        ),
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                  opacity: 20.0,
                  image: AssetImage(
                    'lib/images/interior_bus.jpg',
                  ),
                  fit: BoxFit.cover)),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 80.0, horizontal: 20.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        //name controller
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 50.0,
                            child: TextField(
                              controller: TextEditingController(
                                  text: nameUser?.displayName),
                              readOnly: true,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(12.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(12.0)),
                                label: const Text('Votre nom'),
                              ),
                            ),
                          ),
                        ),

                        //email controller
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 50.0,
                            child: TextField(
                              controller:
                                  TextEditingController(text: nameUser?.email),
                              readOnly: true,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(12.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(12.0)),
                                label: const Text('Votre nom'),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        //birth date controller
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 50.0,
                            child: TextField(
                              controller: birthDateController,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(12.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(12.0)),
                                label: const Text('Date de naissance'),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1940),
                                    lastDate: DateTime(2026));

                                if (pickedDate != null) {
                                  setState(() {
                                    birthDateController.text =
                                        DateFormat('dd-MMM-yyyy')
                                            .format(pickedDate);
                                  });
                                }
                              },
                            ),
                          ),
                        ),

                        //phone controller
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 66.0,
                            child: TextField(
                              maxLength: 9,
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent)),
                                  label: const Text('Téléphone'),
                                  prefixText: '+237'),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        //nombre de bagages à enregistrer
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 70.0,
                            child: TextField(
                              maxLength: 1,
                              controller: luggageController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent)),
                                  label: const Text('Bagages à enregistrer')),
                            ),
                          ),
                        ),

                        //adresse du domicile
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 70.0,
                            child: TextField(
                                controller: addressController,
                                keyboardType: TextInputType.streetAddress,
                                decoration: InputDecoration(
                                  label: const Text('Adresse'),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent)),
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),

                    //process to payment
                    GestureDetector(
                      onTap: () {
                        emptyContentError();
                        if (nameUser == null &&
                            emailUser == null &&
                            birthDateController.text.isEmpty &&
                            phoneController.text.isEmpty &&
                            luggageController.text.isEmpty &&
                            addressController.text.isEmpty) {
                              emptyContentError();
                              return;
                          }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PaymentTickectFrame())
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(25.0),
                        margin: const EdgeInsets.symmetric(horizontal: 25.0),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                        ),
                        child: const Center(
                          child: Text(
                            'Continuer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
