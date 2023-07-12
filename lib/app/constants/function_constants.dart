// Input Decoration
import 'package:flutter/material.dart';

// input form field decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)));
}

// Text button
TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    onPressed: () => onPressed(),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(vertical: 10))),
  );
}

//  login Register Hint
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(
          label,
          style: const TextStyle(color: Colors.blue),
        ),
        onTap: () => onTap(),
      )
    ],
  );
}

//like and comment btn
Expanded kLikeAndComment(
    int value, IconData icon, Color color, Function onTap) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: ()=>onTap(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(
                width: 4,
              ),
              Text('${value}'),
            ],
          ),
        ),
      ),
    ),
  );
}
