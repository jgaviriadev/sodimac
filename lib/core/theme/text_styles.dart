import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  TextStyles._(); 

  static TextStyle regular11({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.normal,
      fontSize: 11,
    );
  }

  static TextStyle regular12({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
  }

  static TextStyle regular13({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.normal,
      fontSize: 13,
    );
  }

  static TextStyle regular15({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.normal,
      fontSize: 15,
    );
  }

  static TextStyle regular18({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.normal,
      fontSize: 18,
    );
  }

  static TextStyle semiBold13({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );
  }

  static TextStyle semiBold15({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    );
  }

  static TextStyle semiBold20({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    );
  }

  static TextStyle bold13({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 13,
    );
  }

  static TextStyle bold15({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
  }

  static TextStyle bold28({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    );
  }

  static TextStyle italic15({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.w300,
      fontSize: 15,
      fontStyle: FontStyle.italic, 
    );
  }

    static TextStyle italicSemiBold18({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      fontStyle: FontStyle.italic, 
    );
  }
}