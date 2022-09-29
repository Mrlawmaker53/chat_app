import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/pages/login_screen.dart';
import 'package:chat_app/pages/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/resigtration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(); //initilization of Firebase app

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen()
      },
    );
  }
}
