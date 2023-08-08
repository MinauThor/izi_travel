import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentTickectFrame extends StatefulWidget {
  final String? textPhone;
  final String? textLuggage;
  final String? textAddress;
  final String? getBirthdayValue;
  const PaymentTickectFrame({
    super.key,
    required this.textPhone,
    required this.textLuggage,
    required this.textAddress,
    required this.getBirthdayValue
    });

  @override
  State<PaymentTickectFrame> createState() => _PaymentTickectFrameState();
}

class _PaymentTickectFrameState extends State<PaymentTickectFrame> {

  var userName = FirebaseAuth.instance.currentUser;
  var emailUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Paiement',
            style: GoogleFonts.lobster(color: Colors.white, fontSize: 20.0),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 100.0, horizontal: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 120.0, horizontal: 8.0),
                  child: Container(
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        //1ère ligne de données
                        Row(
                          children: [
                            //name textfield
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 08.0),
                              child: SizedBox(
                                width: 200.0,
                                height: 66.0,
                                child: TextField(
                                  controller: TextEditingController(text: userName?.displayName),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    label: Text('Nom') 
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 08.0,),

                            //email textfield
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 08.0),
                              child: SizedBox(
                                width: 200.0,
                                height: 66.0,
                                child: TextField(
                                  controller: TextEditingController(text: emailUser?.email),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    label: Text('Email')
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 13.0,),
                        
                        //2e ligne de données
                        Row(
                          children: [
                            //phone number textfield
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 08.0),
                              child: SizedBox(
                                height: 66.0,
                                width: 200.0,
                                child: TextField(
                                  controller: TextEditingController(text: widget.textPhone),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    label: Text('Téléphone')
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 08.0,),

                            //nombre de bagages à enregistrer
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 08.0),
                              child: SizedBox(
                                height: 66.0,
                                width: 200.0,
                                child: TextField(
                                  controller: TextEditingController(text: widget.textLuggage),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    label: Text('Bagages à enregistrer')
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 13.0,),

                        //3e ligne d'affichage de données
                        Row(
                          children: [
                            //birth date controller
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 08.0),
                              child: SizedBox(
                                height: 66.0,
                                width: 200.0,
                                child: TextField(
                                  controller: TextEditingController(text: widget.getBirthdayValue),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    label: Text('Date de naissance')
                                  )
                                )
                              )
                            ),
                            const SizedBox(width: 08.0),

                            //adresse du client
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 08.0),
                              child: SizedBox(
                                height: 66.0,
                                width: 200.0,
                                child: TextField(
                                  controller: TextEditingController(text: widget.textAddress),
                                  enabled: false,

                                )
                              )
                            )
                          ],
                        )
                      ]
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
