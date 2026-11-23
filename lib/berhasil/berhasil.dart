import 'package:flutter/material.dart';
import '../presensi/presensi.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanBerhasil extends StatelessWidget {
  const HalamanBerhasil({super.key});

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      gulir: false,
      isi: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(color: Warna.hijau, shape: BoxShape.circle),
          child: const Icon(Icons.check, color: Colors.white, size: 64),
        ),
        const SizedBox(height: 22),
        const Text('Absen berhasil', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        const Text('Kehadiranmu hari ini sudah tercatat.', style: TextStyle(color: Warna.redup)),
        const SizedBox(height: 34),
        Tombol('Kembali ke Beranda', saatDitekan: () => Navigator.popUntil(context, (r) => r.isFirst)),
        Tombol('Lihat Riwayat',
            garis: true,
            saatDitekan: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HalamanPresensi()))),
      ]),
    );
  }
}