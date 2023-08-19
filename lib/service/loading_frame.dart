import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:izi_travel/main%20frames/main_menu/home_frame.dart';

class LoadingFrame extends StatefulWidget {
  const LoadingFrame({super.key});

  @override
  State<LoadingFrame> createState() => _LoadingFrameState();
}

class _LoadingFrameState extends State<LoadingFrame> {

  @override
  void initState() {
    Timer(
      const Duration(
        milliseconds: 10000
      ), () => Navigator.push(
        context, CupertinoPageRoute(builder: (_) => const HomeFrame())
      )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(color: Colors.blue,),
            )
          ],
        ),
      ),
    );
  }
}