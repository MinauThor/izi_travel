import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:izi_travel/identification/auth_page.dart';
import 'package:izi_travel/identification/otp_connection.dart';

class EmailOtpChoice extends StatefulWidget {
  const EmailOtpChoice({Key? key}) : super(key: key);

  @override
  State<EmailOtpChoice> createState() => _EmailOtpChoiceState();
}

class _EmailOtpChoiceState extends State<EmailOtpChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choisissez votre mode de connexion',
                style: GoogleFonts.balthazar(
                  fontSize: 35.0
                ),
              ),

              const SizedBox(height: 60.0,),

              // Button E-mail authentication
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                      )
                    )
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AuthPage())
                  ),
                  child: const Text(
                    'E-mail',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40.0,),

              //Button Phone authentication
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
                    )
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OtpConnection())
                  ),
                  child: const Text(
                    'Téléphone',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}