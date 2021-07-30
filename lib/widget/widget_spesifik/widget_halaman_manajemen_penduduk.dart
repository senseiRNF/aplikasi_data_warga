import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/layanan/layanan_firestore.dart';
import 'package:aplikasi_data_warga/layanan/variable_global.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget dengan keadaan (stateful Widget)

class FormKartuKeluarga extends StatefulWidget {
  final List dataKK;

  FormKartuKeluarga({
    @required this.dataKK,
  });

  @override
  _FormKartuKeluargaState createState() => _FormKartuKeluargaState();
}

class _FormKartuKeluargaState extends State<FormKartuKeluarga> {
  TextEditingController pengaturNoHp = new TextEditingController();
  TextEditingController pengaturNoKK = new TextEditingController();
  TextEditingController pengaturAlamat = new TextEditingController();
  TextEditingController pengaturRT = new TextEditingController();
  TextEditingController pengaturRW = new TextEditingController();
  TextEditingController pengaturKodePos = new TextEditingController();
  TextEditingController pengaturKelurahan = new TextEditingController();
  TextEditingController pengaturKecamatan = new TextEditingController();
  TextEditingController pengaturKabupaten = new TextEditingController();
  TextEditingController pengaturProvinsi = new TextEditingController();

  List daftarAnggotaKeluarga = [];

  bool memuat = false;

  String idDokumen;

  @override
  void initState() {
    super.initState();

    if(widget.dataKK.isNotEmpty) {
      setState(() {
        idDokumen = widget.dataKK[0];
        pengaturNoHp.text = widget.dataKK[1]['no_hp'];
        pengaturNoKK.text = widget.dataKK[1]['no_kk'];
        pengaturAlamat.text = widget.dataKK[1]['alamat'];
        pengaturRT.text = widget.dataKK[1]['rt'];
        pengaturRW.text = widget.dataKK[1]['rw'];
        pengaturKodePos.text = widget.dataKK[1]['kode_pos'];
        pengaturKelurahan.text = widget.dataKK[1]['desa/kelurahan'];
        pengaturKecamatan.text = widget.dataKK[1]['kecamatan'];
        pengaturKabupaten.text = widget.dataKK[1]['kabupaten/kota'];
        pengaturProvinsi.text = widget.dataKK[1]['provinsi'];

        daftarAnggotaKeluarga = widget.dataKK[2];
      });
    }
  }

