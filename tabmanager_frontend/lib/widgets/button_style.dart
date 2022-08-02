import 'package:flutter/material.dart'
    show
        BorderRadius,
        ButtonStyle,
        Color,
        EdgeInsets,
        MaterialStateProperty,
        RoundedRectangleBorder;

final buttonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(8)),
    backgroundColor: MaterialStateProperty.all<Color>(
      const Color.fromARGB(255, 114, 90, 250),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))));

final dangerButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(8)),
    backgroundColor: MaterialStateProperty.all<Color>(
      const Color.fromARGB(255, 255, 117, 117),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))));
