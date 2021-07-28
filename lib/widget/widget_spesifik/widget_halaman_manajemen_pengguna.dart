import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/layanan/variable_global.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

/// Widget dengan keadaan (stateful Widget)

class LatarManajemenPengguna extends StatefulWidget {
  @override
  _LatarManajemenPenggunaState createState() => _LatarManajemenPenggunaState();
}

class _LatarManajemenPenggunaState extends State<LatarManajemenPengguna> {

  @override
  void initState() {
    super.initState();
  }

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
                            isi: 'Manajemen Pengguna',
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
                          pindahKeHalaman(context, FormUserSistem(dataAnggota: []), (panggilKembali) {

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
                                    isi: 'Tambah Pengguna',
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
                    child: ListView(

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

  @override
  void dispose() {
    super.dispose();
  }
}

class FormUserSistem extends StatefulWidget {
  final List dataAnggota;

  FormUserSistem({
    @required this.dataAnggota,
  });

  @override
  _FormUserSistemState createState() => _FormUserSistemState();
}

class _FormUserSistemState extends State<FormUserSistem> {
  TextEditingController pengaturNama = new TextEditingController();
  TextEditingController pengaturEmail = new TextEditingController();
  TextEditingController pengaturJabatan = new TextEditingController();

  @override
  void initState() {
    super.initState();
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
                                  kapitalisasi: TextCapitalization.characters,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InputTeksGlobal(
                                  label: 'E-mail',
                                  controller: pengaturEmail,
                                  jenisInput: TextInputType.emailAddress,
                                  kapitalisasi: TextCapitalization.characters,
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
                        child: TombolGlobal(
                          judul: 'Simpan',
                          fungsiTekan: () {
                            if(pengaturNama.text != ''
                                && pengaturEmail.text != ''
                                && pengaturJabatan.text != '') {
                              dialogOpsi(context, 'Tambahkan pengguna baru, Anda yakin?', () {
                                tutupHalaman(context, null);

                                tutupHalaman(context, [
                                  pengaturNama.text,
                                  pengaturEmail.text,
                                  pengaturJabatan.text,
                                ]);
                              }, () {
                                tutupHalaman(context, null);
                              });
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