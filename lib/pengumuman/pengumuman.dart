import 'package:flutter/material.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanPengumuman extends StatefulWidget {
  const HalamanPengumuman({super.key});

  @override
  State<HalamanPengumuman> createState() => _HalamanPengumumanState();
}

class _HalamanPengumumanState extends State<HalamanPengumuman> {
  String kataCari = '';

  @override
  Widget build(BuildContext context) {
    final hasil = [
      for (var i = 0; i < daftarPengumuman.length; i++)
        if ('${daftarPengumuman[i].judul} ${daftarPengumuman[i].isi}'.toLowerCase().contains(kataCari)) i
    ];

    return HalamanDasar(
      isi: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TombolKembali(),
          Text('🍪', style: TextStyle(fontSize: 54)),
        ]),
        const SizedBox(height: 10),
        const Row(children: [
          Icon(Icons.campaign_outlined, size: 44, color: Warna.hijau),
          SizedBox(width: 10),
          Text('Pengumuman', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700)),
        ]),
        KolomIsian(Icons.search, 'Cari pengumuman',
            putih: true, saatBerubah: (v) => setState(() => kataCari = v.toLowerCase())),
        const SizedBox(height: 14),
        if (hasil.isEmpty)
          const Center(
              child: Text('Pengumuman tidak ditemukan.', style: TextStyle(color: Warna.redup)))
        else
          for (final i in hasil)
            Kotak(
              isi: Row(children: [
                Ikon(daftarPengumuman[i].ikon,
                    ukuran: 76, latar: i == 1 ? const Color(0xFFE8D9B8) : Warna.hijauMuda),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(daftarPengumuman[i].judul,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Lencana(daftarPengumuman[i].kategori,
                        latar: i == 1 ? const Color(0xFFE8D9B8) : Warna.hijauMuda,
                        ukuranTeks: 12,
                        ruang: const EdgeInsets.symmetric(horizontal: 12, vertical: 2)),
                    const SizedBox(height: 4),
                    Text(daftarPengumuman[i].isi, style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.calendar_month_outlined, size: 16),
                      const SizedBox(width: 6),
                      Text(daftarPengumuman[i].tanggal, style: const TextStyle(fontSize: 13)),
                    ]),
                  ]),
                ),
                const Icon(Icons.chevron_right, color: Warna.cokelat),
              ]),
            ),
      ]),
    );
  }
}