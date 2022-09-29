import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/pages/login_screen.dart';
import 'package:chat_app/pages/resigtration_screen.dart';
import 'package:chat_app/pages/roundedbutton.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'Welcome_sceen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //late AnimationController animController;
  // late Animation animation;
  // late Animation animationtween;
  @override
  void initState() {
    super.initState();
//    animController =
//        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    //   animation =
    //       CurvedAnimation(parent: animController, curve: Curves.decelerate);

    //   animationtween = ColorTween(begin: Colors.grey, end: Colors.white)
    //       .animate(animController);
    //   animController.reverse(from: 1.0);
//     animation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         animController.reverse(from: 1.0);
//       } else if (status == AnimationStatus.dismissed) {
//         animController.forward();
//       }
//     });
//     animController.addListener(() {
// //      setState(() {});
//       print(animController.value);
//     });
  }

  @override
  void dispose() {
    //   animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                children: [
                  const Flexible(
                    child: Hero(
                      tag: 'logo ',
                      child: SizedBox(
                        height: 100,
                        child:
                            Icon(Icons.flash_on, color: Colors.yellow, size: 60),
                      ),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  TypewriterAnimatedTextKit(
                      text: const ['Flash chat'],
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ),
            RoundedButton(
                colour: Colors.lightBlue,
                title: 'Log in',
                onPressed: () => navPage(context, LoginScreen.id)),
            RoundedButton(
                colour: Colors.blueAccent,
                title: 'Regisration ',
                onPressed: () => navPage(context, RegistrationScreen.id))
          ],
        ),
      ),
    );
  }
}
