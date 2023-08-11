import 'package:flutter/material.dart';

InputDecoration getLabelDecoration(String Label) {
  return InputDecoration(
    labelText: Label,
    hintText: Label,
    fillColor: Color.fromARGB(255, 104, 230, 247),
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 67, 170, 175), width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 9, 64, 71), width: 2),
    ),
  );
}
