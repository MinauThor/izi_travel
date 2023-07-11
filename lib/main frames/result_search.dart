import 'package:flutter/material.dart';

class ResultSearch extends StatefulWidget {
  const ResultSearch({Key? key}) : super(key: key);

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          
        ),
      ),
    );
  }
}