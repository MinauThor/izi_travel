import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            content: const Text('Vous recevrez un lien pour réinitialiser votre mot de passe. Vérifier votre boîte mail'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Okay'),
                onPressed: () => Navigator.pop(context)
              )
            ]
          );
        }
      );
    } on FirebaseAuthException catch(e) {
      showDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            content: Text(e.message.toString()),
            actions: [
              CupertinoDialogAction(
                child: const Text('Okay'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Entrez votre adresse mail !',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),

          const SizedBox(height: 10.0,),

          //email textfield

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.transparent)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.transparent)
                ),
                hintText: 'Votre adresse e-mail',
                fillColor: Colors.grey[200],
                filled: true
              ),
            ),
          ),

          const SizedBox(height: 10,),

          //Reset button

          MaterialButton(
            onPressed: (() => resetPassword()),
            color: Colors.orange,
            child: const Text('Réinitialiser le mot de passe'),
          )
        ],
      )
    );
  }
}