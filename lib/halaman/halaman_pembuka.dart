import 'package:aplikasi_data_warga/fungsi/fungsi_spesifik/fungsi_halaman_pembuka.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

class HalamanPembuka extends StatefulWidget {
  @override
  _HalamanPembukaState createState() => _HalamanPembukaState();
}

class _HalamanPembukaState extends State<HalamanPembuka> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 3), () {
        muatHalamanPembuka(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LatarBelakangGlobal(
          tampilan: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.0,),
                      child: Image.asset(
                        'aset/gambar/gambar_karakter.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    TeksGlobal(
                      isi: 'Aplikasi Desa Palasari Kecamatan Legok',
                      ukuran: 16.0,
                      tebal: true,
                      posisi: TextAlign.center,
                    ),
                  ],
                ),
              ),
              IndikatorProgressGlobal(),
            ],
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