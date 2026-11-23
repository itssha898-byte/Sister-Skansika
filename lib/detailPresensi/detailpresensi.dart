import 'package:flutter/material.dart';
import '../berhasil/berhasil.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanDetailPresensi extends StatelessWidget {
  const HalamanDetailPresensi({super.key});

  Widget _baris(IconData ikon, String nilai, String keterangan) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(children: [
          Ikon(ikon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(nilai, style: const TextStyle(fontWeight: FontWeight.w700)),
              Text(keterangan, style: const TextStyle(fontSize: 13, color: Warna.redup)),
            ]),
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      isi: Column(children: [
        const BarAtas('Konfirmasi Absen'),
        Kotak(
          isi: daftarBersekat([
            _baris(Icons.calendar_month_outlined, tanggalPanjang(), 'Tanggal'),
            _baris(Icons.access_time, jamSekarang(), 'Waktu absen'),
            _baris(Icons.school_outlined, Siswa.nama, 'Kelas ${Siswa.kelas}'),
          ]),
        ),
        Tombol('Konfirmasi Hadir', saatDitekan: () {
          aplikasi.absen();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HalamanBerhasil()));
        }),
      ]),
    );
  }
}