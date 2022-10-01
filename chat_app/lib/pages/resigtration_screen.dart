import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/pages/roundedbutton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constrant.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static String id = 'Registration_Screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController txtcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
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
                  child: Icon(Icons.flash_on, color: Colors.yellow, size: 200),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: txtcontroller,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = '$value@gmail.com';
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your phone number'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passcontroller,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Password',
                ),
              ),
            ),
            RoundedButton(
                colour: Colors.blueAccent,
                title: 'Registration',
                onPressed: () async {
                  //  print('${email} \n ${password}');
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    
                    // ignore: unnecessary_null_comparison
                    if (newUser != null) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, ChatScreen.id);
                      txtcontroller.clear();
                      passcontroller.clear();
                      
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
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                })
          ],
        ),
      ),
    ));
  }
}
