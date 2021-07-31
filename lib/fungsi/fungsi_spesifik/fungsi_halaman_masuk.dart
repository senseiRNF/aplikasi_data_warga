import 'package:aplikasi_data_warga/layanan/layanan_firestore.dart';

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