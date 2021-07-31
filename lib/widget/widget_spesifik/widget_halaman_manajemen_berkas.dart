import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/fungsi/fungsi_spesifik/fungsi_halaman_manajemen_berkas.dart';
import 'package:aplikasi_data_warga/layanan/layanan_firestore.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget dengan keadaan (stateful Widget)

class FormKeteranganDaftarKTP extends StatefulWidget {
  final List dataKeterangan;

  FormKeteranganDaftarKTP({
    @required this.dataKeterangan,
  });

  @override
  _FormKeteranganDaftarKTPState createState() => _FormKeteranganDaftarKTPState();
}

class _FormKeteranganDaftarKTPState extends State<FormKeteranganDaftarKTP> {
  List daftarKartuKeluarga;
  List daftarAnggotaKeluarga;

  TextEditingController pengaturNoKK = new TextEditingController();
  TextEditingController pengaturNIK = new TextEditingController();
  TextEditingController pengaturTanggalPengajuan = new TextEditingController();
  TextEditingController pengaturTanggalBerlaku = new TextEditingController();

  DateTime tanggalPengajuan;
  DateTime tanggalBerlaku;

  bool memuat = false;

  String idDokumen;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () async {
      if(widget.dataKeterangan.isNotEmpty) {
        idDokumen = widget.dataKeterangan[0];
      }

      await muatDaftarKartuKeluarga(widget.dataKeterangan, (idDokumen) async {
        await muatDaftarAnggotaKeluarga(idDokumen, widget.dataKeterangan[1]).then((anggota) {
          if (anggota != null) {
            setState(() {
              daftarAnggotaKeluarga = anggota;
              pengaturNIK.text = widget.dataKeterangan[2];
            });
          }
        });

        setState(() {
          pengaturNoKK.text = widget.dataKeterangan[1];
          tanggalPengajuan = DateTime.parse(widget.dataKeterangan[3]);
          tanggalBerlaku = DateTime.parse(widget.dataKeterangan[4]);
          pengaturTanggalPengajuan.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.dataKeterangan[3]));
          pengaturTanggalBerlaku.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.dataKeterangan[4]));
        });
      }).then((hasil) {
        if(hasil != null) {
          setState(() {
            daftarKartuKeluarga = hasil;
          });
        } else {
          setState(() {
            daftarKartuKeluarga = [];
          });
        }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      isi: 'Data Keterangan',
                      ukuran: 18.0,
                    ),
                  )
                ],
              ),
              daftarKartuKeluarga != null ?
              daftarKartuKeluarga.isNotEmpty ?
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0,),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            InputOpsiKK(
                              label: 'Nomor Kartu Keluarga',
                              controller: pengaturNoKK,
                              daftarOpsi: daftarKartuKeluarga,
                              fungsiGanti: (hasil) async {
                                await muatDaftarAnggotaKeluarga(hasil[0], hasil[1]).then((anggota) {
                                  if(anggota != null) {
                                    setState(() {
                                      daftarAnggotaKeluarga = anggota;
                                      pengaturNIK.text = '';
                                    });
                                  }
                                });

                                setState(() {
                                  pengaturNoKK.text = hasil[1];
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            daftarAnggotaKeluarga != null ?
                            InputOpsiAnggotaKeluarga(
                              label: 'NIK',
                              controller: pengaturNIK,
                              daftarOpsi: daftarAnggotaKeluarga,
                              fungsiGanti: (hasil) {
                                setState(() {
                                  pengaturNIK.text = hasil[0];
                                });
                              },
                            ) : Material(),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTanggal(
                              label: 'Tanggal Pengajuan',
                              controller: pengaturTanggalPengajuan,
                              tanggal: tanggalPengajuan,
                              fungsiGanti: (hasil) {
                                setState(() {
                                  tanggalPengajuan = hasil;
                                  pengaturTanggalPengajuan.text = DateFormat('dd-MM-yyyy').format(hasil);
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTanggalBerlaku(
                              label: 'Berlaku Hingga',
                              controller: pengaturTanggalBerlaku,
                              tanggal: tanggalBerlaku,
                              fungsiGanti: (hasil) {
                                setState(() {
                                  tanggalBerlaku = hasil;
                                  pengaturTanggalBerlaku.text = DateFormat('dd-MM-yyyy').format(hasil);
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0,),
                      child: !memuat ?
                      TombolGlobal(
                        judul: 'Simpan',
                        fungsiTekan: () {
                          if(pengaturNoKK.text != '' && pengaturNIK.text != '' && pengaturTanggalPengajuan.text != '' && pengaturTanggalBerlaku.text != '') {
                            dialogOpsi(context, 'Tambahkan berkas baru, Anda yakin?', () async {
                              tutupHalaman(context, null);

                              setState(() {
                                memuat = true;
                              });

                              if(idDokumen == null) {
                                await simpanDataKTP(pengaturNoKK.text, pengaturNIK.text, DateFormat('yyyy-MM-dd').format(tanggalPengajuan), DateFormat('yyyy-MM-dd').format(tanggalBerlaku)).then((hasil) {
                                  if(hasil != null && hasil) {
                                    tutupHalaman(context, null);
                                  } else {
                                    setState(() {
                                      memuat = false;
                                    });

                                    dialogOK(context, 'Terjadi kesalahan, gagal menyimpan data, silahkan coba lagi', () {
                                      tutupHalaman(context, null);
                                    }, () {

                                    });
                                  }
                                });
                              } else {
                                await ubahDataKTP(idDokumen, pengaturNoKK.text, pengaturNIK.text, DateFormat('yyyy-MM-dd').format(tanggalPengajuan), DateFormat('yyyy-MM-dd').format(tanggalBerlaku)).then((hasil) {
                                  if(hasil != null && hasil) {
                                    tutupHalaman(context, null);
                                  } else {
                                    setState(() {
                                      memuat = false;
                                    });

                                    dialogOK(context, 'Terjadi kesalahan, gagal menyimpan data, silahkan coba lagi', () {
                                      tutupHalaman(context, null);
                                    }, () {

                                    });
                                  }
                                });
                              }
                            }, () {
                              tutupHalaman(context, null);
                            });
                          } else {
                            dialogOK(context, 'Harap untuk mengisi seluruh data sebelum menyimpan', () {
                              tutupHalaman(context, null);
                            }, () {

                            });
                          }
                        },
                      ) : IndikatorProgressGlobal(),
                    ),
                  ],
                ),
              ) :
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TeksGlobal(
                      isi: 'Tidak dapat memuat formulir',
                      ukuran: 18.0,
                      tebal: true,
                      posisi: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TeksGlobal(
                      isi: 'Mohon untuk menambahkan data penduduk terlebih dahulu',
                      ukuran: 16.0,
                      posisi: TextAlign.center,
                    ),
                  ],
                ),
              ) :
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TeksGlobal(
                      isi: 'Tidak dapat memuat formulir',
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

/// Widget tanpa keadaan (stateless widget)

class InputOpsiKK extends StatelessWidget {
  final String label;
  final List daftarOpsi;
  final TextEditingController controller;
  final Function fungsiGanti;

  InputOpsiKK({
    @required this.label,
    @required this.daftarOpsi,
    @required this.controller,
    @required this.fungsiGanti,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dialogOpsiKK(context, daftarOpsi, (hasil) {
          fungsiGanti(hasil);
        });
      },
      borderRadius: BorderRadius.circular(5.0,),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        controller: controller,
        enabled: false,
      ),
    );
  }
}

class InputOpsiAnggotaKeluarga extends StatelessWidget {
  final String label;
  final List daftarOpsi;
  final TextEditingController controller;
  final Function fungsiGanti;

  InputOpsiAnggotaKeluarga({
    @required this.label,
    @required this.daftarOpsi,
    @required this.controller,
    @required this.fungsiGanti,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dialogOpsiAnggotaKeluarga(context, daftarOpsi, (hasil) {
          fungsiGanti(hasil);
        });
      },
      borderRadius: BorderRadius.circular(5.0,),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        controller: controller,
        enabled: false,
      ),
    );
  }
}

class InputTanggalBerlaku extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final DateTime tanggal;
  final Function fungsiGanti;

  InputTanggalBerlaku({
    @required this.label,
    @required this.controller,
    @required this.tanggal,
    @required this.fungsiGanti,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: tanggal != null ? tanggal : DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2050),
        ).then((hasil) {
          if(hasil != null) {
            fungsiGanti(hasil);
          }
        });
      },
      borderRadius: BorderRadius.circular(5.0,),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        controller: controller,
        enabled: false,
      ),
    );
  }
}