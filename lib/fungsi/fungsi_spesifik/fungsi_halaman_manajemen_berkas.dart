import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/layanan/layanan_firestore.dart';
import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

void dialogOpsiKK(BuildContext context, List daftarOpsi, Function tutupDialog) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0,),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
          ),
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0, bottom: 20.0,),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: daftarOpsi.length,
            itemBuilder: (BuildContext opsi, int indeks) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0,),
                ),
                elevation: 10.0,
                child: InkWell(
                  onTap: () {
                    tutupHalaman(context, daftarOpsi[indeks]);
                  },
                  borderRadius: BorderRadius.circular(5.0,),
                  child: Padding(
                    padding: EdgeInsets.all(10.0,),
                    child: TeksGlobal(
                      isi: daftarOpsi[indeks][1],
                      ukuran: 16.0,
                      posisi: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  ).then((hasil) {
    if(hasil != null) {
      tutupDialog(hasil);
    }
  });
}

void dialogOpsiAnggotaKeluarga(BuildContext context, List daftarOpsi, Function tutupDialog) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0,),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
          ),
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0, bottom: 20.0,),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: daftarOpsi.length,
            itemBuilder: (BuildContext opsi, int indeks) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0,),
                ),
                elevation: 10.0,
                child: InkWell(
                  onTap: () {
                    tutupHalaman(context, daftarOpsi[indeks]);
                  },
                  borderRadius: BorderRadius.circular(5.0,),
                  child: Padding(
                    padding: EdgeInsets.all(10.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TeksGlobal(
                          isi: daftarOpsi[indeks][0],
                          ukuran: 16.0,
                          posisi: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TeksGlobal(
                          isi: daftarOpsi[indeks][1],
                          ukuran: 16.0,
                          posisi: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  ).then((hasil) {
    if(hasil != null) {
      tutupDialog(hasil);
    }
  });
}

Future<List> muatDaftarKartuKeluarga(List dataBerkas, Function fungsiUbah) async {
  List hasil = [];

  await firestore.collection('data_penduduk').get().then((querySnapshot) {
    List idKartuKeluarga = querySnapshot.docs.map((doc) => doc.id).toList();
    List noKartuKeluarga = querySnapshot.docs.map((doc) => doc.data()).toList();

    for(int i = 0; i < noKartuKeluarga.length; i++) {
      hasil.add([
        idKartuKeluarga[i],
        noKartuKeluarga[i]['no_kk']
      ]);

      if(dataBerkas.isNotEmpty) {
        if(noKartuKeluarga[i]['no_kk'] == dataBerkas[1]) {
          fungsiUbah(idKartuKeluarga[i]);
        }
      }
    }
  }).catchError((onError) {
    print('[$onError]');
  });

  return hasil;
}

Future<List> muatDaftarAnggotaKeluarga(String idDokumen) async {
  List hasil = [];

  await firestore.collection('data_penduduk').doc(idDokumen).collection('anggota_keluarga').get().then((querySnapshot) {
    List dataAnggota = querySnapshot.docs.map((doc) => doc.data()).toList();

    for(int i = 0; i < dataAnggota.length; i++) {
      hasil.add([
        dataAnggota[i]['nik'],
        dataAnggota[i]['nama'],
        dataAnggota[i]['tanggal_lahir'],
      ]);
    }
  }).catchError((onError) {
    print('[$onError]');
  });

  return hasil;
}

Future<List> muatDataAyahIbu(String idDokumen) async {
  List hasil = [];

  await firestore.collection('data_penduduk').doc(idDokumen).collection('anggota_keluarga').get().then((querySnapshot) {
    List dataAnggota = querySnapshot.docs.map((doc) => doc.data()).toList();

    for(int i = 0; i < dataAnggota.length; i++) {
      if(dataAnggota[i]['status_dalam_keluarga'] == 'KEPALA KELUARGA' || dataAnggota[i]['status_dalam_keluarga'] == 'SUAMI' || dataAnggota[i]['status_dalam_keluarga'] == 'ISTRI') {
        hasil.add([
          dataAnggota[i]['nama'],
          dataAnggota[i]['nik'],
          dataAnggota[i]['tanggal_lahir'],
          dataAnggota[i]['jenis_kelamin'],
          dataAnggota[i]['status_dalam_keluarga'],
        ]);
      }
    }
  }).catchError((onError) {
    print('[$onError]');
  });

  return hasil;
}

Future<String> muatAlamat(String noKK) async {
  String hasil;

  await firestore.collection('data_penduduk').get().then((querySnapshot) {
    List noKartuKeluarga = querySnapshot.docs.map((doc) => doc.data()).toList();

    for(int i = 0; i < noKartuKeluarga.length; i++) {
      if(noKartuKeluarga[i]['no_kk'] == noKK) {
        hasil = noKartuKeluarga[i]['alamat'];
      }
    }
  }).catchError((onError) {
    print('[$onError]');
  });

  return hasil;
}