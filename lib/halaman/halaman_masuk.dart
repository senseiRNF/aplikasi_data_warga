import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/halaman/halaman_utama.dart';
import 'package:aplikasi_data_warga/layanan/layanan_google_sign_in.dart';
import 'package:aplikasi_data_warga/layanan/preferensi_global.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:aplikasi_data_warga/widget/widget_spesifik/widget_halaman_masuk.dart';
import 'package:flutter/material.dart';

class HalamanMasuk extends StatefulWidget {
  @override
  _HalamanMasukState createState() => _HalamanMasukState();
}

class _HalamanMasukState extends State<HalamanMasuk> {
  DateTime waktuTekanKembali;

  bool memuat = false;

  @override
  void initState() {
    super.initState();

    googleSignIn.onCurrentUserChanged.listen((akun) {
      if(akun != null) {
        akun.authentication.then((otentikasi) {
          aturSurel(akun.email);
          aturNama(akun.displayName);

          timpaDenganHalaman(context, HalamanUtama());
        });
      }
    });

    googleSignIn.signInSilently();
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
          child: LatarMasuk(
            memuat: memuat,
            fungsiTekan: () {
              setState(() {
                memuat = true;
              });

              masukDenganGoogle(context);
            },
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