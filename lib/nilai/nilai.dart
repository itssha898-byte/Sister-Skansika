import 'package:flutter/material.dart';
import '../cbt/cbt.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanNilai extends StatelessWidget {
  const HalamanNilai({super.key});

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      bawahNav: true,
      isi: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Logo(),
          Text('🍪', style: TextStyle(fontSize: 60)),
        ]),
        const SizedBox(height: 10),
        const Text('Nilai Siswa', style: TextStyle(fontSize: 44, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        const Lencana('Semester Genap',
            ikon: Icons.calendar_month_outlined,
            ukuranTeks: 15,
            ruang: EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
        const SizedBox(height: 18),
        for (var i = 0; i < daftarNilai.length; i++)
          Kotak(
            ruang: const EdgeInsets.all(18),
            isi: Row(children: [
              Ikon(mapel[daftarNilai[i].$1]!.$1,
                  ukuran: 62,
                  kotak: true,
                  warna: Warna.hijauTua,
                  latar: i.isOdd ? const Color(0xFFEFE7D6) : Warna.hijauPucat),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(daftarNilai[i].$1, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Batang(daftarNilai[i].$2),
                ]),
              ),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('${daftarNilai[i].$2}', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700)),
                Lencana(daftarNilai[i].$2 >= 90 ? 'Sangat Baik' : 'Baik',
                    ikon: Icons.star_border,
                    latar: Warna.hijauPucat,
                    warnaTeks: Warna.hijauTua,
                    ukuranTeks: 12),
              ]),
            ]),
          ),
        Tombol('Mulai Ujian CBT',
            gelap: true,
            ikon: Icons.assignment_outlined,
            saatDitekan: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HalamanCbt()))),
      ]),
    );
  }
}