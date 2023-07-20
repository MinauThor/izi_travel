import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:izi_travel/identification/my_button.dart';
import 'package:izi_travel/identification/my_text_field.dart';
import 'package:izi_travel/main%20frames/home_screen.dart';
import 'package:izi_travel/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const LoginPage({super.key, required this.showSignUpPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future singIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),

              //Icon
              const Icon(
                Icons.bus_alert_outlined,
                size: 50,
              ),
              const SizedBox(
                height: 30,
              ),

              //IziTravel
              const Text(
                'Izi Travel',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),

              const SizedBox(
                height: 25.0,
              ),

              //email textfield
              MyTextField(
                  text: "Email",
                  controller: emailController,
                  obscureText: false),

              const SizedBox(
                height: 15,
              ),

              //password textfield
              MyTextField(
                  text: "Mot de passe",
                  controller: passwordController,
                  obscureText: true),

              const SizedBox(
                height: 15.0,
              ),

              //Mot de passe oublié
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Mot de passe oublié ? ',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 25.0,
              ),

              //bouton de connexion
              MyButton(onTap: singIn),

              const SizedBox(
                height: 40,
              ),

              //or continue with
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
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

              const SizedBox(
                height: 30,
              ),

              //Vous n'avez pas de compte ? Créez-en un
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Vous n\'avez pas de compte ? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    onTap: widget.showSignUpPage,
                    child: const Text(
                      'Créez votre compte',
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
