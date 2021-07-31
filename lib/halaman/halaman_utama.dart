import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/fungsi/fungsi_spesifik/fungsi_halaman_utama.dart';
import 'package:aplikasi_data_warga/halaman/halaman_manajemen_berkas.dart';
import 'package:aplikasi_data_warga/halaman/halaman_manajemen_penduduk.dart';
import 'package:aplikasi_data_warga/halaman/halaman_manajemen_pengguna.dart';
import 'package:aplikasi_data_warga/halaman/halaman_pembuka.dart';
import 'package:aplikasi_data_warga/layanan/layanan_google_sign_in.dart';
import 'package:aplikasi_data_warga/layanan/preferensi_global.dart';
import 'package:aplikasi_data_warga/layanan/variable_global.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

class HalamanUtama extends StatefulWidget {
  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  DateTime waktuTekanKembali;

  bool memuat = false;

  String nama;
  String email;
  String jabatan;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () => muatHalamanUtama((hasilNama, hasilEmail, hasilJabatan) async {
      setState(() {
        nama = hasilNama;
        email = hasilEmail;
        jabatan = hasilJabatan;
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

  Widget cekWidget(String jabatan) {
    Widget hasil;

    switch(jabatan) {
      case 'Admin':
        hasil = Column(
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
                  dialogDaftarOpsi(context, daftarBerkas, (hasil) {
                    switch(hasil) {
                      case 'Keterangan Pendaftaran KTP':
                        pindahKeHalaman(context, HalamanManajemenDaftarKTP(), (panggilKembali) {

                        });
                        break;
                      case 'Keterangan Kelahiran':
                        pindahKeHalaman(context, HalamanManajemenKelahiran(), (panggilKembali) {

                        });
                        break;
                      case 'Keterangan Kematian':
                        pindahKeHalaman(context, HalamanManajemenKematian(), (panggilKembali) {

                        });
                        break;
                      case 'Keterangan Pindah Domisili':
                        pindahKeHalaman(context, HalamanManajemenPindahDomisili(), (panggilKembali) {

                        });
                        break;
                      default:
                        break;
                    }
                  });
                },
                judul: 'Manajemen Berkas Desa',
                gambar: 'aset/gambar/gambar_tombol_3.png',
              ),
            ),
          ],
        );
        break;
      case 'Petugas Desa':
        hasil = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  dialogDaftarOpsi(context, daftarBerkas, (hasil) {
                    switch(hasil) {
                      case 'Keterangan Pendaftaran KTP':
                        pindahKeHalaman(context, HalamanManajemenDaftarKTP(), (panggilKembali) {

                        });
                        break;
                      case 'Keterangan Kelahiran':
                        pindahKeHalaman(context, HalamanManajemenKelahiran(), (panggilKembali) {

                        });
                        break;
                      case 'Keterangan Kematian':
                        pindahKeHalaman(context, HalamanManajemenKematian(), (panggilKembali) {

                        });
                        break;
                      case 'Keterangan Pindah Domisili':
                        pindahKeHalaman(context, HalamanManajemenPindahDomisili(), (panggilKembali) {

                        });
                        break;
                      default:
                        break;
                    }
                  });
                },
                judul: 'Manajemen Berkas Desa',
                gambar: 'aset/gambar/gambar_tombol_3.png',
              ),
            ),
          ],
        );
        break;
      case 'Kepala Desa':
        hasil = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
              child: TombolMenuBerlatar(
                fungsiTombol: () {

                },
                judul: 'Lihat Laporan Desa',
                gambar: 'aset/gambar/gambar_tombol_3.png',
              ),
            ),
          ],
        );
        break;
      default:
        hasil = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IndikatorProgressGlobal(),
          ],
        );
        break;
    }

    return hasil;
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
                                isi: 'Selamat Datang, $nama',
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
                  child: cekWidget(jabatan),
                ),
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