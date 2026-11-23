import 'package:flutter/material.dart';
import '../auth/masuk.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanSplash extends StatefulWidget {
  const HalamanSplash({super.key});

  @override
  State<HalamanSplash> createState() => _HalamanSplashState();
}

class _HalamanSplashState extends State<HalamanSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HalamanMasuk()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      gulir: false,
      isi: Center(
        child: Kotak(
          sudut: 40,
          ruang: const EdgeInsets.symmetric(vertical: 90),
          isi: const Column(mainAxisSize: MainAxisSize.min, children: [
            Text('🏫', style: TextStyle(fontSize: 84)),
            Text('SISTER', style: TextStyle(fontSize: 52, fontWeight: FontWeight.w700, height: 1)),
            Text('SKANSIKA',
                style: TextStyle(fontSize: 46, fontWeight: FontWeight.w700, color: Warna.hijau, height: 1.1)),
            SizedBox(height: 14),
            Text('Sistem Informasi Siswa Terpadu', style: TextStyle(fontWeight: FontWeight.w500)),
          ]),
        ),
      ),
    );
  }
}