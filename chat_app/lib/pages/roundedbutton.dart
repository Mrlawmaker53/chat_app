import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RoundedButton(
      {required this.colour, required this.title, required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
            onPressed: () => onPressed(),
            minWidth: 200,
            height: 42,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ), ),
      ),
    );
  }
}

void navPage(context, String id) {
  Navigator.pushNamed(context, id);
}
