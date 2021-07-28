import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/halaman/halaman_manajemen_penduduk.dart';
import 'package:aplikasi_data_warga/halaman/halaman_manajemen_pengguna.dart';
import 'package:aplikasi_data_warga/halaman/halaman_pembuka.dart';
import 'package:aplikasi_data_warga/layanan/layanan_google_sign_in.dart';
import 'package:aplikasi_data_warga/layanan/preferensi_global.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

/// Widget dengan keadaan (stateful Widget)

class LatarUtamaAdmin extends StatelessWidget {
  final String namaUser;

  LatarUtamaAdmin({
    @required this.namaUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'aset/gambar/latar_belakang.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0,),
                    child: Row(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 8,
                          child: Image.asset(
                            'aset/gambar/gambar_karakter.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0,),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TeksGlobal(
                                  isi: 'Aplikasi desa Palasari',
                                  ukuran: 16.0,
                                  tebal: true,
                                  posisi: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TeksGlobal(
                                  isi: 'Selamat Datang, $namaUser',
                                  ukuran: 14.0,
                                  posisi: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0,),
                          child: Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0,),
                            ),
                            child: InkWell(
                              onTap: () {
                                dialogOpsi(context, 'Keluar dari sesi saat ini, Anda yakin?', () async {
                                  await googleSignIn.disconnect().then((keluar) async {
                                    await hapusPreferensi().then((hasil) {
                                      if(hasil) {
                                        tutupHalaman(context, null);
                                        timpaDenganHalaman(context, HalamanPembuka());
                                      }
                                    });
                                  });
                                }, () {
                                  tutupHalaman(context, null);
                                });
                              },
                              borderRadius: BorderRadius.circular(100.0,),
                              child: Padding(
                                padding: EdgeInsets.all(15.0,),
                                child: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.red,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
                          child: TombolMenuBerlatar(
                            fungsiTombol: () {
                              pindahKeHalaman(context, HalamanManajemenPengguna(), (panggilKembali) {

                              });
                            },
                            judul: 'Manajemen Pengguna Sistem',
                            gambar: 'aset/gambar/gambar_tombol_1.png',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
                          child: TombolMenuBerlatar(
                            fungsiTombol: () {
                              pindahKeHalaman(context, HalamanManajemenPenduduk(), (panggilKembali) {

                              });
                            },
                            judul: 'Manajemen Data Penduduk',
                            gambar: 'aset/gambar/gambar_tombol_2.png',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
                          child: TombolMenuBerlatar(
                            fungsiTombol: () {

                            },
                            judul: 'Manajemen Berkas Desa',
                            gambar: 'aset/gambar/gambar_tombol_3.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//-------------------------------------------------------------//

/// Widget tanpa keadaan (stateless widget)

class KartuMenu extends StatelessWidget {
  final int noMenu;

  KartuMenu({
    @required this.noMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0,),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0,),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0,),
          ),
          elevation: 10.0,
        ),
      ),
    );
  }
}