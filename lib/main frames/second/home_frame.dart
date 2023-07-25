import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:izi_travel/main%20frames/result_search.dart';

class HomeFrame extends StatefulWidget {
  const HomeFrame({super.key});

  @override
  State<HomeFrame> createState() => _HomeFrameState();
}

class _HomeFrameState extends State<HomeFrame> {
  final user = FirebaseAuth.instance.currentUser;
  String? selectedDeparture;
  String? selectedDestination;
  bool toogleValue = false;
  final dateToGoController = TextEditingController();
  final dateToBackController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        centerTitle: false,
        title: const Text(
          'Izi Travel',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              color: Colors.orange,
              height: 200,
              width: double.infinity,
              child: Text(
                'Bonjour, ${user?.displayName}. Où allons-nous ?',
                style: const TextStyle(
                    fontSize: 30.0,
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

                List<DropdownMenuItem<String>> departureItems = [];

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
                          color: Colors.orange,
                        ),
                        isDense: true,
                        hint: const Text(
                          'Ville de départ',
                          style: TextStyle(fontSize: 20),
                        ),
                        isExpanded: true,
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
                          color: Colors.orange,
                        ),
                        isDense: true,
                        hint: const Text(
                          'Ville d\'arrivée',
                          style: TextStyle(fontSize: 20),
                        ),
                        isExpanded: true,
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

            const SizedBox(height: 10.0,),
            const Divider(color: Colors.black12, thickness: 2,),
            const SizedBox(height: 10.0,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 5.0,),
            
                  //champ de date aller
                  Flexible(
                    child: TextField(
                      controller: dateToGoController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        label: const Text('Date Aller'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12.0)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(12.0)
                        )
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2040)
                        );
            
                        if (pickedDate != null) {
                          setState(() {
                            dateToGoController.text = DateFormat('dd-MMM-yyyy').format(pickedDate);
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0,),
            
                  //champ de date retour
                  Flexible(
                    child: TextField(
                      controller: dateToBackController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        label: const Text('Date Retour'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12.0)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(12.0)
                        )
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2040)
                        );
            
                        if (pickedDate != null) {
                          setState(() {
                            dateToBackController.text = DateFormat('dd-MMM-yyyy').format(pickedDate);
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0,),

            //bouton coulissant aller-retour
            switchButton(toogleValue),
            const SizedBox(height: 20.0,),

            //bouton pour le lancement des recherches de voyages
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ResultSearch())
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                elevation: MaterialStateProperty.all(0.1),
                minimumSize: MaterialStateProperty.all(
                  const Size(200, 50)
                )
              ),
              child: const Text(
                'Lancer la recherche',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
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
              label: 'Accueil',
              activeIcon: Icon(
                Icons.home_rounded,
                color: Colors.orange,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code_2_outlined,
                color: Colors.black,
              ),
              label: 'Réservations',
              activeIcon: Icon(
                Icons.qr_code_2_rounded,
                color: Colors.orange,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
                color: Colors.black,
              ),
              label: 'Mon profil',
              activeIcon: Icon(
                Icons.person_2_rounded,
                color: Colors.orange,
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
      onChanged: (bool b) {
        setState(() => toogleValue = !b);
        return Future.delayed(const Duration(milliseconds: 300));
      },
      colorBuilder: (b) => b ? Colors.grey[3] : Colors.orange,
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



