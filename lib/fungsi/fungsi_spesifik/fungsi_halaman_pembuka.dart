import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/halaman/halaman_masuk.dart';
import 'package:aplikasi_data_warga/halaman/halaman_utama.dart';
import 'package:aplikasi_data_warga/layanan/preferensi_global.dart';
import 'package:flutter/material.dart';

void muatHalamanPembuka(BuildContext context) async {
  await tampilkanEmail().then((value) async {
    if(value != null) {
      timpaDenganHalaman(context, HalamanUtama());
    } else {
      timpaDenganHalaman(context, HalamanMasuk());
    }
  });
}