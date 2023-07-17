import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:izi_travel/identification/forgot_password_page.dart';

class SignInPage extends StatefulWidget {

  final VoidCallback showSignUpPage;
  const SignInPage({
    Key? key, required this.showSignUpPage}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future singIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim()
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                const Icon(
                  Icons.directions_bus,
                  size: 100,
                ),
        
                const SizedBox(height: 25,),
        
                Text(
                  'Izi Travel',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52
                  ),
                ),
        
                const SizedBox(height: 50,),
        
                //email textfield
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.transparent)
                      ),
                      hintText: 'Votre email',
                      fillColor: Colors.white,
                      filled: true
                    ),
                  ),
                ),
        
                const SizedBox(height: 20,),
        
                //password textfield
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.black)
                      ),
                      hintText: 'Votre mot de passe',
                      fillColor: Colors.white,
                      filled: true
                    ),
                  ),
                ),
        
                const SizedBox(height: 40,),
        
                //sign in button
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      )
                    ),
                    onPressed: () {
                      singIn();
                    },
                    child: const Text(
                      'Connexion',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
        
                const SizedBox(height: 20,),
        
                //Vous n'avez pas de compte ? Inscrivez-vous
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Vous n\'avez pas de compte ? ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showSignUpPage,
                      child: const Text(
                        'Incrivez-vous',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
        
                const SizedBox(height: 10,),
        
                //mot de passe oublié ?
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const ForgotPasswordPage();
                            })
                          );
                        },
                      ),
                      const Text(
                        'Mot de passe oublié',
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}
