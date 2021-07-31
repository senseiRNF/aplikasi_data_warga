import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/layanan/layanan_firestore.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:aplikasi_data_warga/widget/widget_spesifik/widget_halaman_manajemen_berkas.dart';
import 'package:flutter/material.dart';

/// Daftar KTP
class HalamanManajemenDaftarKTP extends StatefulWidget {

  @override
  _HalamanManajemenDaftarKTPState createState() => _HalamanManajemenDaftarKTPState();
}

class _HalamanManajemenDaftarKTPState extends State<HalamanManajemenDaftarKTP> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LatarBelakangGlobal(
          tampilan: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0,),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0,),
                        ),
                        child: InkWell(
                          onTap: () {
                            tutupHalaman(context, null);
                          },
                          borderRadius: BorderRadius.circular(100.0,),
                          child: Padding(
                            padding: EdgeInsets.all(15.0,),
                            child: Icon(
                              Icons.arrow_back,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TeksGlobal(
                        isi: 'Keterangan Pendaftaran KTP',
                        ukuran: 16.0,
                        tebal: true,
                        posisi: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0,),
                  ),
                  child: InkWell(
                    onTap: () {
                      pindahKeHalaman(context, FormKeteranganDaftarKTP(
                        dataKeterangan: [],
                      ), (panggilKembali) {

                      });
                    },
                    borderRadius: BorderRadius.circular(5.0,),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0,)
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(10.0,),
                        child: Row(
                          children: [
                            Expanded(
                              child: TeksGlobal(
                                isi: 'Tambah Keterangan Pendaftaran KTP',
                                ukuran: 16.0,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: LihatDaftarDataKTP(),
              ),
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

/// Kelaihran
class HalamanManajemenKelahiran extends StatefulWidget {

  @override
  _HalamanManajemenKelahiranState createState() => _HalamanManajemenKelahiranState();
}

class _HalamanManajemenKelahiranState extends State<HalamanManajemenKelahiran> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LatarBelakangGlobal(
          tampilan: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0,),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0,),
                        ),
                        child: InkWell(
                          onTap: () {
                            tutupHalaman(context, null);
                          },
                          borderRadius: BorderRadius.circular(100.0,),
                          child: Padding(
                            padding: EdgeInsets.all(15.0,),
                            child: Icon(
                              Icons.arrow_back,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TeksGlobal(
                        isi: 'Keterangan Kelahiran',
                        ukuran: 16.0,
                        tebal: true,
                        posisi: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0,),
                  ),
                  child: InkWell(
                    onTap: () {

                    },
                    borderRadius: BorderRadius.circular(5.0,),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0,)
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(10.0,),
                        child: Row(
                          children: [
                            Expanded(
                              child: TeksGlobal(
                                isi: 'Tambah Keterangan Kelahiran',
                                ukuran: 16.0,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Material(),
              ),
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

/// Kematian
class HalamanManajemenKematian extends StatefulWidget {

  @override
  _HalamanManajemenKematianState createState() => _HalamanManajemenKematianState();
}

class _HalamanManajemenKematianState extends State<HalamanManajemenKematian> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LatarBelakangGlobal(
          tampilan: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0,),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0,),
                        ),
                        child: InkWell(
                          onTap: () {
                            tutupHalaman(context, null);
                          },
                          borderRadius: BorderRadius.circular(100.0,),
                          child: Padding(
                            padding: EdgeInsets.all(15.0,),
                            child: Icon(
                              Icons.arrow_back,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TeksGlobal(
                        isi: 'Keterangan Kematian',
                        ukuran: 16.0,
                        tebal: true,
                        posisi: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0,),
                  ),
                  child: InkWell(
                    onTap: () {

                    },
                    borderRadius: BorderRadius.circular(5.0,),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0,)
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(10.0,),
                        child: Row(
                          children: [
                            Expanded(
                              child: TeksGlobal(
                                isi: 'Tambah Keterangan Kematian',
                                ukuran: 16.0,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Material(),
              ),
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

/// Pindah Domisili
class HalamanManajemenPindahDomisili extends StatefulWidget {

  @override
  _HalamanManajemenPindahDomisiliState createState() => _HalamanManajemenPindahDomisiliState();
}

class _HalamanManajemenPindahDomisiliState extends State<HalamanManajemenPindahDomisili> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LatarBelakangGlobal(
          tampilan: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0,),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0,),
                        ),
                        child: InkWell(
                          onTap: () {
                            tutupHalaman(context, null);
                          },
                          borderRadius: BorderRadius.circular(100.0,),
                          child: Padding(
                            padding: EdgeInsets.all(15.0,),
                            child: Icon(
                              Icons.arrow_back,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TeksGlobal(
                        isi: 'Keterangan Pindah Domisili',
                        ukuran: 16.0,
                        tebal: true,
                        posisi: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0,),
                  ),
                  child: InkWell(
                    onTap: () {

                    },
                    borderRadius: BorderRadius.circular(5.0,),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0,)
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(10.0,),
                        child: Row(
                          children: [
                            Expanded(
                              child: TeksGlobal(
                                isi: 'Tambah Keterangan Pindah Domisili',
                                ukuran: 16.0,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Material(),
              ),
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