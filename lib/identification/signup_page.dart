import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:izi_travel/main%20frames/main_menu/home_frame.dart';
import 'package:izi_travel/service/auth_service.dart';
import 'package:izi_travel/service/loading_frame.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpPage({
    Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  //text controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
      //create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      addUserDetails(_usernameController.text, _emailController.text);
  }

  sendUserDataToDB() async {
    final auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;

    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');
    return collectionRef.doc(currentUser?.email).set({
      "name": _usernameController.text.trim(),
      "email": _emailController.text.trim()
    }).then((value) => null);
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      //returnDialogError();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      return false;
    }
  }

  /*void returnDialogError() {
    showDialog(
      context: context,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: const Text('Mots de passe non identiques'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      });
  }*/

  Future addUserDetails(String username, String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'username': username, 'email': email}).then((value) =>
            Navigator.push(
                context, MaterialPageRoute(builder: (_) =>  const HomeFrame()
        )
      )
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 75,),
                Text(
                  'Izi Travel',
                  style: GoogleFonts.lobster(
                    fontSize: 52,
                    color: Colors.blueAccent
                  ),
                ),
                const SizedBox(height: 20,),
                
                //Name textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.black)
                      ),
                      label: const Text("Mot de passe", style: TextStyle(color: Colors.blueAccent),),
                      prefixIcon: const Icon(Icons.person_rounded),
                      fillColor: Colors.white,
                      filled: true
                    )
                  ),
                ),
        
                const SizedBox(height: 20,),
        
                //email textfield
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.black)
                      ),
                      label: const Text("Email", style: TextStyle(color: Colors.black),),
                      prefixIcon: const Icon(Icons.alternate_email),
                      prefixIconColor: Colors.blueAccent,
                      fillColor: Colors.white,
                      filled: true
                    )
                  ),
                ),
                
                const SizedBox(height: 20,),
        
                //password textfield
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.black)
                      ),
                      label: const Text("Mot de passe", style: TextStyle(color: Colors.black),),
                      prefixIcon: const Icon(Icons.lock),
                      prefixIconColor: Colors.blueAccent,
                      fillColor: Colors.white,
                      filled: true
                    )
                  ),
                ),
        
                const SizedBox(height: 50,),
        
                //sign up button
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0)
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      )
                    ),
                    onPressed: () {
                      signUp();
                    },
                    child: const Text(
                      'Inscription',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
        
                const SizedBox(height: 25,),

                const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        'Ou continuez avec',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //Bouton Google Sign In
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 20)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: Colors.black))),
                  onPressed: () {
                    AuthService().signInWithGoogle();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>  const LoadingFrame()));
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'lib/images/google_icon.png',
                        height: 25,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      const Text(
                        'Continuer avec Google',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
        
                //vous avez déjà un compte ? connectez-vous
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Vous avez déjà un compte ? ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        'Connectez-vous',
                        style: TextStyle(
                          color: Colors.blueAccent, fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
