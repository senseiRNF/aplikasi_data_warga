import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/fungsi/fungsi_spesifik/fungsi_halaman_laporan.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

class HalamanLaporan extends StatefulWidget {
  @override
  _HalamanLaporanState createState() => _HalamanLaporanState();
}

class _HalamanLaporanState extends State<HalamanLaporan> {
  int jumlahPenduduk = 0;
  int jumlahLaki = 0;
  int jumlahPerempuan = 0;
  int jumlahBalita = 0;
  int jumlahAnak = 0;
  int jumlahRemaja = 0;
  int jumlahDewasa = 0;
  int jumlahLansia = 0;
  int jumlahBelumKawin = 0;
  int jumlahKawin = 0;
  int jumlahCeraiHidup = 0;
  int jumlahCeraiMati = 0;
  int jumlahPegawai = 0;
  int jumlahSKDaftarKTP = 0;
  int jumlahSKKelahiran = 0;
  int jumlahSKKematian = 0;
  int jumlahSKPindah = 0;

  bool memuat = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () async {
      await muatHalamanLaporan().then((hasil) {
        setState(() {
          jumlahPenduduk = hasil[0];
          jumlahLaki = hasil[1];
          jumlahPerempuan = hasil[2];
          jumlahBalita = hasil[3];
          jumlahAnak = hasil[4];
          jumlahRemaja = hasil[5];
          jumlahDewasa = hasil[6];
          jumlahLansia = hasil[7];
          jumlahBelumKawin = hasil[8];
          jumlahKawin = hasil[9];
          jumlahCeraiHidup = hasil[10];
          jumlahCeraiMati = hasil[11];
          jumlahPegawai = hasil[12];
          jumlahSKDaftarKTP = hasil[13];
          jumlahSKKelahiran = hasil[14];
          jumlahSKKematian = hasil[15];
          jumlahSKPindah = hasil[16];

          memuat = false;
        });
      });
    });
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
                        isi: 'Laporan Desa',
                        ukuran: 16.0,
                        tebal: true,
                        posisi: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0,),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            memuat = true;
                          });

                          await muatHalamanLaporan().then((hasil) {
                            setState(() {
                              jumlahPenduduk = hasil[0];
                              jumlahLaki = hasil[1];
                              jumlahPerempuan = hasil[2];
                              jumlahBalita = hasil[3];
                              jumlahAnak = hasil[4];
                              jumlahRemaja = hasil[5];
                              jumlahDewasa = hasil[6];
                              jumlahLansia = hasil[7];
                              jumlahBelumKawin = hasil[8];
                              jumlahKawin = hasil[9];
                              jumlahCeraiHidup = hasil[10];
                              jumlahCeraiMati = hasil[11];
                              jumlahPegawai = hasil[12];
                              jumlahSKDaftarKTP = hasil[13];
                              jumlahSKKelahiran = hasil[14];
                              jumlahSKKematian = hasil[15];
                              jumlahSKPindah = hasil[16];

                              memuat = false;
                            });
                          });
                        },
                        borderRadius: BorderRadius.circular(100.0,),
                        child: Padding(
                          padding: EdgeInsets.all(15.0,),
                          child: Icon(
                            Icons.refresh,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: !memuat ?
                ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0,),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0,),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TeksGlobal(
                                isi: 'Data Penduduk',
                                ukuran: 16.0,
                                tebal: true,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Jumlah Terdaftar: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahPenduduk Keluarga',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Laki-Laki: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahLaki Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Perempuan: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahPerempuan Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Balita (< 4 Tahun): ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahBalita Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Anak-Anak (5 - 12 Tahun): ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahAnak Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Remaja (13 - 19 Tahun): ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahRemaja Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Dewasa (20 - 59 Tahun): ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahDewasa Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Lanjut Usia (> 60 Tahun): ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahLansia Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Belum Kawin: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahBelumKawin Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Kawin: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahKawin Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Cerai Hidup: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahCeraiHidup Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Cerai Mati: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahCeraiMati Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0,),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0,),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TeksGlobal(
                                isi: 'Data Pegawai Desa',
                                ukuran: 16.0,
                                tebal: true,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Jumlah Terdaftar: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahPegawai Orang',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0,),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0,),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TeksGlobal(
                                isi: 'Data Berkas Desa',
                                ukuran: 16.0,
                                tebal: true,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Surat Keterangan Daftar KTP: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahSKDaftarKTP Data',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Surat Keterangan Kelahiran: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahSKKelahiran Data',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Surat Keterangan Kematian: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahSKKematian Data',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TeksGlobal(
                                    isi: 'Surat Keterangan Pindah: ',
                                    ukuran: 14.0,
                                  ),
                                  Expanded(
                                    child: TeksGlobal(
                                      isi: '$jumlahSKPindah Data',
                                      ukuran: 14.0,
                                      posisi: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ) :
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TeksGlobal(
                      isi: 'Sedang memuat laporan',
                      ukuran: 16.0,
                      posisi: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    IndikatorProgressGlobal(),
                  ],
                ),
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