import 'package:flutter/material.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanCbt extends StatefulWidget {
  const HalamanCbt({super.key});

  @override
  State<HalamanCbt> createState() => _HalamanCbtState();
}

class _HalamanCbtState extends State<HalamanCbt> {
  int nomor = 0, skor = 0;
  int? pilihan;

  void jawab(int n) {
    if (pilihan != null) return;
    final benar = daftarSoal[nomor].$3;
    setState(() {
      pilihan = n;
      if (n == benar) skor++;
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() {
          nomor++;
          pilihan = null;
        });
      }
    });
  }

  Widget _tampilSoal() {
    final s = daftarSoal[nomor];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Lencana('Soal ${nomor + 1}/${daftarSoal.length}'),
      const SizedBox(height: 14),
      Text(s.$1, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      for (var n = 0; n < s.$2.length; n++)
        GestureDetector(
          onTap: () => jawab(n),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: pilihan == null
                  ? Colors.white
                  : n == s.$3
                      ? Warna.hijauMuda
                      : n == pilihan
                          ? const Color(0xFFF3D9D2)
                          : Colors.white,
              border: Border.all(
                width: 2,
                color: pilihan == null
                    ? Warna.hijauMuda
                    : n == s.$3
                        ? Warna.hijau
                        : n == pilihan
                            ? const Color(0xFFC98A7A)
                            : Warna.hijauMuda,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(s.$2[n], style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ),
    ]);
  }

  Widget _tampilHasil() => Column(children: [
        Text('${(skor * 100 / daftarSoal.length).round()}',
            style: const TextStyle(fontSize: 52, fontWeight: FontWeight.w700, color: Warna.hijau)),
        Text('Benar $skor dari ${daftarSoal.length} soal'),
        Tombol('Selesai', saatDitekan: () => Navigator.pop(context)),
      ]);

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      isi: Column(children: [
        const BarAtas('Ujian CBT'),
        Kotak(isi: nomor >= daftarSoal.length ? _tampilHasil() : _tampilSoal()),
      ]),
    );
  }
}