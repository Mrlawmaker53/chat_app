import 'package:flutter/material.dart';

const kSendButtonStyle = TextStyle(
    color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 18.0);
const kMessageTextFieldDectoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 10.0,
    ),
    border: InputBorder.none,
    hintText: 'Type your message');

const kMessageContainerDectoration = BoxDecoration(
    border: Border(top: BorderSide(color: Colors.blueAccent, width: 2.0)));
 var kTextFieldDecoration= InputDecoration(
          hintText: 'Enter your email',
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.circular(32),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2)));