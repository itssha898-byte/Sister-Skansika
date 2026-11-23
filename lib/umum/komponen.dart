import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'tema.dart';

Widget _lingkaran(double ukuran, Color warna) => Container(
    width: ukuran, height: ukuran, decoration: BoxDecoration(color: warna, shape: BoxShape.circle));

const _bayangan = BoxShadow(color: Color(0x145A3A22), blurRadius: 18, offset: Offset(0, 6));

/// Kerangka dasar tiap halaman: latar krem + lingkaran dekorasi.
class HalamanDasar extends StatelessWidget {
  final Widget isi;
  final bool bawahNav, gulir;
  const HalamanDasar({super.key, required this.isi, this.bawahNav = false, this.gulir = true});

  @override
  Widget build(BuildContext context) {
    final ruang = EdgeInsets.fromLTRB(20, 22, 20, bawahNav ? 120 : 24);
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Positioned(top: -130, right: -150, child: _lingkaran(380, Warna.hijauPucat)),
        Positioned(bottom: -150, left: -130, child: _lingkaran(300, const Color(0xFFF3EBD8))),
        SafeArea(
          child: gulir
              ? SingleChildScrollView(padding: ruang, child: isi)
              : Padding(padding: ruang, child: isi),
        ),
      ]),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});
  @override
  Widget build(BuildContext context) => const Text('SISTER\nSKANSIKA',
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, height: 1.1));
}

class Kotak extends StatelessWidget {
  final Widget isi;
  final EdgeInsets ruang, jarak;
  final Color warna;
  final double sudut;
  const Kotak({
    super.key,
    required this.isi,
    this.ruang = const EdgeInsets.all(16),
    this.jarak = const EdgeInsets.only(bottom: 14),
    this.warna = Colors.white,
    this.sudut = 24,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: jarak,
        padding: ruang,
        decoration: BoxDecoration(
          color: warna,
          borderRadius: BorderRadius.circular(sudut),
          boxShadow: warna == Colors.white ? const [_bayangan] : null,
        ),
        child: isi,
      );
}

class Lencana extends StatelessWidget {
  final String teks;
  final IconData? ikon;
  final Color latar, warnaTeks;
  final double ukuranTeks;
  final EdgeInsets ruang;
  const Lencana(this.teks,
      {super.key,
      this.ikon,
      this.latar = Warna.hijauMuda,
      this.warnaTeks = Warna.cokelat,
      this.ukuranTeks = 13,
      this.ruang = const EdgeInsets.symmetric(horizontal: 14, vertical: 5)});

  @override
  Widget build(BuildContext context) => Container(
        padding: ruang,
        decoration: BoxDecoration(color: latar, borderRadius: BorderRadius.circular(99)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (ikon != null) ...[Icon(ikon, size: ukuranTeks + 4, color: warnaTeks), const SizedBox(width: 6)],
          Text(teks, style: TextStyle(fontSize: ukuranTeks, fontWeight: FontWeight.w600, color: warnaTeks)),
        ]),
      );
}

class Ikon extends StatelessWidget {
  final IconData ikon;
  final double ukuran;
  final Color latar, warna;
  final bool kotak;
  const Ikon(this.ikon,
      {super.key, this.ukuran = 46, this.latar = Warna.hijauMuda, this.warna = Warna.cokelat, this.kotak = false});

  @override
  Widget build(BuildContext context) => Container(
        width: ukuran,
        height: ukuran,
        decoration: BoxDecoration(
          color: latar,
          shape: kotak ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: kotak ? BorderRadius.circular(ukuran * .26) : null,
        ),
        child: Icon(ikon, size: ukuran * .5, color: warna),
      );
}

class Emoji extends StatelessWidget {
  final String teks;
  final double ukuran;
  final Color latar;
  const Emoji(this.teks, {super.key, this.ukuran = 72, this.latar = Warna.hijauPucat});

  @override
  Widget build(BuildContext context) => Container(
        width: ukuran,
        height: ukuran,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: latar, shape: BoxShape.circle),
        child: Text(teks, style: TextStyle(fontSize: ukuran * .5)),
      );
}

class Batang extends StatelessWidget {
  final int nilai;
  const Batang(this.nilai, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: LinearProgressIndicator(
              value: nilai / 100, minHeight: 9, backgroundColor: Warna.hijauPucat, color: Warna.hijau),
        ),
      );
}

class Donat extends StatelessWidget {
  final int persen;
  final double ukuran;
  final Widget? isi;
  const Donat(this.persen, {super.key, this.ukuran = 110, this.isi});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: ukuran,
        height: ukuran,
        child: CustomPaint(painter: _LukisDonat(persen), child: Center(child: isi)),
      );
}

class _LukisDonat extends CustomPainter {
  final int persen;
  _LukisDonat(this.persen);

