import 'package:flutter/material.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanDataDiri extends StatelessWidget {
  const HalamanDataDiri({super.key});

  @override
  Widget build(BuildContext context) {
    const data = [
      ('Nama', Siswa.nama),
      ('NIS', Siswa.nis),
      ('Kelas', Siswa.kelas),
      ('Email', Siswa.email),
    ];
    return HalamanDasar(
      isi: Column(children: [
        const BarAtas('Data Diri'),
        Kotak(
          ruang: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          isi: daftarBersekat([
            for (final d in data)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(children: [
                  SizedBox(
                      width: 70, child: Text(d.$1, style: const TextStyle(fontSize: 13, color: Warna.redup))),
                  Expanded(child: Text(d.$2, style: const TextStyle(fontWeight: FontWeight.w700))),
                ]),
              ),
          ]),
        ),
      ]),
    );
  }
}