import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Warna {
  static const latar = Color(0xFFFBF5EA);
  static const hijau = Color(0xFF9AAA7C);
  static const hijauTua = Color(0xFF6F8A4E);
  static const hijauMuda = Color(0xFFC9D1AA);
  static const hijauPucat = Color(0xFFE7EBD6);
  static const pasir = Color(0xFFEFE3C8);
  static const cokelat = Color(0xFF5A3A22);
  static const redup = Color(0xFF9A8C7E);
  static const garis = Color(0xFFE6E0D6);
}

ThemeData buatTema() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Warna.latar,
      colorScheme: ColorScheme.fromSeed(seedColor: Warna.hijau),
      textTheme: GoogleFonts.poppinsTextTheme()
          .apply(bodyColor: Warna.cokelat, displayColor: Warna.cokelat),
    );