import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:izi_travel/payment/payment_ticket_frame.dart';

class CheckIn extends StatefulWidget {
  final String selectedDeparture;
  final String selectedDestination;
  const CheckIn({
    super.key,
    required this.selectedDeparture,
    required this.selectedDestination
    });

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  var nameUser = FirebaseAuth.instance.currentUser;
  var emailUser = FirebaseAuth.instance.currentUser;
  final birthDateController = TextEditingController();
  final phoneController = TextEditingController();
  final luggageController = TextEditingController();
  final addressController = TextEditingController();
  late String textPhone;
  late String textLuggage;
  late String textAddress;
  late String textBirthday;
  String birthdayValue = "";

  String getBirthdayValue() {
    textBirthday = birthDateController.text;
    return textBirthday;
  }

  void emptyContentError() {
    showDialog(
        context: context,
        builder: (context) {
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
  void dispose() {
    super.dispose();
    emptyContentError();
    birthDateController.dispose();
    phoneController.dispose();
    luggageController.dispose();
    addressController.dispose();
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
                  const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25.0,
                      ),

                      const Text(
                        'VOS INFORMATIONS PERSONNELLES',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),

                      Row(
                        children: [
                          //name controller
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  label: const Text('Nom'),
                                ),
                              ),
                            ),
                          ),

                          //email controller
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              width: 200.0,
                              height: 50.0,
                              child: TextField(
                                controller: TextEditingController(
                                    text: nameUser?.email),
                                readOnly: true,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  label: const Text('Email'),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              width: 200.0,
                              height: 50.0,
                              child: TextField(
                                controller: birthDateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
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
                                onChanged: (value) {
                                  setState(() {
                                    textBirthday = value;
                                  });
                                },
                              ),
                            ),
                          ),

                          //phone controller
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              width: 200.0,
                              height: 66.0,
                              child: TextField(
                                maxLength: 9,
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                            color: Colors.blueAccent)),
                                    label: const Text('Téléphone'),
                                    prefixText: '+237'),
                                onChanged: (value) {
                                  setState(() {
                                    textPhone = value;
                                  });
                                },
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              width: 200.0,
                              height: 70.0,
                              child: TextField(
                                maxLength: 1,
                                controller: luggageController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                            color: Colors.blueAccent)),
                                    label: const Text('Bagages à enregistrer')),
                                onChanged: (value) {
                                  setState(() {
                                    textLuggage = value;
                                  });
                                },
                              ),
                            ),
                          ),

                          //adresse du domicile
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                                ),
                                onChanged: (value) {
                                  textAddress = value;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 100.0,
                      ),

                      //process to payment
                      ElevatedButton(
                        onPressed: () {
                          if (addressController.text.isNullOrEmpty ||
                              birthDateController.text.isNullOrEmpty ||
                              luggageController.text.isNullOrEmpty ||
                              addressController.text.isNullOrEmpty) {
                            emptyContentError();
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PaymentTickectFrame(
                                        textPhone: textPhone,
                                        textLuggage: textLuggage,
                                        textAddress: textAddress,
                                        getBirthdayValue: getBirthdayValue(),
                                        selectedDeparture:
                                            widget.selectedDeparture,
                                        selectedDestination: widget.selectedDestination,)));
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueAccent),
                            elevation: MaterialStateProperty.all(0.1),
                            minimumSize:
                                MaterialStateProperty.all(const Size(300, 70))),
                        child: const Text(
                          'Procéder au paiement',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
