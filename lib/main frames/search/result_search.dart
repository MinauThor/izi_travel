import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:izi_travel/main%20frames/home_frame.dart';

class ResultSearch extends StatefulWidget {
  final String selectedDeparture;
  final String selectedDestination;
  const ResultSearch({
    Key? key,
    required this.selectedDeparture,
    required this.selectedDestination
    }) : super(key: key);

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  CollectionReference departureCollection =
      FirebaseFirestore.instance.collection('HeureDepart');
    
  late List<Map<String, dynamic>> items;
  final HomeFrame departures = const HomeFrame();
  final HomeFrame destinations = const HomeFrame();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Voyage Aller',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0.2,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: departureCollection.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return AlertDialog(
                content: Text("Error: ${snapshot.error.toString()}"),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.blueAccent,
              );
            }

            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                return Card(
                  elevation: 2.5,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: ListTile(
                      isThreeLine: true,
                      dense: true,
                      onTap: () {
                        
                      },
                      leading: SizedBox(
                        height: 200,
                        child: ClipRRect(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(50),
                            child: Image.asset(
                                "lib/images/logo_company.png",
                                fit: BoxFit.fill,
                              ), //it displays an image, which whe consider here as the logo of the transport company
                          ),
                        ),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "/*$departures.selectedDeparture   \n\n   ————————   \n\n   $destinations.selectedDestination \n\n",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                      ), // it returns the data in relation to the city of departure and the city of arrival
                      subtitle: Text(
                        "${documentSnapshot['Départ']}      ${documentSnapshot['Prix']} XAF     ${documentSnapshot['Place']} places"
                      ), //it returns data relating to the price of the trip, the number of seats available on the bus and the departure time
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
