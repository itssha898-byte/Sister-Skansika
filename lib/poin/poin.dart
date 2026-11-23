import 'package:flutter/material.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanPoin extends StatelessWidget {
  const HalamanPoin({super.key});

  @override
  Widget build(BuildContext context) {
    final total = daftarPoin.fold<int>(100, (jumlah, item) => jumlah + item.$2);
    return HalamanDasar(
      isi: Column(children: [
        const BarAtas('Poin Kedisiplinan'),
        Kotak(
          isi: Column(children: [
            const Text('Total poin', style: TextStyle(color: Warna.redup)),
            Text('$total', style: const TextStyle(fontSize: 52, fontWeight: FontWeight.w700, color: Warna.hijau)),
          ]),
        ),
        for (final item in daftarPoin)
          Kotak(
            isi: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Flexible(child: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w700))),
              Lencana(item.$2 > 0 ? '+${item.$2}' : '${item.$2}'),
            ]),
          ),
      ]),
    );
  }
}