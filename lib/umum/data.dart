import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Siswa {
  static const nama = 'Nama Siswa';
  static const nis = '000000';
  static const kelas = 'XI';
  static const email = 'emailkamu@gmail.com';
}

const daftarHari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];
const _namaHariLengkap = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
const _namaBulan = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];

// Jadwal pelajaran: (nama mapel, jam)
const jadwal = <String, List<(String, String)>>{
  'Senin': [('Matematika', '07.00–08.30'), ('Bahasa Indonesia', '09.00–10.30'), ('Ipas', '11.00–12.30')],
  'Selasa': [('Bahasa Inggris', '07.00–08.30'), ('Matematika', '09.00–10.30'), ('Ipas', '11.00–12.30')],
  'Rabu': [('Ipas', '07.00–08.30'), ('Bahasa Indonesia', '09.00–10.30')],
  'Kamis': [('Matematika', '07.00–08.30'), ('Bahasa Inggris', '09.00–10.30')],
  'Jumat': [('Bahasa Indonesia', '07.00–08.30'), ('Ipas', '09.00–10.30')],
};

// Ikon dan emoji tiap mapel
const mapel = <String, (IconData, String)>{
  'Matematika': (Icons.calculate_outlined, '📐'),
  'Bahasa Indonesia': (Icons.menu_book_outlined, '📗'),
  'Ipas': (Icons.eco_outlined, '🔬'),
  'Bahasa Inggris': (Icons.chat_bubble_outline, '💬'),
};

const daftarNilai = [('Matematika', 88), ('Bahasa Indonesia', 91), ('Ipas', 86), ('Bahasa Inggris', 90)];
const daftarPoin = [('Datang tepat waktu', 5), ('Terlambat upacara', -2), ('Juara kelas bersih', 10)];

// Soal CBT: (pertanyaan, pilihan, indeks jawaban benar)
const daftarSoal = <(String, List<String>, int)>[
  ('Hasil dari 12 × 8 adalah…', ['86', '96', '108'], 1),
  ('Ibu kota Indonesia adalah…', ['Bandung', 'Jakarta', 'Surabaya'], 1),
  ('Proses tumbuhan membuat makanan disebut…', ['Fotosintesis', 'Respirasi', 'Evaporasi'], 0),
];

class ItemPengumuman {
  final String judul, kategori, isi, tanggal;
  final IconData ikon;
  const ItemPengumuman(this.judul, this.kategori, this.isi, this.tanggal, this.ikon);
}

const daftarPengumuman = [
  ItemPengumuman('Ujian Tengah Semester', 'Akademik', 'Jadwal ujian tersedia di menu akademik.', '20 Mei 2025', Icons.menu_book_outlined),
  ItemPengumuman('Kegiatan Sekolah', 'Informasi', 'Pendaftaran kegiatan dibuka minggu ini.', '18 Mei 2025', Icons.calendar_month_outlined),
  ItemPengumuman('Pembayaran SPP', 'Administrasi', 'Pembayaran dapat dilakukan sebelum tanggal jatuh tempo.', '15 Mei 2025', Icons.description_outlined),
];

String hariAktif() {
  final w = DateTime.now().weekday;
  return w <= 5 ? daftarHari[w - 1] : 'Senin';
}

String tanggalPanjang() {
  final d = DateTime.now();
  return '${_namaHariLengkap[d.weekday - 1]}, ${d.day} ${_namaBulan[d.month - 1]} ${d.year}';
}

String tanggalPendek() {
  final d = DateTime.now();
  return '${d.day} ${_namaBulan[d.month - 1].substring(0, 3)}';
}

String jamSekarang() {
  final d = DateTime.now();
  return '${d.hour.toString().padLeft(2, '0')}.${d.minute.toString().padLeft(2, '0')}';
}

// Keadaan aplikasi (disimpan di memori; ganti dengan server/database nanti)
class KeadaanAplikasi extends ChangeNotifier {
  bool sudahMasuk = false;
  int persenHadir = 92;
  int jumlahHadir = 18, jumlahIzin = 2, jumlahSakit = 1, jumlahAlpha = 0;
  String? statusHariIni;
  final riwayat = <(String, String)>[('12 Mar', 'Hadir'), ('11 Mar', 'Hadir'), ('10 Mar', 'Izin')];
  final pengajuan = <(String, String, String)>[];

  void absen() {
    if (statusHariIni != null) return;
    jumlahHadir++;
    persenHadir = persenHadir >= 100 ? 100 : persenHadir + 1;
    statusHariIni = 'Hadir';
    riwayat.insert(0, (tanggalPendek(), 'Hadir'));
    notifyListeners();
  }

  void ajukan(String jenis, String tanggal, String alasan) {
    pengajuan.insert(0, (jenis, tanggal, alasan));
    notifyListeners();
  }
}

final aplikasi = KeadaanAplikasi();