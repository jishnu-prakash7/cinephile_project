// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Maintitle of App

Widget maintitle() {
  return RichText(
      text: TextSpan(children: [
    TextSpan(
        text: 'Cine',
        style: GoogleFonts.ubuntu(
            textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold))),
    TextSpan(
        text: 'p',
        style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                color: Colors.green,
                fontSize: 35,
                fontWeight: FontWeight.bold))),
    TextSpan(
        text: 'hile',
        style: GoogleFonts.ubuntu(
            textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)))
  ]));
}