  Future<bool> keluarAplikasi() {
    if(!memuat) {
      dialogOpsi(context, 'Keluar tanpa menyimpan data, Anda yakin?', () {
        tutupHalaman(context, null);
        tutupHalaman(context, null);
      }, () {
        tutupHalaman(context, null);
      });
    }

    return Future.value(false);
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
                            dialogOpsi(context, 'Batalkan pengisian data, Anda yakin?', () {
                              tutupHalaman(context, null);
                              tutupHalaman(context, null);
                            }, () {
                              tutupHalaman(context, null);
                            });
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
                        isi: 'Data Penduduk Baru',
                        ukuran: 18.0,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5.0,),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        InputAngkaTanpaPemisah(
                          label: 'Nomor yang dapat dihubungi (Diutamakan Whatsapp)',
                          controller: pengaturNoHp,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TeksGlobal(
                          isi: '*Mohon untuk mengisi sesuai dengan data yang tertera pada kartu keluarga Anda',
                          tebal: true,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        InputAngkaTanpaPemisah(
                          label: 'Nomor Kartu Keluarga',
                          controller: pengaturNoKK,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        InputTeksGlobal(
                          label: 'Alamat',
                          controller: pengaturAlamat,
                          kapitalisasi: TextCapitalization.characters,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InputAngkaTanpaPemisah(
                                label: 'RT',
                                controller: pengaturRT,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: InputAngkaTanpaPemisah(
                                label: 'RW',
                                controller: pengaturRW,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        InputAngkaTanpaPemisah(
                          label: 'Kode Pos',
                          controller: pengaturKodePos,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        InputTeksGlobal(
                          label: 'Desa/Kelurahan',
                          controller: pengaturKelurahan,
                          kapitalisasi: TextCapitalization.characters,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        InputTeksGlobal(
                          label: 'Kecamatan',
                          controller: pengaturKecamatan,
                          kapitalisasi: TextCapitalization.characters,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        InputOpsi(
                          label: 'Kabupaten/Kota',
                          controller: pengaturKabupaten,
                          daftarOpsi: daftarKota,
                          fungsiGanti: (hasil) {
                            setState(() {
                              pengaturKabupaten.text = hasil;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        InputOpsi(
                          label: 'Provinsi',
                          controller: pengaturProvinsi,
                          daftarOpsi: daftarProvinsi,
                          fungsiGanti: (hasil) {
                            setState(() {
                              pengaturProvinsi.text = hasil;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0,),
                          ),
                          elevation: 10.0,
                          child: Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0,),
                            ),
                            child: InkWell(
                              onTap: () {
                                pindahKeHalaman(
                                  context,
                                  FormDaftarAnggotaKeluarga(
                                    dataAnggota: [],
                                  ), (List panggilKembali) {
                                    if(panggilKembali != null && panggilKembali.isNotEmpty) {
                                      setState(() {
                                        daftarAnggotaKeluarga.add(panggilKembali);
                                      });
                                    }
                                  },
                                );
                              },
                              borderRadius: BorderRadius.circular(5.0,),
                              child: Padding(
                                padding: EdgeInsets.all(20.0,),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TeksGlobal(
                                        isi: 'Tambah Anggota Keluarga',
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
                        SizedBox(
                          height: 5.0,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: daftarAnggotaKeluarga.length,
                          itemBuilder: (BuildContext daftarAnggota, int indeks) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0,),
                              child: KartuAnggotaKeluarga(
                                dataAnggota: daftarAnggotaKeluarga[indeks],
                                panggilKembali: (List dataAnggota) {
                                  if(dataAnggota != null && dataAnggota.isNotEmpty) {
                                    setState(() {
                                      daftarAnggotaKeluarga[indeks] = dataAnggota;
                                    });
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                !memuat ?
                Padding(
                  padding: EdgeInsets.all(5.0,),
                  child: TombolGlobal(
                    judul: 'Simpan',
                    fungsiTekan: () {
                      if(pengaturNoKK.text != ''
                          && pengaturAlamat.text != ''
                          && pengaturRT.text != ''
                          && pengaturRW.text != ''
                          && pengaturKodePos.text != ''
                          && pengaturKelurahan.text != ''
                          && pengaturKecamatan.text != ''
                          && pengaturKabupaten.text != ''
                          && pengaturProvinsi.text != ''
                          && daftarAnggotaKeluarga.isNotEmpty) {
                        dialogOpsi(context, 'Simpan data penduduk, Anda yakin?', () async {
                          tutupHalaman(context, null);

                          setState(() {
                            memuat = true;
                          });

                          if(idDokumen == null) {
                            await simpanKartuKeluarga(pengaturNoHp.text, [
                              pengaturNoKK.text,
                              pengaturAlamat.text,
                              pengaturRT.text,
                              pengaturRW.text,
                              pengaturKodePos.text,
                              pengaturKelurahan.text,
                              pengaturKecamatan.text,
                              pengaturKabupaten.text,
                              pengaturProvinsi.text
                            ], daftarAnggotaKeluarga, () {
                              tutupHalaman(context, null);
                            }, () {
                              setState(() {
                                memuat = false;
                              });

                              dialogOK(context, 'Terjadi kesalahan, gagal menyimpan data, silahkan coba lagi', () {
                                tutupHalaman(context, null);
                              }, () {

                              });
                            });
                          } else {
                            await ubahKartuKeluarga(idDokumen, pengaturNoHp.text, [
                              pengaturNoKK.text,
                              pengaturAlamat.text,
                              pengaturRT.text,
                              pengaturRW.text,
                              pengaturKodePos.text,
                              pengaturKelurahan.text,
                              pengaturKecamatan.text,
                              pengaturKabupaten.text,
                              pengaturProvinsi.text,
                            ], daftarAnggotaKeluarga, () {
                              tutupHalaman(context, null);
                            }, () {
                              setState(() {
                                memuat = false;
                              });

                              dialogOK(context, 'Terjadi kesalahan, gagal menyimpan data, silahkan coba lagi', () {
                                tutupHalaman(context, null);
                              }, () {

                              });
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

//-----------------------------------------------------------------//

class FormDaftarAnggotaKeluarga extends StatefulWidget {
  final List dataAnggota;

  FormDaftarAnggotaKeluarga({
    @required this.dataAnggota,
  });

  @override
  _FormDaftarAnggotaKeluargaState createState() => _FormDaftarAnggotaKeluargaState();
}

class _FormDaftarAnggotaKeluargaState extends State<FormDaftarAnggotaKeluarga> {
  TextEditingController pengaturNama = new TextEditingController();
  TextEditingController pengaturNIK = new TextEditingController();
  TextEditingController pengaturJenisKelamin = new TextEditingController();
  TextEditingController pengaturTempatLahir = new TextEditingController();
  TextEditingController pengaturTangalLahir = new TextEditingController();
  TextEditingController pengaturAgama = new TextEditingController();
  TextEditingController pengaturPendidikan = new TextEditingController();
  TextEditingController pengaturProfesi = new TextEditingController();
  TextEditingController pengaturStatusPerkawinan = new TextEditingController();
  TextEditingController pengaturStatusDalamKeluarga = new TextEditingController();
  TextEditingController pengaturKewarganegaraan = new TextEditingController();
  TextEditingController pengaturNoPaspor = new TextEditingController();
  TextEditingController pengaturNoKITAP = new TextEditingController();
  TextEditingController pengaturNamaAyah = new TextEditingController();
  TextEditingController pengaturNamaIbu = new TextEditingController();

  DateTime tangalLahir;

  @override
  void initState() {
    super.initState();

    if(widget.dataAnggota.isNotEmpty) {
      setState(() {
        pengaturNama.text = widget.dataAnggota[0];
        pengaturNIK.text = widget.dataAnggota[1];
        pengaturJenisKelamin.text = widget.dataAnggota[2];
        pengaturTempatLahir.text = widget.dataAnggota[3];
        tangalLahir = DateTime.parse(widget.dataAnggota[4]);
        pengaturTangalLahir.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.dataAnggota[4]));
        pengaturAgama.text = widget.dataAnggota[5];
        pengaturPendidikan.text = widget.dataAnggota[6];
        pengaturProfesi.text = widget.dataAnggota[7];
        pengaturStatusPerkawinan.text = widget.dataAnggota[8];
        pengaturStatusDalamKeluarga.text = widget.dataAnggota[9];
        pengaturKewarganegaraan.text = widget.dataAnggota[10];
        pengaturNoPaspor.text = widget.dataAnggota[11];
        pengaturNoKITAP.text = widget.dataAnggota[12];
        pengaturNamaAyah.text = widget.dataAnggota[13];
        pengaturNamaIbu.text = widget.dataAnggota[14];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                              isi: 'Data Anggota Keluarga',
                              ukuran: 18.0,
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5.0,),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5.0,),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.0,),
                              child: ListView(
                                children: [
                                  InputTeksGlobal(
                                    label: 'Nama Lengkap',
                                    controller: pengaturNama,
                                    kapitalisasi: TextCapitalization.characters,
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
                                  InputOpsi(
                                    label: 'Jenis Kelamin',
                                    controller: pengaturJenisKelamin,
                                    daftarOpsi: daftarJenisKelamin,
                                    fungsiGanti: (hasil) {
                                      if(hasil != null) {
                                        setState(() {
                                          pengaturJenisKelamin.text = hasil;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputOpsi(
                                    label: 'Tempat Lahir',
                                    controller: pengaturTempatLahir,
                                    daftarOpsi: daftarKota,
                                    fungsiGanti: (hasil) {
                                      if(hasil != null) {
                                        setState(() {
                                          pengaturTempatLahir.text = hasil;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputTanggal(
                                    controller: pengaturTangalLahir,
                                    tanggalLahir: tangalLahir,
                                    fungsiGanti: (hasil) {
                                      setState(() {
                                        tangalLahir = hasil;
                                        pengaturTangalLahir.text = DateFormat('dd-MM-yyyy').format(hasil);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputOpsi(
                                    label: 'Agama',
                                    controller: pengaturAgama,
                                    daftarOpsi: daftarAgama,
                                    fungsiGanti: (hasil) {
                                      if(hasil != null) {
                                        setState(() {
                                          pengaturAgama.text = hasil;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputOpsi(
                                    label: 'Pendidikan',
                                    controller: pengaturPendidikan,
                                    daftarOpsi: daftarPendidikan,
                                    fungsiGanti: (hasil) {
                                      if(hasil != null) {
                                        setState(() {
                                          pengaturPendidikan.text = hasil;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputOpsi(
                                    label: 'Profesi',
                                    controller: pengaturProfesi,
                                    daftarOpsi: daftarProfesi,
                                    fungsiGanti: (hasil) {
                                      if(hasil != null) {
                                        setState(() {
                                          pengaturProfesi.text = hasil;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputOpsi(
                                    label: 'Status Perkawinan',
                                    controller: pengaturStatusPerkawinan,
                                    daftarOpsi: daftarStatusPerkawinan,
                                    fungsiGanti: (hasil) {
                                      if(hasil != null) {
                                        setState(() {
                                          pengaturStatusPerkawinan.text = hasil;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputOpsi(
                                    label: 'Status dalam Keluarga',
                                    controller: pengaturStatusDalamKeluarga,
                                    daftarOpsi: daftarStatusDalamKeluarga,
                                    fungsiGanti: (hasil) {
                                      if(hasil != null) {
                                        setState(() {
                                          pengaturStatusDalamKeluarga.text = hasil;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputOpsi(
                                    label: 'Kewarganegaraan',
                                    controller: pengaturKewarganegaraan,
                                    daftarOpsi: daftarKewarganegaraan,
                                    fungsiGanti: (hasil) {
                                      if(hasil != null) {
                                        setState(() {
                                          pengaturKewarganegaraan.text = hasil;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputTeksGlobal(
                                    label: 'No. Paspor',
                                    controller: pengaturNoPaspor,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputTeksGlobal(
                                    label: 'No. KITAP',
                                    controller: pengaturNoKITAP,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputTeksGlobal(
                                    label: 'Nama Ayah',
                                    controller: pengaturNamaAyah,
                                    kapitalisasi: TextCapitalization.characters,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InputTeksGlobal(
                                    label: 'Nama Ibu',
                                    controller: pengaturNamaIbu,
                                    kapitalisasi: TextCapitalization.characters,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0,),
                        child: TombolGlobal(
                          judul: 'Simpan',
                          fungsiTekan: () {
                            if(pengaturNama.text != ''
                                && pengaturNIK.text != ''
                                && pengaturJenisKelamin.text != ''
                                && pengaturTempatLahir.text != ''
                                && pengaturTangalLahir.text != ''
                                && pengaturAgama.text != ''
                                && pengaturPendidikan.text != ''
                                && pengaturProfesi.text != ''
                                && pengaturStatusPerkawinan.text != null
                                && pengaturStatusDalamKeluarga.text != ''
                                && pengaturKewarganegaraan.text != ''
                                && pengaturNamaAyah.text != ''
                                && pengaturNamaIbu.text != '') {
                              if(widget.dataAnggota.isEmpty) {
                                tutupHalaman(context, [
                                  pengaturNama.text,
                                  pengaturNIK.text,
                                  pengaturJenisKelamin.text,
                                  pengaturTempatLahir.text,
                                  DateFormat('yyyy-MM-dd').format(tangalLahir),
                                  pengaturAgama.text,
                                  pengaturPendidikan.text,
                                  pengaturProfesi.text,
                                  pengaturStatusPerkawinan.text,
                                  pengaturStatusDalamKeluarga.text,
                                  pengaturKewarganegaraan.text,
                                  pengaturNoPaspor.text,
                                  pengaturNoKITAP.text,
                                  pengaturNamaAyah.text,
                                  pengaturNamaIbu.text,
                                ]);
                              } else {
                                tutupHalaman(context, [
                                  pengaturNama.text,
                                  pengaturNIK.text,
                                  pengaturJenisKelamin.text,
                                  pengaturTempatLahir.text,
                                  DateFormat('yyyy-MM-dd').format(tangalLahir),
                                  pengaturAgama.text,
                                  pengaturPendidikan.text,
                                  pengaturProfesi.text,
                                  pengaturStatusPerkawinan.text,
                                  pengaturStatusDalamKeluarga.text,
                                  pengaturKewarganegaraan.text,
                                  pengaturNoPaspor.text,
                                  pengaturNoKITAP.text,
                                  pengaturNamaAyah.text,
                                  pengaturNamaIbu.text,
                                ]);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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

class KartuAnggotaKeluarga extends StatelessWidget {
  final List dataAnggota;
  final Function panggilKembali;

  KartuAnggotaKeluarga({
    @required this.dataAnggota,
    @required this.panggilKembali,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0,),
      ),
      elevation: 10.0,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0,),
        ),
        child: InkWell(
          onTap: () {
            pindahKeHalaman(
              context,
              FormDaftarAnggotaKeluarga(
                dataAnggota: dataAnggota,
              ),
              panggilKembali,
            );
          },
          borderRadius: BorderRadius.circular(5.0,),
          child: Padding(
            padding: EdgeInsets.all(20.0,),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TeksGlobal(
                        isi: dataAnggota[0],
                        ukuran: 16.0,
                        tebal: true,
                        posisi: TextAlign.center,
                      ),
                      TeksGlobal(
                        isi: dataAnggota[9],
                        ukuran: 14.0,
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.edit,
                  size: 25.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}