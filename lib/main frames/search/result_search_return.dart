import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:izi_travel/main%20frames/home_frame.dart';

class ResultSearch extends StatefulWidget {
  const ResultSearch({Key? key}) : super(key: key);

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  CollectionReference departureCollection =
      FirebaseFirestore.instance.collection('HeureDepart');
    
  late List<Map<String, dynamic>> items;
   final selectedDeparture =  const HomeFrame();
  HomeFrame selectedDestination = const HomeFrame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Voyage Retour',
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
                content: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.blue,
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
                      isThreeLine: false,
                      dense: true,
                      onTap: () {
                        
                      },
                      leading: SizedBox(
                        height: 200,
                        child: ClipRRect(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(50),
                            child: Image.asset(
                                "lib/images/image_bus_1.png",
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                          ),
                        ),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "$selectedDeparture   \n   ————————   \n   $selectedDestination",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${documentSnapshot['Départ']}      ${documentSnapshot['Prix']} XAF     ${documentSnapshot['Place']} places"
                      ),
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
