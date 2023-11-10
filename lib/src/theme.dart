import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryClr = Color(0xFF4e5ae8);

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
  );
}

TextStyle get headingStyle1 {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
  );
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey[600]),
  );
}
