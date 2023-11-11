// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget RatingAndGenereSection(String rating, IconData icon, Color iconcolor) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          icon,
          color: iconcolor,
          size: 18,
        ),
      ),
      Text(
        rating,
        style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 176, 174, 174),
            fontWeight: FontWeight.w500),
      ),
    ],
  );
}
