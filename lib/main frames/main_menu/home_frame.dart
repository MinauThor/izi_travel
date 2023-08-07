import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:izi_travel/main%20frames/booking/result_search.dart';

class HomeFrame extends StatefulWidget {
  const HomeFrame({super.key});

  //get selectedDeparture => HomeFrame.getDeparture();

  @override
  State<HomeFrame> createState() => _HomeFrameState();

  getDeparture() {}
}

class _HomeFrameState extends State<HomeFrame> {
  final user = FirebaseAuth.instance
      .currentUser; // il désigne l'utilisateur qui est connecté à cette instance de l'application
  String? selectedDeparture;
  String? selectedDestination;
  bool toogleValue = false;
  final dateToGoController =
      TextEditingController(); // il est utilisé pour renseigner le champ de date de départ
  final dateToBackController =
      TextEditingController(); // il est utilisé pour renseigner le champ de date de retour

  int _currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.location_on_rounded),
    Icon(Icons.qr_code),
    Icon(Icons.person)
  ];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getData() {
    return firestore.collection('Destination').snapshots();
  }

  void returnDialogError() {
    showDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: const Text('Renseignez toutes les informations nécessaires'),
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
      //App bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        centerTitle: false,
        title: Text(
          'Izi Travel',
          style: GoogleFonts.lobster(
            fontSize: 20,
            color: Colors.white
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18.0),
                        bottomRight: Radius.circular(18.0))),
                alignment: Alignment.bottomCenter,
                height: 200,
                width: double.infinity,
                child: Text(
                  'Bonjour, ${user?.displayName}. Où allons-nous ?',
                  style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              //Ville de départ
              const SizedBox(
                width: 20.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Error : ${snapshot.error.toString()}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  List<DropdownMenuItem<String>> departureItems =
                      []; // cette liste contiendra les données relatives aux villes départ contenues dans la database

                  for (var document in snapshot.data!.docs) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String departureVal = data['Ville'];
                    departureItems.add(DropdownMenuItem(
                      value: departureVal,
                      child: Text(data['Ville']),
                    ));
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: departureItems,
                          value: selectedDeparture,
                          icon: const Icon(
                            Icons.location_on_rounded,
                            color: Colors.blueAccent,
                          ),
                          isDense: true,
                          hint: const Text(
                            'Ville de départ',
                            style: TextStyle(fontSize: 20),
                          ),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(12.0),
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          onChanged: (value) {
                            setState(() {
                              selectedDeparture = value;
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              ),

              //Ville d'arrivée
              StreamBuilder<QuerySnapshot>(
                stream: getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Error : ${snapshot.error.toString()}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  List<DropdownMenuItem<String>> destinationItems = [];

                  for (var document in snapshot.data!.docs) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String destinationVal = data['Ville'];
                    destinationItems.add(DropdownMenuItem(
                      value: destinationVal,
                      child: Text(data['Ville']),
                    ));
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: destinationItems,
                          value: selectedDestination,
                          icon: const Icon(
                            Icons.map_rounded,
                            color: Colors.blueAccent,
                          ),
                          isDense: true,
                          hint: const Text(
                            'Ville d\'arrivée',
                            style: TextStyle(fontSize: 20),
                          ),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(12.0),
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          onChanged: (value) {
                            setState(() {
                              selectedDestination = value;
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 10.0,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Divider(
                  color: Colors.black12,
                  thickness: 2,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),

                    //champ de date aller
                    Flexible(
                      child: TextField(
                        readOnly: true,
                        controller: dateToGoController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            label: const Text('Date Aller'),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(12.0))),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2040));

                          if (pickedDate != null) {
                            setState(() {
                              dateToGoController.text =
                                  DateFormat('dd-MMM-yyyy').format(pickedDate);
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),

                    //champ de date retour
                    Flexible(
                      child: TextField(
                        readOnly: true,
                        controller: dateToBackController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            label: const Text('Date Retour'),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(12.0))),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2040));

                          if (pickedDate != null) {
                            setState(() {
                              dateToBackController.text =
                                  DateFormat('dd-MMM-yyyy').format(pickedDate);
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              //bouton coulissant aller-retour
              switchButton(toogleValue),
              const SizedBox(
                height: 20.0,
              ),

              //bouton pour le lancement des recherches de voyages
              ElevatedButton(
                onPressed: () {
                  if (dateToGoController.text.isEmpty &&
                      dateToBackController.text.isEmpty) {
                    returnDialogError();
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultSearch(
                                  selectedDeparture:
                                      selectedDeparture!.toString(),
                                  selectedDestination:
                                      selectedDestination!.toString(),
                                )));
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueAccent),
                    elevation: MaterialStateProperty.all(0.1),
                    minimumSize:
                        MaterialStateProperty.all(const Size(200, 50))),
                child: const Text(
                  'Lancer la recherche',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              label: 'Voyager',
              activeIcon: Icon(
                Icons.home_rounded,
                color: Colors.blueAccent,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code_2_outlined,
                color: Colors.black,
              ),
              label: 'Réservations',
              activeIcon: Icon(
                Icons.qr_code_2_rounded,
                color: Colors.blueAccent,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
                color: Colors.black,
              ),
              label: 'Mon profil',
              activeIcon: Icon(
                Icons.person_2_rounded,
                color: Colors.blueAccent,
              )),
        ],
      ),
    );
  }

  AnimatedToggleSwitch<bool> switchButton(bool toogleValue) {
    return AnimatedToggleSwitch<bool>.dual(
      current: toogleValue,
      first: true,
      second: false,
      dif: 55.0,
      borderColor: Colors.transparent,
      borderWidth: 5.0,
      height: 50,
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 1.5),
        )
      ],
      onChanged: (value) {
        setState(() => toogleValue = value);
        return Future.delayed(const Duration(milliseconds: 300));
      },
      colorBuilder: (b) => b ? Colors.grey[3] : Colors.blueAccent,
      iconBuilder: (value) => value
          ? Icon(
              Icons.remove_circle_outline,
              key: UniqueKey(),
            )
          : Icon(
              Icons.check_circle_outline,
              key: UniqueKey(),
            ),
      textBuilder: (value) => value
          ? const Center(child: Text('Aller simple'))
          : const Center(child: Text('Aller-retour')),
    );
  }
}
