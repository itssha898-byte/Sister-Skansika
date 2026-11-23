import 'package:flutter/material.dart';
import '../umum/data.dart';
import '../umum/kerangka.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanMasuk extends StatefulWidget {
  const HalamanMasuk({super.key});

  @override
  State<HalamanMasuk> createState() => _HalamanMasukState();
}

class _HalamanMasukState extends State<HalamanMasuk> {
  final nis = TextEditingController();
  final kataSandi = TextEditingController();
  bool tampilkanSandi = false;
  String pesanError = '';

  void masuk() {
    if (nis.text.trim().isEmpty) {
      return setState(() => pesanError = 'NIS / Username wajib diisi.');
    }
    if (kataSandi.text.length < 4) {
      return setState(() => pesanError = 'Password minimal 4 karakter.');
    }
    aplikasi.sudahMasuk = true;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const KerangkaUtama()));
  }

  @override
  void dispose() {
    nis.dispose();
    kataSandi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      isi: Column(children: [
        const SizedBox(height: 40),
        const Text('🍪', style: TextStyle(fontSize: 54)),
        const Text.rich(TextSpan(
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          children: [TextSpan(text: 'SISTER '), TextSpan(text: 'SKANSIKA', style: TextStyle(color: Warna.hijau))],
        )),
        const SizedBox(height: 26),
        Kotak(
          sudut: 36,
          ruang: const EdgeInsets.fromLTRB(24, 34, 24, 30),
          isi: Column(children: [
            const Ikon(Icons.school_outlined, ukuran: 84, latar: Warna.pasir, warna: Warna.hijau),
            const SizedBox(height: 14),
            const Text('Masuk sebagai', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, height: 1.2)),
            const Text('Siswa',
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700, color: Warna.hijau, height: 1.1)),
            const SizedBox(height: 12),
            KolomIsian(Icons.person_outline, 'NIS / Username', pengendali: nis),
            KolomIsian(Icons.lock_outline, 'Password',
                pengendali: kataSandi,
                sembunyi: !tampilkanSandi,
                akhiran: GestureDetector(
                  onTap: () => setState(() => tampilkanSandi = !tampilkanSandi),
                  child: const Icon(Icons.visibility_outlined, color: Warna.cokelat),
                )),
            if (pesanError.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(pesanError, style: const TextStyle(color: Color(0xFFB0533C), fontSize: 13)),
              ),
            const SizedBox(height: 6),
            Tombol('Masuk', saatDitekan: masuk),
            const SizedBox(height: 20),
            const Text('Lupa password?', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          ]),
        ),
      ]),
    );
  }
}