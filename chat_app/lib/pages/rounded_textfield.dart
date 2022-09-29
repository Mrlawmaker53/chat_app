// ignore: file_names
import 'package:flutter/material.dart';

import '../constrant.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {},
      decoration: kTextFieldDecoration   );
  }
}
