import 'package:aplikasi_data_warga/widget/widget_spesifik/widget_halaman_manajemen_pengguna.dart';
import 'package:flutter/material.dart';

class HalamanManajemenPengguna extends StatefulWidget {
  @override
  _HalamanManajemenPenggunaState createState() => _HalamanManajemenPenggunaState();
}

class _HalamanManajemenPenggunaState extends State<HalamanManajemenPengguna> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LatarManajemenPengguna(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}