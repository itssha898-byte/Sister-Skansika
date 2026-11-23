import 'package:flutter/material.dart';
import '../pengumuman/pengumuman.dart';
import '../presensi/presensi.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      bawahNav: true,
      isi: ListenableBuilder(
        listenable: aplikasi,
        builder: (context, _) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Logo(),
          const SizedBox(height: 26),
          const Text('Halo,\n${Siswa.nama}',
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700, height: 1.15)),
          const SizedBox(height: 16),
          const Lencana('Kelas: ${Siswa.kelas}',
              ikon: Icons.person_outline,
              ukuranTeks: 15,
              ruang: EdgeInsets.symmetric(horizontal: 22, vertical: 10)),
          const SizedBox(height: 12),
          Lencana(tanggalPanjang(),
              ikon: Icons.calendar_month_outlined,
              latar: Warna.pasir,
              ukuranTeks: 15,
              ruang: const EdgeInsets.symmetric(horizontal: 22, vertical: 10)),
          const SizedBox(height: 20),
          Kotak(
            isi: Column(children: [
              Row(children: [
                const Ikon(Icons.check, ukuran: 76, latar: Warna.hijauPucat, warna: Warna.hijauTua),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Presensi Hari Ini', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Kotak(
                      warna: Warna.hijauPucat,
                      jarak: EdgeInsets.zero,
                      ruang: const EdgeInsets.all(12),
                      isi: Row(children: [
                        const Ikon(Icons.check, ukuran: 36, latar: Warna.hijauTua, warna: Colors.white),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(aplikasi.statusHariIni ?? 'Belum absen',
                              style: TextStyle(
                                  fontSize: aplikasi.statusHariIni == null ? 18 : 24,
                                  fontWeight: FontWeight.w700,
                                  color: Warna.hijauTua)),
                        ),
                      ]),
                    ),
                  ]),
                ),
              ]),
              Container(
                margin: const EdgeInsets.only(top: 14),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(color: Warna.hijauPucat, borderRadius: BorderRadius.circular(18)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Flexible(
                    child: Row(children: [
                      Donat(aplikasi.persenHadir, ukuran: 64),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('${aplikasi.persenHadir}%',
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w700, color: Warna.hijauTua)),
                          const Text('Kehadiran', style: TextStyle(fontWeight: FontWeight.w600)),
                        ]),
                      ),
                    ]),
                  ),
                  Tombol('Lihat Absensi',
                      gelap: true,
                      kecil: true,
                      saatDitekan: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => const HalamanPresensi()))),
                ]),
              ),
            ]),
          ),
          Kotak(
            isi: Column(children: [
              const Row(children: [
                Ikon(Icons.calendar_month_outlined, ukuran: 38),
                SizedBox(width: 12),
                Text('Jadwal Hari Ini', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ]),
              const SizedBox(height: 6),
              daftarBersekat([
                for (final j in jadwal[hariAktif()]!)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(children: [
                      Ikon(mapel[j.$1]!.$1, ukuran: 42, latar: Warna.hijauPucat),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Text(j.$1, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700))),
                      Lencana(j.$2.substring(0, 5), latar: Warna.pasir),
                    ]),
                  ),
              ]),
            ]),
          ),
          Tombol('Pengumuman',
              garis: true,
              ikon: Icons.campaign_outlined,
              saatDitekan: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const HalamanPengumuman()))),
        ]),
      ),
    );
  }
}