import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:aplikasi_data_warga/widget/widget_spesifik/widget_halaman_manajemen_berkas.dart';
import 'package:aplikasi_data_warga/widget/widget_spesifik/widget_halaman_manajemen_penduduk.dart';
import 'package:aplikasi_data_warga/widget/widget_spesifik/widget_halaman_manajemen_pengguna.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

/// Layanan Pengguna
Future<bool> simpanUser(String email, String nama, String jabatan) async {
  bool hasil;

  CollectionReference user = FirebaseFirestore.instance.collection('user');

  await user.add({
    'nama': nama,
    'email': email,
    'jabatan': jabatan,
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((value) {
    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

Future<bool> ubahUser(String idDokumen, String email, String nama, String jabatan) async {
  bool hasil;

  CollectionReference user = FirebaseFirestore.instance.collection('user');

  await user.doc(idDokumen).set({
    'nama': nama,
    'email': email,
    'jabatan': jabatan,
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((value) {
    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

Future<bool> hapusUser(String idDokumen) async {
  bool hasil;

  CollectionReference user = FirebaseFirestore.instance.collection('user');

  await user.doc(idDokumen).delete().then((value) {
    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

/// Widget streambuilder untuk membaca data data pengguna berdasarkan waktu nyata (Real time)

class LihatDaftarUser extends StatelessWidget {
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

                            await hapusUser(document.id).then((value) {
                              if(value == null || !value) {
                                dialogOK(context, 'Terjadi kesalahan saat menghapus data, silahkan coba lagi', () {
                                  tutupHalaman(context, null);
                                }, () {

                                });
                              }
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

/// Layanan Penduduk
Future<bool> simpanPenduduk(List headerKK, List anggotaKeluarga) async {
  bool hasil;

  CollectionReference kartuKeluarga = FirebaseFirestore.instance.collection('data_penduduk');

  await kartuKeluarga.add({
    'no_kk': headerKK[0],
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
  }).then((docs) async {
    DocumentReference dokumen = docs;

    CollectionReference anggota = kartuKeluarga.doc(dokumen.id).collection('anggota_keluarga');

    for(int i = 0; i < anggotaKeluarga.length; i++) {
      await anggota.add({
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
      });
    }

    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

Future<bool> ubahPenduduk(String idDokumen, List headerKK, List anggotaKeluarga) async {
  bool hasil;

  CollectionReference kartuKeluarga = FirebaseFirestore.instance.collection('data_penduduk');
  CollectionReference anggota = kartuKeluarga.doc(idDokumen).collection('anggota_keluarga');

  await kartuKeluarga.doc(idDokumen).set({
    'no_kk': headerKK[0],
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
  }).then((value) async {
    await anggota.get().then((snapshot ) async {
      for(DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    });

    CollectionReference dataAnggota = kartuKeluarga.doc(idDokumen).collection('anggota_keluarga');

    for(int i = 0; i < anggotaKeluarga.length; i++) {
      await dataAnggota.add({
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
      });
    }

    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

Future<bool> hapusPenduduk(String idDokumen) async {
  bool hasil;

  CollectionReference kartuKeluarga = FirebaseFirestore.instance.collection('data_penduduk');
  CollectionReference anggota = kartuKeluarga.doc(idDokumen).collection('anggota_keluarga');

  await anggota.get().then((snapshot) async {
    for(DocumentSnapshot doc in snapshot.docs) {
      doc.reference.delete();
    }

    await kartuKeluarga.doc(idDokumen).delete().then((value) {
      hasil = true;
    }).catchError((error) {
      hasil = false;
    });
  });

  return hasil;
}

/// Widget streambuilder untuk membaca data penduduk berdasarkan waktu nyata (Real time)

class LihatDaftarPenduduk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _pendudukStream = FirebaseFirestore.instance.collection('data_penduduk').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _pendudukStream,
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

            final Stream<QuerySnapshot> _anggotaKeluargaStream = FirebaseFirestore.instance.collection('data_penduduk').doc(document.id).collection('anggota_keluarga').snapshots();

            return StreamBuilder<QuerySnapshot>(
              stream: _anggotaKeluargaStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> anggotaSnapshot) {
                List dataAnggota = [];

                cekAnggotaKeluarga() {
                  if(anggotaSnapshot.data != null && anggotaSnapshot.data.docs.isNotEmpty) {
                    dataAnggota.clear();

                    for(int i = 0; i < anggotaSnapshot.data.docs.length; i++) {
                      dataAnggota.add([
                        anggotaSnapshot.data.docs[i]['nama'],
                        anggotaSnapshot.data.docs[i]['nik'],
                        anggotaSnapshot.data.docs[i]['jenis_kelamin'],
                        anggotaSnapshot.data.docs[i]['tempat_lahir'],
                        anggotaSnapshot.data.docs[i]['tanggal_lahir'],
                        anggotaSnapshot.data.docs[i]['agama'],
                        anggotaSnapshot.data.docs[i]['pendidikan'],
                        anggotaSnapshot.data.docs[i]['profesi'],
                        anggotaSnapshot.data.docs[i]['status_perkawinan'],
                        anggotaSnapshot.data.docs[i]['status_dalam_keluarga'],
                        anggotaSnapshot.data.docs[i]['kewarganegaraan'],
                        anggotaSnapshot.data.docs[i]['no_paspor'],
                        anggotaSnapshot.data.docs[i]['no_kitap'],
                        anggotaSnapshot.data.docs[i]['nama_ayah'],
                        anggotaSnapshot.data.docs[i]['nama_ibu'],
                      ]);
                    }
                  }
                }

                cekAnggotaKeluarga();

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
                  child: Card(
                    elevation: 10.0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0,),
                      child: Row(
                        children: [
                          Expanded(
                            child: TeksGlobal(
                              isi: data['no_kk'],
                              ukuran: 18.0,
                              tebal: true,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              pindahKeHalaman(context, FormKartuKeluarga(
                                dataKK: [
                                  document.id,
                                  data,
                                  dataAnggota,
                                ],
                              ), (panggilKembali) {
                                cekAnggotaKeluarga();
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
                              dialogOpsi(context, 'Hapus data penduduk, Anda yakin?', () async {
                                tutupHalaman(context, null);

                                await hapusPenduduk(document.id).then((hasil) {
                                  if(hasil == null || !hasil) {
                                    dialogOK(context, 'Terjadi kesalahan saat menghapus data, silahkan coba lagi', () {
                                      tutupHalaman(context, null);
                                    }, () {

                                    });
                                  }
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
              },
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

/// Layanan Berkas
Future<bool> simpanDataKTP(String noKK, String nik, String tanggalPengajuan, String tanggalBerlaku) async {
  bool hasil;

  CollectionReference berkasDaftarKTP = FirebaseFirestore.instance.collection('berkas_daftar_ktp');

  await berkasDaftarKTP.add({
    'no_kk': noKK,
    'nik': nik,
    'tanggal_pengajuan': tanggalPengajuan,
    'tanggal_berlaku': tanggalBerlaku,
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((value) {
    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

Future<bool> ubahDataKTP(String idDokumen, String noKK, String nik, String tanggalPengajuan, String tanggalBerlaku) async {
  bool hasil;

  CollectionReference berkasDaftarKTP = FirebaseFirestore.instance.collection('berkas_daftar_ktp');

  await berkasDaftarKTP.doc(idDokumen).set({
    'no_kk': noKK,
    'nik': nik,
    'tanggal_pengajuan': tanggalPengajuan,
    'tanggal_berlaku': tanggalBerlaku,
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((value) {
    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

Future<bool> hapusDataKTP(String idDokumen) async {
  bool hasil;

  CollectionReference berkasDaftarKTP = FirebaseFirestore.instance.collection('berkas_daftar_ktp');

  await berkasDaftarKTP.doc(idDokumen).delete().then((value) {
    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

Future<bool> simpanDataKelahiran(String noSKKelahiran, String namaBayi, String nik, String jenisKelaminBayi, String tanggalLahir, String jamLahir, String hariLahir, String tanggalPengajuan, String noKK, String nikAyah, String namaAyah, String umurAyah, String nikIbu, String namaIbu, String umurIbu, String alamat) async {
  bool hasil;

  CollectionReference berkasKelahiran = FirebaseFirestore.instance.collection('berkas_kelahiran');

  await berkasKelahiran.add({
    'no_sk_kelahiran': noSKKelahiran,
    'nik': nik,
    'nama_bayi': namaBayi,
    'jenis_kelamin_bayi': jenisKelaminBayi,
    'tanggal_lahir': tanggalLahir,
    'jam_lahir': jamLahir,
    'hari_lahir': hariLahir,
    'tanggal_pengajuan': tanggalPengajuan,
    'no_kk': noKK,
    'nik_ayah': nikAyah,
    'nama_ayah': namaAyah,
    'umur_ayah': umurAyah,
    'nik_ibu': nikIbu,
    'nama_ibu': namaIbu,
    'umur_ibu': umurIbu,
    'alamat': alamat,
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((value) {
    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

Future<bool> ubahDataKelahiran(String idDokumen, String noSKKelahiran, String namaBayi, String nik, String jenisKelaminBayi, String tanggalLahir, String jamLahir, String hariLahir, String tanggalPengajuan, String noKK, String nikAyah, String namaAyah, String umurAyah, String nikIbu, String namaIbu, String umurIbu, String alamat) async {
  bool hasil;

  CollectionReference berkasKelahiran = FirebaseFirestore.instance.collection('berkas_kelahiran');

  await berkasKelahiran.doc(idDokumen).set({
    'no_sk_kelahiran': noSKKelahiran,
    'nik': nik,
    'nama_bayi': namaBayi,
    'jenis_kelamin_bayi': jenisKelaminBayi,
    'tanggal_lahir': tanggalLahir,
    'jam_lahir': jamLahir,
    'hari_lahir': hariLahir,
    'tanggal_pengajuan': tanggalPengajuan,
    'no_kk': noKK,
    'nik_ayah': nikAyah,
    'nama_ayah': namaAyah,
    'umur_ayah': umurAyah,
    'nik_ibu': nikIbu,
    'nama_ibu': namaIbu,
    'umur_ibu': umurIbu,
    'alamat': alamat,
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((value) {
    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

Future<bool> hapusDataKelahiran(String idDokumen) async {
  bool hasil;

  CollectionReference berkasKelahiran = FirebaseFirestore.instance.collection('berkas_kelahiran');

  await berkasKelahiran.doc(idDokumen).delete().then((value) {
    hasil = true;
  }).catchError((error) {
    hasil = false;
  });

  return hasil;
}

/// Widget streambuilder untuk membaca data berkas berdasarkan waktu nyata (Real time)

class LihatDaftarDataKTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _berkasKTPStream = FirebaseFirestore.instance.collection('berkas_daftar_ktp').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _berkasKTPStream,
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
                              isi: 'NIK: ${data['nik']}',
                              tebal: true,
                              ukuran: 16.0,
                            ),
                            TeksGlobal(
                              isi: 'Nomor KK: ${data['no_kk']}',
                              ukuran: 14.0,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pindahKeHalaman(context, FormKeteranganDaftarKTP(dataKeterangan: [
                            document.id,
                            data['no_kk'],
                            data['nik'],
                            data['tanggal_pengajuan'],
                            data['tanggal_berlaku'],
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
                          dialogOpsi(context, 'Hapus data berkas, Anda yakin?', () async {
                            tutupHalaman(context, null);

                            await hapusDataKTP(document.id).then((hasil) {
                              if(hasil == null || !hasil) {
                                dialogOK(context, 'Terjadi kesalahan saat menghapus data, silahkan coba lagi', () {
                                  tutupHalaman(context, null);
                                }, () {

                                });
                              }
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

class LihatDaftarDataKelahiran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _berkasKTPStream = FirebaseFirestore.instance.collection('berkas_kelahiran').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _berkasKTPStream,
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
                              isi: 'No. Surat Kelahiran:',
                              tebal: true,
                              ukuran: 16.0,
                            ),
                            TeksGlobal(
                              isi: data['no_sk_kelahiran'],
                              ukuran: 14.0,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pindahKeHalaman(context, FormKeteranganKelahiran(dataKeterangan: [
                            document.id,
                            data['no_kk'],
                            data['no_sk_kelahiran'],
                            data['nik'],
                            data['nama_bayi'],
                            data['jenis_kelamin_bayi'],
                            data['tanggal_lahir'],
                            data['jam_lahir'],
                            data['hari_lahir'],
                            data['tanggal_pengajuan'],
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
                          dialogOpsi(context, 'Hapus data berkas, Anda yakin?', () async {
                            tutupHalaman(context, null);

                            await hapusDataKelahiran(document.id).then((hasil) {
                              if(hasil == null || !hasil) {
                                dialogOK(context, 'Terjadi kesalahan saat menghapus data, silahkan coba lagi', () {
                                  tutupHalaman(context, null);
                                }, () {

                                });
                              }
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