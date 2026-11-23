import 'package:flutter/material.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

/// Halaman Jadwal Pelajaran.
class HalamanPembelajaran extends StatefulWidget {
  final bool bisaKembali;
  const HalamanPembelajaran({super.key, this.bisaKembali = false});

  @override
  State<HalamanPembelajaran> createState() => _HalamanPembelajaranState();
}

class _HalamanPembelajaranState extends State<HalamanPembelajaran> {
  String hariDipilih = hariAktif();

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      bawahNav: !widget.bisaKembali,
      isi: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        BarAtas('Jadwal Pelajaran', kembali: widget.bisaKembali),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            for (final hari in daftarHari)
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 14),
                child: GestureDetector(
                  onTap: () => setState(() => hariDipilih = hari),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                    decoration: BoxDecoration(
                      color: hariDipilih == hari ? Warna.hijau : Colors.white,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(hari,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: hariDipilih == hari ? Colors.white : Warna.cokelat)),
                  ),
                ),
              ),
          ]),
        ),
        for (final j in jadwal[hariDipilih]!)
          Kotak(
            ruang: const EdgeInsets.all(18),
            isi: Row(children: [
              Emoji(mapel[j.$1]!.$2),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(j.$1, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Ikon(Icons.access_time, ukuran: 38, latar: Warna.hijauPucat),
                    const SizedBox(width: 8),
                    Text(j.$2, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  ]),
                ]),
              ),
            ]),
          ),
      ]),
    );
  }
}