  @override
  void paint(Canvas kanvas, Size ukuran) {
    final tebal = ukuran.width * .14;
    final area = Rect.fromLTWH(tebal / 2, tebal / 2, ukuran.width - tebal, ukuran.height - tebal);
    Paint kuas(Color warna) => Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = tebal
      ..color = warna;
    kanvas.drawArc(area, 0, math.pi * 2, false, kuas(Warna.pasir));
    kanvas.drawArc(area, -math.pi / 2, math.pi * 2 * persen / 100, false, kuas(Warna.hijau));
  }

  @override
  bool shouldRepaint(_LukisDonat lama) => lama.persen != persen;
}

class Tombol extends StatelessWidget {
  final String teks;
  final VoidCallback? saatDitekan;
  final bool gelap, garis, kecil;
  final IconData? ikon;
  const Tombol(this.teks,
      {super.key, this.saatDitekan, this.gelap = false, this.garis = false, this.kecil = false, this.ikon});

  @override
  Widget build(BuildContext context) {
    final warnaTeks = garis ? Warna.cokelat : Colors.white;
    final sudut = BorderRadius.circular(kecil ? 14 : 16);
    return Opacity(
      opacity: saatDitekan == null ? .5 : 1,
      child: Padding(
        padding: EdgeInsets.only(top: kecil ? 0 : 12),
        child: Material(
          color: garis ? Colors.transparent : (gelap ? Warna.cokelat : Warna.hijau),
          shape: RoundedRectangleBorder(
              borderRadius: sudut,
              side: garis ? const BorderSide(color: Warna.cokelat, width: 2) : BorderSide.none),
          child: InkWell(
            onTap: saatDitekan,
            borderRadius: sudut,
            child: Container(
              width: kecil ? null : double.infinity,
              padding: EdgeInsets.symmetric(vertical: kecil ? 12 : 15, horizontal: kecil ? 18 : 0),
              child: Row(
                mainAxisSize: kecil ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (ikon != null) ...[Icon(ikon, color: warnaTeks), const SizedBox(width: 10)],
                  Text(teks, style: TextStyle(color: warnaTeks, fontWeight: FontWeight.w600, fontSize: 16)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TombolKembali extends StatelessWidget {
  const TombolKembali({super.key});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.pop(context),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(color: Warna.hijauMuda, borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.arrow_back, color: Warna.cokelat),
        ),
      );
}

class BarAtas extends StatelessWidget {
  final String judul;
  final bool kembali;
  const BarAtas(this.judul, {super.key, this.kembali = true});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(children: [
          kembali ? const TombolKembali() : const SizedBox(width: 52),
          Expanded(
              child: Center(
                  child: Text(judul, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)))),
          const SizedBox(width: 52),
        ]),
      );
}

class JudulBagian extends StatelessWidget {
  final String teks;
  const JudulBagian(this.teks, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(6, 20, 0, 10),
        child: Text(teks, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      );
}

class BarisMenu extends StatelessWidget {
  final IconData ikon;
  final String label;
  final VoidCallback? saatDitekan;
  const BarisMenu(this.ikon, this.label, {super.key, this.saatDitekan});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: saatDitekan,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(children: [
            Ikon(ikon, ukuran: 40),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
            const Icon(Icons.chevron_right, color: Warna.cokelat),
          ]),
        ),
      );
}

/// Menyusun baris-baris dengan garis pemisah di antaranya.
Widget daftarBersekat(List<Widget> baris) => Column(children: [
      for (var i = 0; i < baris.length; i++) ...[
        if (i > 0) const Divider(height: 1, color: Warna.garis),
        baris[i],
      ]
    ]);

class KolomIsian extends StatelessWidget {
  final IconData ikon;
  final String petunjuk;
  final TextEditingController? pengendali;
  final bool sembunyi, putih, hanyaBaca;
  final Widget? akhiran;
  final int barisMaks;
  final ValueChanged<String>? saatBerubah;
  final VoidCallback? saatDitekan;
  const KolomIsian(this.ikon, this.petunjuk,
      {super.key,
      this.pengendali,
      this.sembunyi = false,
      this.putih = false,
      this.hanyaBaca = false,
      this.akhiran,
      this.barisMaks = 1,
      this.saatBerubah,
      this.saatDitekan});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 14),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: putih ? Colors.white : const Color(0xFFF6F1E8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: putih ? const [_bayangan] : null,
        ),
        child: Row(children: [
          Icon(ikon, color: Warna.hijau),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: pengendali,
              obscureText: sembunyi,
              maxLines: sembunyi ? 1 : barisMaks,
              readOnly: hanyaBaca,
              onTap: saatDitekan,
              onChanged: saatBerubah,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Warna.cokelat),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: petunjuk,
                hintStyle: const TextStyle(color: Warna.redup),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          if (akhiran != null) akhiran!,
        ]),
      );
}