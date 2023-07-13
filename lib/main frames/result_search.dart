import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultSearch extends StatefulWidget {
  const ResultSearch({Key? key}) : super(key: key);

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  final departureCollection =
      FirebaseFirestore.instance.collection('HeureDepart').snapshots();
  late List<Map<String, dynamic>> items;

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
            stream: departureCollection,
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
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 2, color: Colors.transparent)),
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
