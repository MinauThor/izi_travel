import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:izi_travel/main%20frames/header_section.dart';
import 'package:izi_travel/main%20frames/search_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.location_on_rounded),
    Icon(Icons.qr_code),
    Icon(Icons.person)
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool toogleValue = false;

    String? selectedDestination = "";
    //List destinationItemList = [];
    final dateGoTextController = TextEditingController();
    final dateToTextController = TextEditingController();

    dateGoTextController.text = dateToTextController.text =
        DateFormat('dd.MM.yyyy').format(DateTime.now());
    //departureTextController.text = "";

    return Scaffold(
      backgroundColor: Colors.orange,

      //App Bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        centerTitle: false,
        title: const Text(
          'IziTravel',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),

      //Body of the app
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                margin: EdgeInsets.only(top: size.height * 0.25),
                color: Colors.white,
              ),
              Column(children: [
                const HeaderSection(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.white70.withAlpha(50),
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.map_outlined,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          //CustomTextField(label: 'De', controller: dateGoTextController,)
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Destinations')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              List<DropdownMenuItem<String>> destinationItems =
                                  [];
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              } else {
                                final destinations =
                                    snapshot.data?.docs.reversed.toList();
                                destinationItems.add(
                                  const DropdownMenuItem(
                                    value: "0",
                                    child: Text("Ville de départ"),
                                  ),
                                );
                                for (var destination in destinations!) {
                                  destinationItems.add(DropdownMenuItem(
                                    value: destination.id,
                                    child: Text(destination.id),
                                  ));
                                }
                              }
                              return DropdownButton<String>(
                                items: destinationItems,
                                onChanged: ((destinationValue) {
                                  setState(() {
                                    selectedDestination = destinationValue;
                                  });
                                }),
                                value: selectedDestination,
                                isExpanded: true,
                              );
                            },
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          //CustomTextField(label: 'De', controller: dateGoTextController,)
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Destinations')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              List<DropdownMenuItem<String>> destinationItems =
                                  [];
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              } else {
                                final destinations =
                                    snapshot.data?.docs.reversed.toList();
                                destinationItems.add(
                                  const DropdownMenuItem(
                                    value: "0",
                                    child: Text("Ville d'arrivée"),
                                  ),
                                );
                                for (var destination in destinations!) {
                                  destinationItems.add(DropdownMenuItem(
                                    value: destination.id,
                                    child: Text(destination.id),
                                  ));
                                }
                              }
                              return DropdownButton<String>(
                                items: destinationItems,
                                onChanged: ((destinationValue) {
                                  setState(() {
                                    selectedDestination = destinationValue;
                                  });
                                }),
                                value: selectedDestination,
                                isExpanded: true,
                              );
                            },
                          )
                        ],
                      ),

                      const Divider(),

                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextField(
                            label: 'De',
                            controller: dateGoTextController,
                          ),
                          CustomTextField(
                            label: 'A',
                            controller: dateToTextController,
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 12.0,
                      ),

                      //Switch button aller-retour
                      AnimatedToggleSwitch<bool>.dual(
                        current: toogleValue,
                        first: false,
                        second: true,
                        dif: 50.0,
                        borderColor: Colors.transparent,
                        borderWidth: 5.0,
                        height: 25,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1.5),
                          )
                        ],
                        onChanged: (b) {
                          setState(() => toogleValue = b);
                          return Future.delayed(
                              const Duration(milliseconds: 500));
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
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //Bouton de recherche des voyages
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange),
                              elevation: MaterialStateProperty.all(0.1),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(200, 50))),
                          child: const Text(
                            'Rechercher les départs',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                )
                //SearchCard()
              ])
            ],
          )),

      //Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined), label: 'Planifier'),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code), label: 'Réservations'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Compte'),
        ],
      ),
    );
  }
}
