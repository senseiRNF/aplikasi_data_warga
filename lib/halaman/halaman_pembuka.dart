import 'package:aplikasi_data_warga/fungsi/fungsi_spesifik/fungsi_halaman_pembuka.dart';
import 'package:aplikasi_data_warga/widget/widget_spesifik/widget_halaman_pembuka.dart';
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
        child: LatarPembuka(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}