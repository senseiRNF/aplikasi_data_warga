import 'package:aplikasi_data_warga/widget/widget_spesifik/widget_halaman_manajemen_penduduk.dart';
import 'package:flutter/material.dart';

class HalamanManajemenPenduduk extends StatefulWidget {
  @override
  _HalamanManajemenPendudukState createState() => _HalamanManajemenPendudukState();
}

class _HalamanManajemenPendudukState extends State<HalamanManajemenPenduduk> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LatarManajemenPenduduk(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}