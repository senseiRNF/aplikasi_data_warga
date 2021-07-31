import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/fungsi/fungsi_spesifik/fungsi_halaman_manajemen_berkas.dart';
import 'package:aplikasi_data_warga/layanan/layanan_firestore.dart';
import 'package:aplikasi_data_warga/layanan/variable_global.dart';
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
        await muatDaftarAnggotaKeluarga(idDokumen).then((anggota) {
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
                                await muatDaftarAnggotaKeluarga(hasil[0]).then((anggota) {
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
                            dialogOpsi(context, 'Simpan berkas, Anda yakin?', () async {
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

class FormKeteranganKelahiran extends StatefulWidget {
  final List dataKeterangan;

  FormKeteranganKelahiran({
    @required this.dataKeterangan,
  });

  @override
  _FormKeteranganKelahiranState createState() => _FormKeteranganKelahiranState();
}

class _FormKeteranganKelahiranState extends State<FormKeteranganKelahiran> {
  List daftarKartuKeluarga;
  List daftarAyahIbu;
  
  TextEditingController pengaturNoSuratKelahiran = new TextEditingController();
  TextEditingController pengaturNIKAnak = new TextEditingController();
  TextEditingController pengaturNamaAnak = new TextEditingController();
  TextEditingController pengaturJenisKelaminAnak = new TextEditingController();
  TextEditingController pengaturTanggalLahirAnak = new TextEditingController();
  TextEditingController pengaturHariLahirAnak = new TextEditingController();
  TextEditingController pengaturJamLahirAnak = new TextEditingController();
  TextEditingController pengaturTanggalPengajuan = new TextEditingController();
  TextEditingController pengaturNoKK = new TextEditingController();
  TextEditingController pengaturNIKAyah = new TextEditingController();
  TextEditingController pengaturNamaAyah = new TextEditingController();
  TextEditingController pengaturUmurAyah = new TextEditingController();
  TextEditingController pengaturNIKIbu = new TextEditingController();
  TextEditingController pengaturNamaIbu = new TextEditingController();
  TextEditingController pengaturUmurIbu = new TextEditingController();
  TextEditingController pengaturAlamat = new TextEditingController();

  DateTime tanggalLahirAnak;
  DateTime tanggalPengajuan;

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
        await muatDataAyahIbu(idDokumen).then((anggota) {
          if (anggota != null) {
            setState(() {
              daftarAyahIbu = anggota;
            });

            for(int i = 0; i < anggota.length; i++) {
              if(anggota[i][4] == 'SUAMI') {
                pengaturNamaAyah.text = anggota[i][0];
                pengaturNIKAyah.text = anggota[i][1];

                int umurAyah = DateTime.now().year - int.parse(anggota[i][2].toString().substring(0, 4));
                pengaturUmurAyah.text = umurAyah.toString();
              } if(anggota[i][4] == 'ISTRI') {
                pengaturNamaIbu.text = anggota[i][0];
                pengaturNIKIbu.text = anggota[i][1];

                int umurIbu = DateTime.now().year - int.parse(anggota[i][2].toString().substring(0, 4));
                pengaturUmurIbu.text = umurIbu.toString();
              } if(anggota[i][3] == 'LAKI-LAKI' && anggota[i][4] == 'KEPALA KELUARGA') {
                pengaturNamaAyah.text = anggota[i][0];
                pengaturNIKAyah.text = anggota[i][1];

                int umurAyah = DateTime.now().year - int.parse(anggota[i][2].toString().substring(0, 4));
                pengaturUmurAyah.text = umurAyah.toString();
              } if(anggota[i][3] == 'PEREMPUAN' && anggota[i][4] == 'KEPALA KELUARGA') {
                pengaturNamaIbu.text = anggota[i][0];
                pengaturNIKIbu.text = anggota[i][1];

                int umurIbu = DateTime.now().year - int.parse(anggota[i][2].toString().substring(0, 4));
                pengaturUmurIbu.text = umurIbu.toString();
              }
            }
          }
        });

        await muatAlamat(widget.dataKeterangan[1]).then((alamat) {
          if(alamat != null) {
            setState(() {
              pengaturAlamat.text = alamat;
            });
          }
        });

        setState(() {
          pengaturNoKK.text = widget.dataKeterangan[1];
          pengaturNoSuratKelahiran.text = widget.dataKeterangan[2];
          pengaturNIKAnak.text = widget.dataKeterangan[3];
          pengaturNamaAnak.text = widget.dataKeterangan[4];
          pengaturJenisKelaminAnak.text = widget.dataKeterangan[5];
          tanggalLahirAnak = DateTime.parse(widget.dataKeterangan[6]);
          pengaturTanggalLahirAnak.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.dataKeterangan[6]));
          pengaturJamLahirAnak.text = widget.dataKeterangan[7];
          pengaturHariLahirAnak.text = widget.dataKeterangan[8];
          tanggalPengajuan = DateTime.parse(widget.dataKeterangan[9]);
          pengaturTanggalPengajuan.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.dataKeterangan[9]));
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
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTeksGlobal(
                              label: 'No. Surat Kelahiran',
                              controller: pengaturNoSuratKelahiran,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputAngkaTanpaPemisah(
                              label: 'NIK',
                              controller: pengaturNIKAnak,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTeksGlobal(
                              label: 'Nama Lengkap Bayi',
                              controller: pengaturNamaAnak,
                              kapitalisasi: TextCapitalization.characters,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputOpsi(
                              label: 'Jenis Kelamin Bayi',
                              controller: pengaturJenisKelaminAnak,
                              daftarOpsi: daftarJenisKelamin,
                              fungsiGanti: (hasil) {
                                setState(() {
                                  pengaturJenisKelaminAnak.text = hasil;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTanggal(
                              label: 'Tanggal Lahir Bayi',
                              controller: pengaturTanggalLahirAnak,
                              tanggal: tanggalLahirAnak,
                              fungsiGanti: (hasil) {
                                setState(() {
                                  tanggalLahirAnak = hasil;
                                  pengaturTanggalLahirAnak.text = DateFormat('dd-MM-yyyy').format(hasil);

                                  switch(DateFormat('EEEE').format(hasil)) {
                                    case 'Sunday':
                                      pengaturHariLahirAnak.text = 'Minggu';
                                      break;
                                    case 'Monday':
                                      pengaturHariLahirAnak.text = 'Senin';
                                      break;
                                    case 'Tuesday':
                                      pengaturHariLahirAnak.text = 'Selasa';
                                      break;
                                    case 'Wednesday':
                                      pengaturHariLahirAnak.text = 'Rabu';
                                      break;
                                    case 'Thursday':
                                      pengaturHariLahirAnak.text = 'Kamis';
                                      break;
                                    case 'Friday':
                                      pengaturHariLahirAnak.text = 'Jumat';
                                      break;
                                    case 'Saturday':
                                      pengaturHariLahirAnak.text = 'Sabtu';
                                      break;
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputJam(
                              label: 'Jam Lahir Bayi',
                              controller: pengaturJamLahirAnak,
                              fungsiGanti: (TimeOfDay hasil) {
                                DateTime konversiJam = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hasil.hour, hasil.minute);

                                pengaturJamLahirAnak.text = DateFormat('HH:mm').format(konversiJam);
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputNonAktif(
                              label: 'Hari Lahir Bayi',
                              controller: pengaturHariLahirAnak,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTanggal(
                              label: 'Tanggal Pengajuan Lahir',
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
                            InputOpsiKK(
                              label: 'Nomor Kartu Keluarga',
                              controller: pengaturNoKK,
                              daftarOpsi: daftarKartuKeluarga,
                              fungsiGanti: (hasil) async {
                                await muatAlamat(hasil[1]).then((alamat) {
                                  if(alamat != null) {
                                    setState(() {
                                      pengaturAlamat.text = alamat;
                                    });
                                  }
                                });

                                await muatDataAyahIbu(hasil[0]).then((anggota) {
                                  if(anggota != null) {
                                    setState(() {
                                      daftarAyahIbu = anggota;

                                      for(int i = 0; i < anggota.length; i++) {
                                        if(anggota[i][4] == 'SUAMI') {
                                          pengaturNamaAyah.text = anggota[i][0];
                                          pengaturNIKAyah.text = anggota[i][1];
                                          
                                          int umurAyah = DateTime.now().year - int.parse(anggota[i][2].toString().substring(0, 4));
                                          pengaturUmurAyah.text = umurAyah.toString();
                                        } if(anggota[i][4] == 'ISTRI') {
                                          pengaturNamaIbu.text = anggota[i][0];
                                          pengaturNIKIbu.text = anggota[i][1];

                                          int umurIbu = DateTime.now().year - int.parse(anggota[i][2].toString().substring(0, 4));
                                          pengaturUmurIbu.text = umurIbu.toString();
                                        } if(anggota[i][3] == 'LAKI-LAKI' && anggota[i][4] == 'KEPALA KELUARGA') {
                                          pengaturNamaAyah.text = anggota[i][0];
                                          pengaturNIKAyah.text = anggota[i][1];

                                          int umurAyah = DateTime.now().year - int.parse(anggota[i][2].toString().substring(0, 4));
                                          pengaturUmurAyah.text = umurAyah.toString();
                                        } if(anggota[i][3] == 'PEREMPUAN' && anggota[i][4] == 'KEPALA KELUARGA') {
                                          pengaturNamaIbu.text = anggota[i][0];
                                          pengaturNIKIbu.text = anggota[i][1];

                                          int umurIbu = DateTime.now().year - int.parse(anggota[i][2].toString().substring(0, 4));
                                          pengaturUmurIbu.text = umurIbu.toString();
                                        }
                                      }
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
                            InputNonAktif(
                              label: 'Nama Ayah',
                              controller: pengaturNamaAyah,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputNonAktif(
                              label: 'NIK Ayah',
                              controller: pengaturNIKAyah,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputNonAktif(
                              label: 'Umur Ayah',
                              controller: pengaturUmurAyah,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputNonAktif(
                              label: 'Nama Ibu',
                              controller: pengaturNamaIbu,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputNonAktif(
                              label: 'NIK Ibu',
                              controller: pengaturNIKIbu,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputNonAktif(
                              label: 'Umur Ibu',
                              controller: pengaturUmurIbu,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTeksGlobal(
                              label: 'Alamat',
                              controller: pengaturAlamat,
                              kapitalisasi: TextCapitalization.words,
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
                          if(pengaturNoSuratKelahiran.text != '' &&
                              pengaturNIKAnak.text != '' &&
                              pengaturNamaAnak.text != '' &&
                              pengaturJenisKelaminAnak.text != '' &&
                              pengaturTanggalLahirAnak.text != '' &&
                              pengaturJamLahirAnak.text != '' &&
                              pengaturHariLahirAnak.text != '' &&
                              pengaturTanggalPengajuan.text != '' &&
                              pengaturNoKK.text != '' &&
                              pengaturNIKAyah.text != '' &&
                              pengaturNamaAyah.text != '' &&
                              pengaturUmurAyah.text != '' &&
                              pengaturNIKIbu.text != '' &&
                              pengaturNamaIbu.text != '' &&
                              pengaturUmurIbu.text != '') {
                            dialogOpsi(context, 'Simpan berkas, Anda yakin?', () async {
                              tutupHalaman(context, null);

                              setState(() {
                                memuat = true;
                              });

                              if(idDokumen == null) {
                                await simpanDataKelahiran(
                                  pengaturNoSuratKelahiran.text,
                                  pengaturNamaAnak.text,
                                  pengaturNIKAnak.text,
                                  pengaturJenisKelaminAnak.text,
                                  DateFormat('yyyy-MM-dd').format(tanggalLahirAnak),
                                  pengaturJamLahirAnak.text,
                                  pengaturHariLahirAnak.text,
                                  DateFormat('yyyy-MM-dd').format(tanggalPengajuan),
                                  pengaturNoKK.text,
                                  pengaturNIKAyah.text,
                                  pengaturNamaAyah.text,
                                  pengaturUmurAyah.text,
                                  pengaturNIKIbu.text,
                                  pengaturNamaIbu.text,
                                  pengaturUmurIbu.text,
                                  pengaturAlamat.text,
                                ).then((hasil) {
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
                                await ubahDataKelahiran(
                                  idDokumen,
                                  pengaturNoSuratKelahiran.text,
                                  pengaturNamaAnak.text,
                                  pengaturNIKAnak.text,
                                  pengaturJenisKelaminAnak.text,
                                  DateFormat('yyyy-MM-dd').format(tanggalLahirAnak),
                                  pengaturJamLahirAnak.text,
                                  pengaturHariLahirAnak.text,
                                  DateFormat('yyyy-MM-dd').format(tanggalPengajuan),
                                  pengaturNoKK.text,
                                  pengaturNIKAyah.text,
                                  pengaturNamaAyah.text,
                                  pengaturUmurAyah.text,
                                  pengaturNIKIbu.text,
                                  pengaturNamaIbu.text,
                                  pengaturUmurIbu.text,
                                  pengaturAlamat.text,
                                ).then((hasil) {
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