import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/layanan/layanan_firestore.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
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
                        isi: 'Manajemen Data Penduduk',
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
                      pindahKeHalaman(context, FormKartuKeluarga(
                        dataKK: [],
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
                                isi: 'Tambah Data Penduduk',
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
                child: LihatDaftarKK(),
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