import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:izi_travel/main%20frames/second/home_frame.dart';
import 'package:izi_travel/splash/email_otp_choice.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return const HomeFrame();
          } else {
            return const EmailOtpChoice();
          }
        },
      ),
    );
  }
}