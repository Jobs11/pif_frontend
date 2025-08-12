import 'package:flutter/material.dart';

Container searchbt(String title) {
  return Container(
    width: 105,
    height: 20,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.black),
    ),
    child: Text(title, style: TextStyle(fontSize: 15)),
  );
}
