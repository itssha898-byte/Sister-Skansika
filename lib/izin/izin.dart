import 'package:flutter/material.dart';
import '../umum/data.dart';
import '../umum/komponen.dart';
import '../umum/tema.dart';

class HalamanIzin extends StatefulWidget {
  const HalamanIzin({super.key});

  @override
  State<HalamanIzin> createState() => _HalamanIzinState();
}

class _HalamanIzinState extends State<HalamanIzin> {
  String jenis = 'Izin';
  final tanggal = TextEditingController();
  final alasan = TextEditingController();

  Future<void> pilihTanggal() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (d != null) tanggal.text = '${d.day}/${d.month}/${d.year}';
  }

  void kirim() {
    if (tanggal.text.isEmpty || alasan.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Tanggal dan alasan wajib diisi.')));
      return;
    }
    aplikasi.ajukan(jenis, tanggal.text, alasan.text.trim());
    tanggal.clear();
    alasan.clear();
  }

  @override
  void dispose() {
    tanggal.dispose();
    alasan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HalamanDasar(
      isi: ListenableBuilder(
        listenable: aplikasi,
        builder: (context, _) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const BarAtas('Pengajuan Izin'),
          Kotak(
            isi: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(spacing: 8, children: [
                for (final j in ['Izin', 'Sakit'])
                  ChoiceChip(
                    label: Text(j),
                    selected: jenis == j,
                    selectedColor: Warna.hijauMuda,
                    onSelected: (_) => setState(() => jenis = j),
                  ),
              ]),
              KolomIsian(Icons.calendar_month_outlined, 'Pilih tanggal',
                  pengendali: tanggal, hanyaBaca: true, saatDitekan: pilihTanggal),
              KolomIsian(Icons.edit_outlined, 'Tulis alasan singkat', pengendali: alasan, barisMaks: 3),
              Tombol('Kirim Pengajuan', saatDitekan: kirim),
            ]),
          ),
          const JudulBagian('Riwayat Pengajuan'),
          if (aplikasi.pengajuan.isEmpty)
            const Center(child: Text('Belum ada pengajuan.', style: TextStyle(color: Warna.redup)))
          else
            for (final p in aplikasi.pengajuan)
              Kotak(
                isi: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(p.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                    const Lencana('Menunggu', latar: Warna.pasir),
                  ]),
                  const SizedBox(height: 6),
                  Text('${p.$2} — ${p.$3}', style: const TextStyle(fontSize: 13, color: Warna.redup)),
                ]),
              ),
        ]),
      ),
    );
  }
}