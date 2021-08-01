import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/fungsi/fungsi_spesifik/fungsi_halaman_manajemen_berkas.dart';
import 'package:aplikasi_data_warga/layanan/layanan_firestore.dart';
import 'package:aplikasi_data_warga/layanan/variable_global.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget dengan keadaan (stateful Widget)
/// Form Daftar KTP
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
        setState(() {
          idDokumen = widget.dataKeterangan[0];
        });
      }

      await muatDaftarKartuKeluarga(widget.dataKeterangan, (idKK) async {
        await muatDaftarAnggotaKeluarga(idKK).then((anggota) {
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
                            InputTanggalKedepan(
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
                      isi: 'Sedang memuat formulir',
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

/// Form SK Kelahiran
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
        setState(() {
          idDokumen = widget.dataKeterangan[0];
        });
      }

      await muatDaftarKartuKeluarga(widget.dataKeterangan, (idKK) async {
        await muatDataAyahIbu(idKK).then((anggota) {
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
                                  pengaturHariLahirAnak.text = konversiHari(DateFormat('EEEE').format(hasil));
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

                                          pengaturUmurAyah.text = hitungUmur(int.parse(anggota[i][2].toString().substring(0, 4)));
                                        } if(anggota[i][4] == 'ISTRI') {
                                          pengaturNamaIbu.text = anggota[i][0];
                                          pengaturNIKIbu.text = anggota[i][1];

                                          pengaturUmurIbu.text = hitungUmur(int.parse(anggota[i][2].toString().substring(0, 4)));
                                        } if(anggota[i][3] == 'LAKI-LAKI' && anggota[i][4] == 'KEPALA KELUARGA') {
                                          pengaturNamaAyah.text = anggota[i][0];
                                          pengaturNIKAyah.text = anggota[i][1];

                                          pengaturUmurAyah.text = hitungUmur(int.parse(anggota[i][2].toString().substring(0, 4)));
                                        } if(anggota[i][3] == 'PEREMPUAN' && anggota[i][4] == 'KEPALA KELUARGA') {
                                          pengaturNamaIbu.text = anggota[i][0];
                                          pengaturNIKIbu.text = anggota[i][1];

                                          pengaturUmurIbu.text = hitungUmur(int.parse(anggota[i][2].toString().substring(0, 4)));
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
                      isi: 'Sedang memuat formulir',
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

/// Form SK Kematian
class FormKeteranganKematian extends StatefulWidget {
  final List dataKeterangan;

  FormKeteranganKematian({
    @required this.dataKeterangan,
  });

  @override
  _FormKeteranganKematianState createState() => _FormKeteranganKematianState();
}

class _FormKeteranganKematianState extends State<FormKeteranganKematian> {
  List daftarKartuKeluarga;
  List daftarAnggotaKeluarga;

  TextEditingController pengaturNoKK = new TextEditingController();
  TextEditingController pengaturNIK = new TextEditingController();
  TextEditingController pengaturTempatMeninggal = new TextEditingController();
  TextEditingController pengaturTanggalMeninggal = new TextEditingController();
  TextEditingController pengaturHariMeninggal = new TextEditingController();
  TextEditingController pengaturUsiaMeninggal = new TextEditingController();
  TextEditingController pengaturTanggalPengajuan = new TextEditingController();

  DateTime tanggalLahir;
  DateTime tanggalMeninggal;
  DateTime tanggalPengajuan;

  bool memuat = false;

  String idDokumen;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () async {
      if(widget.dataKeterangan.isNotEmpty) {
        setState(() {
          idDokumen = widget.dataKeterangan[0];
        });
      }

      await muatDaftarKartuKeluarga(widget.dataKeterangan, (idKK) async {
        await muatDaftarAnggotaKeluarga(idKK).then((anggota) {
          if (anggota != null) {
            setState(() {
              daftarAnggotaKeluarga = anggota;
              pengaturNIK.text = widget.dataKeterangan[2];
            });
          }
        });

        setState(() {
          pengaturNoKK.text = widget.dataKeterangan[1];
          pengaturTempatMeninggal.text = widget.dataKeterangan[3];
          tanggalMeninggal = DateTime.parse(widget.dataKeterangan[4]);
          pengaturTanggalMeninggal.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.dataKeterangan[4]));
          pengaturHariMeninggal.text = widget.dataKeterangan[5];
          pengaturUsiaMeninggal.text = widget.dataKeterangan[6];
          tanggalPengajuan = DateTime.parse(widget.dataKeterangan[7]);
          pengaturTanggalPengajuan.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.dataKeterangan[7]));
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

                                      tanggalLahir = null;
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

                                  tanggalLahir = DateTime.parse(hasil[2]);
                                });
                              },
                            ) : Material(),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTeksGlobal(
                              label: 'Tempat Meninggal',
                              controller: pengaturTempatMeninggal,
                              kapitalisasi: TextCapitalization.words,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            pengaturNIK.text != '' ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InputTanggal(
                                  label: 'Tanggal Meninggal',
                                  controller: pengaturTanggalMeninggal,
                                  tanggal: tanggalMeninggal,
                                  fungsiGanti: (hasil) {
                                    setState(() {
                                      tanggalMeninggal = hasil;

                                      pengaturTanggalMeninggal.text = DateFormat('dd-MM-yyyy').format(hasil);
                                      pengaturHariMeninggal.text = konversiHari(DateFormat('EEEE').format(hasil));

                                      int usiaMeninggal = tanggalMeninggal.year - tanggalLahir.year;
                                      pengaturUsiaMeninggal.text = usiaMeninggal.toString();
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InputNonAktif(
                                  label: 'Hari Meninggal',
                                  controller: pengaturHariMeninggal,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InputNonAktif(
                                  label: 'Usia Meninggal',
                                  controller: pengaturUsiaMeninggal,
                                ),
                              ],
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
                          if(pengaturNoKK.text != '' && pengaturNIK.text != '' && pengaturTempatMeninggal.text != '' && pengaturTanggalMeninggal.text != '' && pengaturHariMeninggal.text != '' && pengaturUsiaMeninggal.text != '' && pengaturTanggalPengajuan.text != '') {
                            dialogOpsi(context, 'Simpan berkas, Anda yakin?', () async {
                              tutupHalaman(context, null);

                              setState(() {
                                memuat = true;
                              });

                              if(idDokumen == null) {
                                await simpanDataKematian(
                                  pengaturNoKK.text,
                                  pengaturNIK.text,
                                  pengaturTempatMeninggal.text,
                                  DateFormat('yyyy-MM-dd').format(tanggalMeninggal),
                                  pengaturHariMeninggal.text,
                                  pengaturUsiaMeninggal.text,
                                  DateFormat('yyyy-MM-dd').format(tanggalPengajuan),
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
                                await ubahDataKematian(
                                  idDokumen,
                                  pengaturNoKK.text,
                                  pengaturNIK.text,
                                  pengaturTempatMeninggal.text,
                                  DateFormat('yyyy-MM-dd').format(tanggalMeninggal),
                                  pengaturHariMeninggal.text,
                                  pengaturUsiaMeninggal.text,
                                  DateFormat('yyyy-MM-dd').format(tanggalPengajuan),
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
                      isi: 'Sedang memuat formulir',
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

/// Form SK Pindah Domisil
class FormKeteranganPindah extends StatefulWidget {
  final List dataKeterangan;

  FormKeteranganPindah({
    @required this.dataKeterangan,
  });

  @override
  _FormKeteranganPindahState createState() => _FormKeteranganPindahState();
}

class _FormKeteranganPindahState extends State<FormKeteranganPindah> {
  TextEditingController pengaturNoSuratPindah = new TextEditingController();
  TextEditingController pengaturNIK = new TextEditingController();
  TextEditingController pengaturAlasanPindah = new TextEditingController();
  TextEditingController pengaturAlamatPindah = new TextEditingController();
  TextEditingController pengaturRTPindah = new TextEditingController();
  TextEditingController pengaturRWPindah = new TextEditingController();
  TextEditingController pengaturDesaPindah = new TextEditingController();
  TextEditingController pengaturKecamatanPindah = new TextEditingController();
  TextEditingController pengaturKabupatenPindah = new TextEditingController();
  TextEditingController pengaturProvinsiPindah = new TextEditingController();
  TextEditingController pengaturTanggalPindah = new TextEditingController();

  DateTime tanggalPindah;

  bool memuat = false;

  String idDokumen;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () async {
      if(widget.dataKeterangan.isNotEmpty) {
        setState(() {
          idDokumen = widget.dataKeterangan[0];
          pengaturNoSuratPindah.text = widget.dataKeterangan[1];
          pengaturNIK.text = widget.dataKeterangan[2];
          pengaturAlasanPindah.text = widget.dataKeterangan[3];
          pengaturAlamatPindah.text = widget.dataKeterangan[4];
          pengaturRTPindah.text = widget.dataKeterangan[5];
          pengaturRWPindah.text = widget.dataKeterangan[6];
          pengaturDesaPindah.text = widget.dataKeterangan[7];
          pengaturKecamatanPindah.text = widget.dataKeterangan[8];
          pengaturKabupatenPindah.text = widget.dataKeterangan[9];
          pengaturProvinsiPindah.text = widget.dataKeterangan[10];
          tanggalPindah = DateTime.parse(widget.dataKeterangan[11]);
          pengaturTanggalPindah.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.dataKeterangan[11]));
        });
      }
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
                              label: 'No. Surat Pindah',
                              controller: pengaturNoSuratPindah,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputAngkaTanpaPemisah(
                              label: 'NIK',
                              controller: pengaturNIK,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTeksGlobal(
                              label: 'Alasan Pindah',
                              controller: pengaturAlasanPindah,
                              kapitalisasi: TextCapitalization.words,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTeksGlobal(
                              label: 'Alamat Pindah',
                              controller: pengaturAlamatPindah,
                              kapitalisasi: TextCapitalization.words,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InputAngkaTanpaPemisah(
                                    label: 'RT Pindah',
                                    controller: pengaturRTPindah,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: InputAngkaTanpaPemisah(
                                    label: 'RW Pindah',
                                    controller: pengaturRWPindah,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTeksGlobal(
                              label: 'Desa/Kelurahan',
                              controller: pengaturDesaPindah,
                              kapitalisasi: TextCapitalization.words,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTeksGlobal(
                              label: 'Kecamatan',
                              controller: pengaturKecamatanPindah,
                              kapitalisasi: TextCapitalization.words,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            InputOpsi(
                              label: 'Kabupaten/Kota',
                              controller: pengaturKabupatenPindah,
                              daftarOpsi: daftarKota,
                              fungsiGanti: (hasil) {
                                setState(() {
                                  pengaturKabupatenPindah.text = hasil;
                                });
                              },
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            InputOpsi(
                              label: 'Provinsi',
                              controller: pengaturProvinsiPindah,
                              daftarOpsi: daftarProvinsi,
                              fungsiGanti: (hasil) {
                                setState(() {
                                  pengaturProvinsiPindah.text = hasil;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            InputTanggal(
                              label: 'Tanggal Pindah',
                              controller: pengaturTanggalPindah,
                              tanggal: tanggalPindah,
                              fungsiGanti: (hasil) {
                                setState(() {
                                  tanggalPindah = hasil;
                                  pengaturTanggalPindah.text = DateFormat('dd-MM-yyyy').format(hasil);
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
                          if(pengaturNoSuratPindah.text != '' &&
                              pengaturNIK.text != '' &&
                              pengaturAlasanPindah.text != '' &&
                              pengaturAlamatPindah.text != '' &&
                              pengaturRTPindah.text != '' &&
                              pengaturRWPindah.text != '' &&
                              pengaturDesaPindah.text != '' &&
                              pengaturKecamatanPindah.text != '' &&
                              pengaturKabupatenPindah.text != '' &&
                              pengaturProvinsiPindah.text != '' &&
                              pengaturTanggalPindah.text != '') {
                            dialogOpsi(context, 'Simpan berkas, Anda yakin?', () async {
                              tutupHalaman(context, null);

                              setState(() {
                                memuat = true;
                              });

                              if(idDokumen == null) {
                                await simpanDataPindah(
                                  pengaturNoSuratPindah.text,
                                  pengaturNIK.text,
                                  pengaturAlasanPindah.text,
                                  pengaturAlamatPindah.text,
                                  pengaturRTPindah.text,
                                  pengaturRWPindah.text,
                                  pengaturDesaPindah.text,
                                  pengaturKecamatanPindah.text,
                                  pengaturKabupatenPindah.text,
                                  pengaturProvinsiPindah.text,
                                  DateFormat('yyyy-MM-dd').format(tanggalPindah),
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
                                await ubahDataPindah(
                                  idDokumen,
                                  pengaturNoSuratPindah.text,
                                  pengaturNIK.text,
                                  pengaturAlasanPindah.text,
                                  pengaturAlamatPindah.text,
                                  pengaturRTPindah.text,
                                  pengaturRWPindah.text,
                                  pengaturDesaPindah.text,
                                  pengaturKecamatanPindah.text,
                                  pengaturKabupatenPindah.text,
                                  pengaturProvinsiPindah.text,
                                  DateFormat('yyyy-MM-dd').format(tanggalPindah),
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

class InputTanggalKedepan extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final DateTime tanggal;
  final Function fungsiGanti;

  InputTanggalKedepan({
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