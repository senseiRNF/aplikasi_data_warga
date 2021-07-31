import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/layanan/layanan_firestore.dart';
import 'package:aplikasi_data_warga/layanan/variable_global.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

/// Widget dengan keadaan (stateful Widget)

class FormUserSistem extends StatefulWidget {
  final List dataUser;

  FormUserSistem({
    @required this.dataUser,
  });

  @override
  _FormUserSistemState createState() => _FormUserSistemState();
}

class _FormUserSistemState extends State<FormUserSistem> {
  TextEditingController pengaturNama = new TextEditingController();
  TextEditingController pengaturEmail = new TextEditingController();
  TextEditingController pengaturJabatan = new TextEditingController();

  bool memuat = false;

  String idDokumen;

  @override
  void initState() {
    super.initState();

    if(widget.dataUser.isNotEmpty) {
      setState(() {
        idDokumen = widget.dataUser[0];
        pengaturNama.text = widget.dataUser[1];
        pengaturEmail.text = widget.dataUser[2];
        pengaturJabatan.text = widget.dataUser[3];
      });
    }
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
                      isi: 'Data Pengguna',
                      ukuran: 18.0,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0,),
                  child: Padding(
                    padding: EdgeInsets.all(5.0,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InputTeksGlobal(
                          label: 'Nama Lengkap',
                          controller: pengaturNama,
                          kapitalisasi: TextCapitalization.words,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        InputTeksGlobal(
                          label: 'E-mail',
                          controller: pengaturEmail,
                          jenisInput: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        InputOpsi(
                          label: 'Jabatan',
                          controller: pengaturJabatan,
                          daftarOpsi: daftarJabatan,
                          fungsiGanti: (hasil) {
                            if(hasil != null) {
                              setState(() {
                                pengaturJabatan.text = hasil;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0,),
                child: !memuat ?
                TombolGlobal(
                  judul: 'Simpan',
                  fungsiTekan: () {
                    if(pengaturNama.text != '' && pengaturEmail.text != '' && pengaturJabatan.text != '') {
                      dialogOpsi(context, 'Simpan data pengguna, Anda yakin?', () async {
                        tutupHalaman(context, null);

                        setState(() {
                          memuat = true;
                        });

                        if(idDokumen == null) {
                          await simpanUser(pengaturEmail.text, pengaturNama.text, pengaturJabatan.text).then((hasil) {
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
                          await ubahUser(idDokumen, pengaturEmail.text, pengaturNama.text, pengaturJabatan.text).then((hasil) {
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Widget tanpa keadaan (stateless widget)