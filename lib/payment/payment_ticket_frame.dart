import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:izi_travel/payment/after_payment_load.dart';

class PaymentTickectFrame extends StatefulWidget {
  final String? textPhone;
  final String? textLuggage;
  final String? textAddress;
  final String getBirthdayValue;
  final String selectedDeparture;
  final String selectedDestination;
  const PaymentTickectFrame(
      {super.key,
      required this.textPhone,
      required this.textLuggage,
      required this.textAddress,
      required this.getBirthdayValue,
      required this.selectedDeparture,
      required this.selectedDestination});

  @override
  State<PaymentTickectFrame> createState() => _PaymentTickectFrameState();
}

class _PaymentTickectFrameState extends State<PaymentTickectFrame> {
  var userName = FirebaseAuth.instance.currentUser;
  var emailUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? paymentIntent;

  /*Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('', '');

      await Stripe.instance
    }
  }*/

  /*void generateAndSendEmail(String email) async {
    String qrData =
        "$emailUser, $userName, ${widget.textAddress}, ${widget.getBirthdayValue}, ${widget.selectedDeparture}, ${widget.selectedDestination}, ${widget.textAddress}, ${widget.textLuggage}, ${widget.textPhone}";
    final qrCode =
        QrImageView(data: qrData, version: QrVersions.auto, size: 200.0);

    final Email emailToSend = Email(
        recipients: [email],
        subject: 'IziTravel ticket',
        body:
            'Vous présenterez ce QR code au comptoir d`\'enregistrement de l\'agence de jour de votre départ.',
        isHTML: false,
        attachmentPaths: ['lib/images/qr_code.png']);

    //attacher le code QR à l'email
  }*/

  void insertData() {
    firestore.collection('users').add({
      'arrival': widget.selectedDestination.toString(),
      'departure': widget.selectedDeparture.toString(),
      'email': emailUser.toString(),
      'luggage': widget.textLuggage.toString(),
      'name': userName.toString(),
      'phone': widget.textPhone.toString(),
      'birth_date': widget.getBirthdayValue.toString()
    }).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AfterPaymentLoad(selectedDeparture: widget.selectedDeparture,),
          ));
    }).catchError((error) {
      CupertinoAlertDialog(
        title: const Text(
            'Un problème est survenu lors de l\'achat du ticket. Nous n\'avons pas pu vous enregistrer'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Okay'),
            onPressed: () => Navigator.pop(context),
          )
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
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 120.0, horizontal: 8.0),
                  child: Container(
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: Column(children: [
                      //1ère ligne de données
                      Row(
                        children: [
                          //name textfield
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 08.0),
                            child: SizedBox(
                              width: 200.0,
                              height: 66.0,
                              child: TextField(
                                controller: TextEditingController(
                                    text: userName?.displayName),
                                enabled: false,
                                decoration:
                                    const InputDecoration(label: Text('Nom')),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 08.0,
                          ),

                          //email textfield
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 08.0),
                            child: SizedBox(
                              width: 200.0,
                              height: 66.0,
                              child: TextField(
                                controller: TextEditingController(
                                    text: emailUser?.email),
                                enabled: false,
                                decoration:
                                    const InputDecoration(label: Text('Email')),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),

                      //2e ligne de données
                      Row(
                        children: [
                          //phone number textfield
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 08.0),
                            child: SizedBox(
                              height: 66.0,
                              width: 200.0,
                              child: TextField(
                                controller: TextEditingController(
                                    text: widget.textPhone),
                                enabled: false,
                                decoration: const InputDecoration(
                                    label: Text('Téléphone')),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 08.0,
                          ),

                          //nombre de bagages à enregistrer
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 08.0),
                            child: SizedBox(
                              height: 66.0,
                              width: 200.0,
                              child: TextField(
                                controller: TextEditingController(
                                    text: widget.textLuggage),
                                enabled: false,
                                decoration: const InputDecoration(
                                    label: Text('Bagages à enregistrer')),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),

                      //3e ligne d'affichage de données
                      Row(
                        children: [
                          //birth date controller
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 08.0),
                              child: SizedBox(
                                  height: 66.0,
                                  width: 200.0,
                                  child: TextField(
                                      controller: TextEditingController(
                                          text: widget.getBirthdayValue),
                                      enabled: false,
                                      decoration: const InputDecoration(
                                          label: Text('Date de naissance'))))),
                          const SizedBox(width: 08.0),

                          //adresse du client
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 08.0),
                              child: SizedBox(
                                  height: 66.0,
                                  width: 200.0,
                                  child: TextField(
                                    controller: TextEditingController(
                                        text: widget.textAddress),
                                    enabled: false,
                                    decoration: const InputDecoration(
                                        label: Text('Adresse')),
                                  )))
                        ],
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),

                      //4e ligne d'affichage des données
                      Row(
                        children: [
                          //sens aller
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 08.0),
                            child: SizedBox(
                              height: 66.0,
                              width: 200.0,
                              child: TextField(
                                controller: TextEditingController(
                                    text:
                                        "${widget.selectedDeparture} - ${widget.selectedDestination}"),
                                enabled: false,
                                decoration:
                                    const InputDecoration(label: Text('Aller')),
                              ),
                            ),
                          ),
                          const SizedBox(width: 08.0),

                          //sens retour
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 08.0),
                            child: SizedBox(
                              height: 66.0,
                              width: 200.0,
                              child: TextField(
                                  controller: TextEditingController(
                                      text:
                                          "${widget.selectedDestination} - ${widget.selectedDeparture}"),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      label: Text('Retour'))),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),

                      //bouton de paiement
                      /*PayUnitButton(
                        actionAfterProccess:
                            (transactionId, transactionStatus) {},
                        apiKey: "",
                        apiUser: "890a0e63-bff0-4752-b9e3-5c98402f0957",
                        apiPassword: "ca957f8f-06d0-4146-8559-8360ce2fd041",
                        buttonTextColor: Colors.white,
                        currency: "XAF",
                        color: Colors.blueAccent,
                        mode: "sandbox",
                        notiFyUrl: "",
                        productName: "izitravel",
                        transactionAmount: "8000",
                        transactionCallBackUrl: "",
                        transactionId: "",
                        width: 200,
                      )*/
                      FloatingActionButton.extended(
                        onPressed: () {
                          insertData();
                        },
                      backgroundColor: Colors.blueAccent,
                      label: const Text('Effectuer le paiement'),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
