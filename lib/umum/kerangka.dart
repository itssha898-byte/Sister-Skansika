import 'package:flutter/material.dart';
import '../akun/akun.dart';
import '../home/home.dart';
import '../nilai/nilai.dart';
import '../pembelajaran/pembelajaran.dart';
import 'tema.dart';

/// Kerangka utama: 4 tab dengan menu bawah melayang (Beranda, Jadwal, Nilai, Profil).
class KerangkaUtama extends StatefulWidget {
  const KerangkaUtama({super.key});

  @override
  State<KerangkaUtama> createState() => _KerangkaUtamaState();
}

class _KerangkaUtamaState extends State<KerangkaUtama> {
  int tab = 0;

  static const _menu = [
    (Icons.home_outlined, 'Beranda'),
    (Icons.calendar_month_outlined, 'Jadwal'),
    (Icons.assignment_outlined, 'Nilai'),
    (Icons.person_outline, 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        IndexedStack(
          index: tab,
          children: const [HalamanBeranda(), HalamanPembelajaran(), HalamanNilai(), HalamanAkun()],
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 402),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [BoxShadow(color: Color(0x295A3A22), blurRadius: 24, offset: Offset(0, 8))],
                ),
                child: Row(children: [
                  for (var n = 0; n < _menu.length; n++)
                    Expanded(
                      child: InkWell(
                        onTap: () => setState(() => tab = n),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: tab == n ? Warna.hijauMuda : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Icon(_menu[n].$1, size: 24, color: Warna.cokelat),
                            const SizedBox(height: 3),
                            Text(_menu[n].$2,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600, color: Warna.cokelat)),
                          ]),
                        ),
                      ),
                    ),
                ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}