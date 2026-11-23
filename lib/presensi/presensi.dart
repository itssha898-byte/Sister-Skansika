import 'package:flutter/material.dart';
import '../detailPresensi/detailPresensi.dart';
import '../izin/izin.dart';
import '../pembelajaran/pembelajaran.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanPresensi extends StatelessWidget {
  const HalamanPresensi({super.key});

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      isi: ListenableBuilder(
        listenable: aplikasi,
        builder: (context, _) {
          final p = aplikasi;
          final sudahAbsen = p.statusHariIni != null;
          final statistik = [
            (Icons.check, 'Hadir', p.jumlahHadir),
            (Icons.description_outlined, 'Izin', p.jumlahIzin),
            (Icons.thermostat, 'Sakit', p.jumlahSakit),
            (Icons.person_off_outlined, 'Alpha', p.jumlahAlpha),
          ];
          return Column(children: [
            Row(children: [
              const Logo(),
              const Expanded(
                  child: Center(
                      child: Text('Presensi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)))),
              InkWell(
                borderRadius: BorderRadius.circular(99),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HalamanPembelajaran(bisaKembali: true))),
                child: const Ikon(Icons.calendar_month_outlined, latar: Warna.pasir),
              ),
            ]),
            const SizedBox(height: 14),
            Kotak(
              isi: Row(children: [
                Donat(p.persenHadir,
                    ukuran: 150,
                    isi: Text('${p.persenHadir}%',
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w700))),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Persentase Kehadiran',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text('${p.persenHadir}%',
                        style: const TextStyle(fontSize: 52, fontWeight: FontWeight.w700, color: Warna.hijau)),
                    Batang(p.persenHadir),
                  ]),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(children: [
                for (var i = 0; i < statistik.length; i++) ...[
                  if (i > 0) const SizedBox(width: 10),
                  Expanded(
                    child: Kotak(
                      jarak: EdgeInsets.zero,
                      ruang: const EdgeInsets.symmetric(vertical: 14),
                      isi: Column(children: [
                        Ikon(statistik[i].$1, ukuran: 42),
                        const SizedBox(height: 8),
                        Text(statistik[i].$2, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        Text('${statistik[i].$3}',
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Warna.hijau)),
                      ]),
                    ),
                  ),
                ],
              ]),
            ),
            Kotak(
              isi: Column(children: [
                const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Riwayat Presensi', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
                  Ikon(Icons.access_time, ukuran: 40),
                ]),
                for (final r in p.riwayat.take(6))
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Warna.garis),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(children: [
                      const Ikon(Icons.calendar_month_outlined, ukuran: 42, kotak: true),
                      const SizedBox(width: 12),
                      Expanded(child: Text(r.$1, style: const TextStyle(fontWeight: FontWeight.w700))),
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Warna.hijauMuda, borderRadius: BorderRadius.circular(99)),
                        child: Text(r.$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      ),
                    ]),
                  ),
              ]),
            ),
            Tombol(sudahAbsen ? 'Sudah absen hari ini' : 'Absen Sekarang',
                saatDitekan: sudahAbsen
                    ? null
                    : () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const HalamanDetailPresensi()))),
            Tombol('Ajukan Izin',
                garis: true,
                saatDitekan: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HalamanIzin()))),
          ]);
        },
      ),
    );
  }
}