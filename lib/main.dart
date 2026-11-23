import 'package:flutter/material.dart';
import 'splash/splash.dart';
import 'umum/tema.dart';

void main() => runApp(const AplikasiSister());

class AplikasiSister extends StatelessWidget {
  const AplikasiSister({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Sister Skansika',
        debugShowCheckedModeBanner: false,
        theme: buatTema(),
        home: const HalamanSplash(),
      );
}