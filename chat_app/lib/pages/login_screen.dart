import 'package:chat_app/constrant.dart';
import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/pages/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'Login_Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  var email = "";
  var password = "";
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                child: Hero(
                  tag: 'logo ',
                  child: SizedBox(
                    height: 200,
                    child:
                        Icon(Icons.flash_on, color: Colors.yellow, size: 200),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = '$value@gmail.com';
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your phone number'))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your Password')),
              ),
              RoundedButton(
                  colour: Colors.blueAccent,
                  title: 'Log in',
                  onPressed: () async {
                    try {
                      setState(() {
                        showSpinner = true;
                      });

                      final user = _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      // ignore: unnecessary_null_comparison
                      if (user != null) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, ChatScreen.id);
                      }

                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e
                            .toString()
                            .replaceAll('email address', 'mobile number')
                            .split(']')[1]),
                      ));
                      setState(() {
                        showSpinner = false;
                      });
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
