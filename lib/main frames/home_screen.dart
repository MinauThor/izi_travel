import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:izi_travel/main%20frames/header_section.dart';
import 'package:izi_travel/main%20frames/result_search.dart';
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
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Stream<QuerySnapshot> getData() {
      return firestore.collection('Destination').snapshots();
    }

    String? selectedDestination;
    String? selectedDeparture;
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
              Column(
                children: [
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
                      const SizedBox(height: 20.0,),
                      ///Champ de text pour la ville de départ
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.map_outlined,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          //CustomTextField(label: 'De', controller: dateGoTextController,)
                          StreamBuilder<QuerySnapshot>(
                            stream: getData(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              List<DropdownMenuItem<String>> departureItems = [];
                              if (!snapshot.hasData) {
                                return AlertDialog(
                                  content: Text(snapshot.error.toString()),
                                );
                              }

                              if(snapshot.connectionState == ConnectionState.waiting) {
                                return const LinearProgressIndicator();
                              }
                                
                              for (var document in snapshot.data!.docs) {
                                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                String departureVal = data['Ville'];
                                departureItems.add(
                                  DropdownMenuItem(
                                    value: departureVal,
                                    alignment: AlignmentDirectional.center,
                                    child: Text(departureVal),
                                  )
                                );
                              }
                              
                              return Column(
                                children: [
                                  DropdownButton<String>(
                                    items: departureItems,
                                    onChanged: (departureValue) {
                                      setState(() {
                                        selectedDeparture = departureValue;
                                      });
                                    },
                                    value: selectedDeparture,
                                    isExpanded: false,
                                    isDense: true,
                                    hint: const Text('Ville de départ'),
                                    icon: const Icon(Icons.arrow_drop_down_sharp, size: 25.0,),
                                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),

                      const SizedBox(height: 40.0,),

                      ///Champ de texte pour la ville de destination
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          //CustomTextField(label: 'De', controller: dateGoTextController,)
                          StreamBuilder<QuerySnapshot>(
                            stream: getData(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              List<DropdownMenuItem<String>> destinationItems = [];
                              if (!snapshot.hasData) {
                                return AlertDialog(
                                  content: Text(snapshot.error.toString()),
                                );
                              }

                              if(snapshot.connectionState == ConnectionState.waiting) {
                                return const LinearProgressIndicator();
                              }
                                
                              for (var document in snapshot.data!.docs) {
                                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                String destinationVal = data['Ville'];
                                destinationItems.add(
                                  DropdownMenuItem(
                                    value: destinationVal,
                                    alignment: AlignmentDirectional.center,
                                    child: Text(destinationVal),
                                  )
                                );
                              }
                              
                              return DropdownButton<String>(
                                alignment: AlignmentDirectional.centerStart,
                                items: destinationItems,
                                onChanged: (destinationValue) {
                                  setState(() {
                                    selectedDestination = destinationValue;
                                  });
                                },
                                value: selectedDestination,
                                isExpanded: false,
                                autofocus: true,
                                isDense: true,
                                hint: const Text('Ville d\'arrivée'),
                                icon: const Icon(Icons.arrow_drop_down_sharp, size: 25.0,),
                                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                                borderRadius: BorderRadius.circular(12.0),
                              );
                            },
                          )
                        ],
                      ),

                      const SizedBox(height: 20.0,),
                      const Divider(color: Colors.black12, thickness: 2,),
                      const SizedBox(height: 15.0,),

                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),

                          //Champ de texte date aller
                          CustomTextField(
                            label: 'De',
                            controller: dateGoTextController,
                          ),
                          const SizedBox(width: 10.0),

                          //Champ de texte date retour
                          CustomTextField(
                            label: 'A',
                            controller: dateToTextController,
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 35.0,
                      ),

                      //Switch button aller-retour
                      switchButton(toogleValue),

                      const SizedBox(
                        height: 35,
                      ),

                      //Bouton de recherche des voyages
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context, MaterialPageRoute(builder: (_) => const ResultSearch())
                            );
                          },
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
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.orange,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Colors.black),
              label: 'Accueil',
              activeIcon: Icon(
                Icons.home_rounded,
                color: Colors.orange,
              )),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined, color: Colors.black),
            activeIcon: Icon(
              Icons.map_rounded,
              color: Colors.orange,
            ),
            label: 'Planifier',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_2_outlined, color: Colors.black),
              activeIcon: Icon(
                Icons.qr_code_2_rounded,
                color: Colors.orange,
              ),
              label: 'Réservations'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined, color: Colors.black),
              activeIcon: Icon(
                Icons.person_2_rounded,
                color: Colors.orange,
              ),
              label: 'Mon compte'),
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
      height: 55,
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

/*final destinations =
    snapshot.data?.docs.reversed.toList();
destinationItems.add(
  const DropdownMenuItem(
    value: "0",
    child: Text("Ville de départ"),
  ),
);*/

/*for (var doc in snapshot.data!.docs) {
  destinationItems.add(
    DropdownMenuItem(
      value: doc.id,
      child: Text(doc.id),
    )
  );
}*/

/*for (var destination in destinations!) {
  destinationItems.add(DropdownMenuItem(
    value: destination.id,
    child: Text(destination.id),
  ));
}*/

/*StreamBuilder(
  stream: getData(),
  builder: (BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot) {
    List<DropdownMenuItem<String>> destinationItems =
        [];
    if (!snapshot.hasData) {
      return AlertDialog(
        content: Text(snapshot.error.toString())
      );
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
          selectedDeparture = destinationValue;
        });
      }),
      value: selectedDeparture,
      isExpanded: false,
    );
  },
)*/