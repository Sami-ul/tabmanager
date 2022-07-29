import 'package:flutter/material.dart';

var buttonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
    backgroundColor: MaterialStateProperty.all<Color>(
      Color.fromARGB(255, 114, 90, 250),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))));

var dangerButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
    backgroundColor: MaterialStateProperty.all<Color>(
      Color.fromARGB(255, 255, 117, 117),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))));
