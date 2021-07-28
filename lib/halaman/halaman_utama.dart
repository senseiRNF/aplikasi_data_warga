import 'package:aplikasi_data_warga/fungsi/fungsi_spesifik/fungsi_halaman_utama.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:aplikasi_data_warga/widget/widget_spesifik/widget_halaman_utama.dart';
import 'package:flutter/material.dart';

class HalamanUtama extends StatefulWidget {
  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  DateTime waktuTekanKembali;

  bool memuat = false;

  String nama;
  String surel;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () => muatHalamanUtama((hasilNama, hasilSurel) {
      setState(() {
        nama = hasilNama;
        surel = hasilSurel;
      });
    }));
  }

  Future<bool> keluarAplikasi() {
    if(!memuat) {
      DateTime sekarang = DateTime.now();

      if(waktuTekanKembali == null || sekarang.difference(waktuTekanKembali) > Duration(seconds: 2)) {
        waktuTekanKembali = sekarang;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: TeksGlobal(
              isi: 'Tekan sekali lagi untuk keluar',
              warna: Colors.white,
            ),
          ),
        );

        return Future.value(false);
      } else {
        waktuTekanKembali = null;

        return Future.value(true);
      }
    } else {
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: keluarAplikasi,
      child: Scaffold(
        body: SafeArea(
          child: LatarUtamaAdmin(
            namaUser: nama,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}