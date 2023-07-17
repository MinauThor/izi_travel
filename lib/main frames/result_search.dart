import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:izi_travel/main%20frames/home_screen.dart';

class ResultSearch extends StatefulWidget {
  const ResultSearch({Key? key}) : super(key: key);

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  CollectionReference departureCollection =
      FirebaseFirestore.instance.collection('HeureDepart');
  late List<Map<String, dynamic>> items;
  List departure = [];
  HomeScreen selectedDeparture = const HomeScreen();
  HomeScreen selectedDestination = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Départs',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0.2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: departureCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return AlertDialog(
                  content: Text(snapshot.error.toString()),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.orange,
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
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      isThreeLine: true,
                      dense: true,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12.5),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(40),
                          child: Image.asset(
                              "C:/Users/HP/AndroidStudioProjects/izi_travel/lib/images/image_bus_2.png"),
                        ),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "${selectedDeparture as String} ———————— ${selectedDestination as String}",
                        style:
                            const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${documentSnapshot['Départ']}      ${documentSnapshot['Prix'].toString()}     ${documentSnapshot['Place'].toString()}"
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
