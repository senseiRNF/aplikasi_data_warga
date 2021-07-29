import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:aplikasi_data_warga/widget/widget_spesifik/widget_halaman_manajemen_pengguna.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

/// Layanan Admin
Future<List> loginSistem(String email) async {
  List hasil = [];

  await firestore.collection('user').get().then((querySnapshot) {
    List dataPengguna = querySnapshot.docs.map((doc) => doc.data()).toList();

    for(int i = 0; i < dataPengguna.length; i++) {
      if(dataPengguna[i]['email'].toString() == email) {
        hasil.add(dataPengguna[i]['nama']);
        hasil.add(email);
        hasil.add(dataPengguna[i]['jabatan']);
      }
    }
  }).catchError((onError) {
    print('[$onError]');
  });

  return hasil;
}

Future<void> simpanUser(String email, String nama, String jabatan, Function fungsiBerhasil, Function fungsiGagal) async {
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  return user.add({
    'nama': nama,
    'email': email,
    'jabatan': jabatan,
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((value) {
    fungsiBerhasil();
  }).catchError((error) {
    fungsiGagal();
  });
}

Future<void> ubahUser(String idDokumen, String email, String nama, String jabatan, Function fungsiBerhasil, Function fungsiGagal) async {
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  return user.doc(idDokumen).set({
    'nama': nama,
    'email': email,
    'jabatan': jabatan,
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((value) {
    fungsiBerhasil();
  }).catchError((error) {
    fungsiGagal();
  });
}

Future<void> hapusUser(String idDokumen, Function fungsiBerhasil, Function fungsiGagal) async {
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  return user.doc(idDokumen).delete().then((value) {
    fungsiBerhasil();
  }).catchError((error) {
    fungsiGagal();
  });
}

/// Widget streambuilder untuk membaca data berdasarkan waktu nyata (Real time)

class LihatUserSistem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('user').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_off,
                size: 40.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              TeksGlobal(
                isi: 'Gagal terhubung ke server',
                ukuran: 20.0,
                tebal: true,
                posisi: TextAlign.center,
              ),
            ],
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: TeksGlobal(
                    isi: 'Sedang memuat...',
                    ukuran: 16.0,
                    tebal: true,
                    posisi: TextAlign.center,
                  ),
                ),
              ),
              IndikatorProgressGlobal(),
            ],
          );
        }

        return snapshot.data.docs.length != 0 ?
        ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
              child: Card(
                elevation: 10.0,
                child: Padding(
                  padding: EdgeInsets.all(10.0,),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TeksGlobal(
                              isi: data['nama'],
                              ukuran: 18.0,
                              tebal: true,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            TeksGlobal(
                              isi: data['email'],
                              ukuran: 14.0,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TeksGlobal(
                              isi: data['jabatan'],
                              ukuran: 16.0,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pindahKeHalaman(context, FormUserSistem(dataUser: [
                            document.id,
                            data['nama'],
                            data['email'],
                            data['jabatan'],
                          ]), (panggilKembali) {

                          });
                        },
                        borderRadius: BorderRadius.circular(100.0,),
                        child: Padding(
                          padding: EdgeInsets.all(10.0,),
                          child: Icon(
                            Icons.edit,
                            size: 25.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      InkWell(
                        onTap: () {
                          dialogOpsi(context, 'Hapus data pengguna, Anda yakin?', () async {
                            tutupHalaman(context, null);

                            await hapusUser(document.id, () {

                            }, () {
                              dialogOK(context, 'Terjadi kesalahan saat menghapus data, silahkan coba lagi', () {
                                tutupHalaman(context, null);
                              }, () {

                              });
                            });
                          }, () {
                            tutupHalaman(context, null);
                          });
                        },
                        borderRadius: BorderRadius.circular(100.0,),
                        child: Padding(
                          padding: EdgeInsets.all(10.0,),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ) :
        Center(
          child: TeksGlobal(
            isi: 'Tidak ada data tersimpan...',
            ukuran: 16.0,
            tebal: true,
            posisi: TextAlign.center,
          ),
        );
      },
    );
  }
}

/// Layanan Petugas Desa
Future<void> simpanKartuKeluarga(String nomorHp, List headerKK, List anggotaKeluarga, Function fungsiBerhasil, Function fungsiGagal) async {
  CollectionReference kartuKeluarga = FirebaseFirestore.instance.collection('data_penduduk');

  return kartuKeluarga.add({
    'no_hp': nomorHp,
    'nomorKK': headerKK[0],
    'alamat': headerKK[1],
    'rt': headerKK[2],
    'rw': headerKK[3],
    'kode_pos': headerKK[4],
    'desa/kelurahan': headerKK[5],
    'kecamatan': headerKK[6],
    'kabupaten/kota': headerKK[7],
    'provinsi': headerKK[8],
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((hasil) {
    DocumentReference dokumen = hasil;

    CollectionReference anggota = kartuKeluarga.doc(dokumen.id).collection('anggota_keluarga');

    for(int i = 0; i < anggotaKeluarga.length; i++) {
      anggota.add({
        'nama': anggotaKeluarga[i][0],
        'nik': anggotaKeluarga[i][1],
        'jenis_kelamin': anggotaKeluarga[i][2],
        'tempat_lahir': anggotaKeluarga[i][3],
        'tanggal_lahir': anggotaKeluarga[i][4],
        'agama': anggotaKeluarga[i][5],
        'pendidikan': anggotaKeluarga[i][6],
        'profesi': anggotaKeluarga[i][7],
        'status_perkawinan': anggotaKeluarga[i][8],
        'status_dalam_keluarga': anggotaKeluarga[i][9],
        'kewarganegaraan': anggotaKeluarga[i][10],
        'no_paspor': anggotaKeluarga[i][11],
        'no_kitap': anggotaKeluarga[i][12],
        'nama_ayah': anggotaKeluarga[i][13],
        'nama_ibu': anggotaKeluarga[i][14],
      }).then((value) {
        fungsiBerhasil();
      }).catchError((onError) {
        fungsiGagal();
      });
    }
  }).catchError((error) {
    fungsiGagal();
  });
}

Future<void> ubahKartuKeluarga(String idDokumen, String nomorHp, List headerKK, List anggotaKeluarga, Function fungsiBerhasil, Function fungsiGagal) async {
  CollectionReference kartuKeluarga = FirebaseFirestore.instance.collection('data_penduduk');
  CollectionReference anggota = kartuKeluarga.doc(idDokumen).collection('anggota_keluarga');

  return kartuKeluarga.doc(idDokumen).set({
    'no_hp': nomorHp,
    'nomorKK': headerKK[0],
    'alamat': headerKK[1],
    'rt': headerKK[2],
    'rw': headerKK[3],
    'kode_pos': headerKK[4],
    'desa/kelurahan': headerKK[5],
    'kecamatan': headerKK[6],
    'kabupaten/kota': headerKK[7],
    'provinsi': headerKK[8],
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((hasil) async {
    QuerySnapshot querySnapshot = await anggota.get();

    for(int i = 0; i < querySnapshot.docs.length; i++) {
      var snapshot = querySnapshot.docs[i];

      anggota.doc(snapshot.id).set({
        'nama': anggotaKeluarga[i][0],
        'nik': anggotaKeluarga[i][1],
        'jenis_kelamin': anggotaKeluarga[i][2],
        'tempat_lahir': anggotaKeluarga[i][3],
        'tanggal_lahir': anggotaKeluarga[i][4],
        'agama': anggotaKeluarga[i][5],
        'pendidikan': anggotaKeluarga[i][6],
        'profesi': anggotaKeluarga[i][7],
        'status_perkawinan': anggotaKeluarga[i][8],
        'status_dalam_keluarga': anggotaKeluarga[i][9],
        'kewarganegaraan': anggotaKeluarga[i][10],
        'no_paspor': anggotaKeluarga[i][11],
        'no_kitap': anggotaKeluarga[i][12],
        'nama_ayah': anggotaKeluarga[i][13],
        'nama_ibu': anggotaKeluarga[i][14],
      }).then((value) {
        fungsiBerhasil();
      }).catchError((onError) {
        fungsiGagal();
      });
    }
  }).catchError((error) {
    fungsiGagal();
  });
}