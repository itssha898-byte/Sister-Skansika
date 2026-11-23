import 'package:flutter/material.dart';
import '../auth/masuk.dart';
import '../dataDiri/dataDiri.dart';
import '../izin/izin.dart';
import '../poin/poin.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanAkun extends StatelessWidget {
  const HalamanAkun({super.key});

  Widget _barisInfo(IconData ikon, String teks) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          Ikon(ikon),
          const SizedBox(width: 14),
          Expanded(child: Text(teks, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
        ]),
      );

  void _buka(BuildContext context, Widget halaman) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => halaman));

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      bawahNav: true,
      isi: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Logo(),
        SizedBox(
          height: 220,
          child: Stack(alignment: Alignment.center, children: [
            Container(
              width: 300,
              height: 190,
              decoration: const BoxDecoration(
                color: Warna.hijauMuda,
                borderRadius: BorderRadius.all(Radius.elliptical(150, 95)),
              ),
            ),
            const Text('📚🎒✏️', style: TextStyle(fontSize: 64)),
          ]),
        ),
        GestureDetector(
          onTap: () => _buka(context, const HalamanDataDiri()),
          child: Kotak(
            ruang: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            isi: daftarBersekat([
              _barisInfo(Icons.person_outline, Siswa.nama),
              _barisInfo(Icons.badge_outlined, 'NIS: ${Siswa.nis}'),
              _barisInfo(Icons.school_outlined, 'Kelas: ${Siswa.kelas}'),
              _barisInfo(Icons.mail_outline, 'Email: ${Siswa.email}'),
            ]),
          ),
        ),
        const JudulBagian('Pengaturan'),
        Kotak(
          ruang: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          isi: daftarBersekat(const [
            BarisMenu(Icons.notifications_none, 'Notifikasi'),
            BarisMenu(Icons.language, 'Bahasa'),
            BarisMenu(Icons.shield_outlined, 'Keamanan'),
          ]),
        ),
        const JudulBagian('Lainnya'),
        Kotak(
          ruang: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          isi: daftarBersekat([
            BarisMenu(Icons.star_border, 'Poin Kedisiplinan',
                saatDitekan: () => _buka(context, const HalamanPoin())),
            BarisMenu(Icons.description_outlined, 'Pengajuan Izin',
                saatDitekan: () => _buka(context, const HalamanIzin())),
          ]),
        ),
        Tombol('Keluar',
            garis: true,
            ikon: Icons.logout,
            saatDitekan: () {
              aplikasi.sudahMasuk = false;
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (_) => const HalamanMasuk()), (r) => false);
            }),
      ]),
    );
  }
}