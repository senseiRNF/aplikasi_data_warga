import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/fungsi/fungsi_spesifik/fungsi_halaman_masuk.dart';
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
        akun.authentication.then((otentikasi) async {
          await loginSistem(akun.email).then((hasil) async {
            if(hasil.isNotEmpty) {
              await aturNama(hasil[0]).then((value) async {
                await aturEmail(hasil[1]).then((value) async {
                  await aturJabatan(hasil[2]).then((value) async {
                    timpaDenganHalaman(context, HalamanUtama());
                  });
                });
              });
            } else {
              await googleSignIn.disconnect().then((keluar) async {
                await hapusPreferensi().then((hasil) {
                  if(hasil) {
                    setState(() {
                      memuat = false;
                    });

                    dialogOK(context, 'Maaf, akun Anda tidak terdaftar di sistem kami, untuk lebih lanjut silahkan hubungi Admin', () {
                      tutupHalaman(context, null);
                    }, () {

                    });
                  }
                });
              });
            }
          });
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
          child: LatarBelakangGlobal(
            tampilan: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Image.asset(
                          'aset/gambar/gambar_karakter.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TeksGlobal(
                        isi: 'Selamat Datang\ndi Aplikasi Desa Palasari Kecamatan Legok',
                        ukuran: 16.0,
                        tebal: true,
                        posisi: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                !memuat ?
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0,),
                  child: TombolMasukAdmin(
                    fungsiTombol: () {
                      setState(() {
                        memuat = true;
                      });

                      masukDenganGoogle(context, () {
                        setState(() {
                          memuat = false;
                        });
                      });
                    },
                  ),
                ) :
                IndikatorProgressGlobal(),
              ],
            ),
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