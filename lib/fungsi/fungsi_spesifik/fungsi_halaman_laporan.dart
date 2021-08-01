import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:aplikasi_data_warga/layanan/layanan_firestore.dart';

Future<List> muatHalamanLaporan() async {
  List hasil = [];

  int jumlahPenduduk = 0;
  int jumlahLaki = 0;
  int jumlahPerempuan = 0;
  int jumlahBalita = 0;
  int jumlahAnak = 0;
  int jumlahRemaja = 0;
  int jumlahDewasa = 0;
  int jumlahLansia = 0;
  int jumlahBelumKawin = 0;
  int jumlahKawin = 0;
  int jumlahCeraiHidup = 0;
  int jumlahCeraiMati = 0;
  int jumlahPegawai = 0;
  int jumlahSKDaftarKTP = 0;
  int jumlahSKKelahiran = 0;
  int jumlahSKKematian = 0;
  int jumlahSKPindah = 0;

  await firestore.collection('data_penduduk').get().then((querySnapshot) async {
    List idKartuKeluarga = querySnapshot.docs.map((doc) => doc.id).toList();
    List dataPenduduk = querySnapshot.docs.map((doc) => doc.data()).toList();

    jumlahPenduduk = jumlahPenduduk + dataPenduduk.length;

    for(int i = 0; i < dataPenduduk.length; i++) {
      await firestore.collection('data_penduduk').doc(idKartuKeluarga[i]).collection('anggota_keluarga').get().then((snapshotAnggota) {
        List anggotaKeluarga = snapshotAnggota.docs.map((doc) => doc.data()).toList();

        for(int x = 0; x < anggotaKeluarga.length; x++) {
          if(anggotaKeluarga[x]['jenis_kelamin'] == 'LAKI-LAKI') {
            jumlahLaki = jumlahLaki + 1;
          } else {
            jumlahPerempuan = jumlahPerempuan + 1;
          }

          if(int.parse(hitungUmur(DateTime.parse(anggotaKeluarga[x]['tanggal_lahir']).year)) < 4) {
            jumlahBalita = jumlahBalita + 1;
          } else if(int.parse(hitungUmur(DateTime.parse(anggotaKeluarga[x]['tanggal_lahir']).year)) >= 4 && int.parse(hitungUmur(DateTime.parse(anggotaKeluarga[x]['tanggal_lahir']).year)) <= 12) {
            jumlahAnak = jumlahAnak + 1;
          } else if(int.parse(hitungUmur(DateTime.parse(anggotaKeluarga[x]['tanggal_lahir']).year)) >= 13 && int.parse(hitungUmur(DateTime.parse(anggotaKeluarga[x]['tanggal_lahir']).year)) <= 19) {
            jumlahRemaja = jumlahRemaja + 1;
          } else if(int.parse(hitungUmur(DateTime.parse(anggotaKeluarga[x]['tanggal_lahir']).year)) >= 20 && int.parse(hitungUmur(DateTime.parse(anggotaKeluarga[x]['tanggal_lahir']).year)) <= 59) {
            jumlahDewasa = jumlahDewasa + 1;
          } else {
            jumlahLansia = jumlahLansia + 1;
          }

          if(anggotaKeluarga[x]['status_perkawinan'] == 'BELUM KAWIN') {
            jumlahBelumKawin = jumlahBelumKawin + 1;
          } else if(anggotaKeluarga[x]['status_perkawinan'] == 'KAWIN') {
            jumlahKawin = jumlahKawin + 1;
          } else if(anggotaKeluarga[x]['status_perkawinan'] == 'CERAI HIDUP') {
            jumlahCeraiHidup = jumlahCeraiHidup + 1;
          } else {
            jumlahCeraiMati = jumlahCeraiMati + 1;
          }
        }
      });
    }

    await firestore.collection('user').get().then((querySnapshot) async {
      List dataPengguna = querySnapshot.docs.map((doc) => doc.data()).toList();

      jumlahPegawai = jumlahPegawai + dataPengguna.length;

      await firestore.collection('berkas_daftar_ktp').get().then((querySnapshot) async {
        List dataBerkasKTP = querySnapshot.docs.map((doc) => doc.data()).toList();

        jumlahSKDaftarKTP = jumlahSKDaftarKTP + dataBerkasKTP.length;

        await firestore.collection('berkas_kelahiran').get().then((querySnapshot) async {
          List dataBerkasKelahiran = querySnapshot.docs.map((doc) => doc.data()).toList();

          jumlahSKKelahiran = jumlahSKKelahiran + dataBerkasKelahiran.length;

          await firestore.collection('berkas_kematian').get().then((querySnapshot) async {
            List dataBerkasKematian = querySnapshot.docs.map((doc) => doc.data()).toList();

            jumlahSKKematian = jumlahSKKematian + dataBerkasKematian.length;

            await firestore.collection('berkas_pindah').get().then((querySnapshot) async {
              List dataBerkasPindah = querySnapshot.docs.map((doc) => doc.data()).toList();

              jumlahSKPindah = jumlahSKPindah + dataBerkasPindah.length;
            }).catchError((onError) {
              print('[$onError]');
            });
          }).catchError((onError) {
            print('[$onError]');
          });
        }).catchError((onError) {
          print('[$onError]');
        });
      }).catchError((onError) {
        print('[$onError]');
      });
    }).catchError((onError) {
      print('[$onError]');
    });
  }).catchError((onError) {
    print('[$onError]');
  });

  hasil.add(jumlahPenduduk);
  hasil.add(jumlahLaki);
  hasil.add(jumlahPerempuan);
  hasil.add(jumlahBalita);
  hasil.add(jumlahAnak);
  hasil.add(jumlahRemaja);
  hasil.add(jumlahDewasa);
  hasil.add(jumlahLansia);
  hasil.add(jumlahBelumKawin);
  hasil.add(jumlahKawin);
  hasil.add(jumlahCeraiHidup);
  hasil.add(jumlahCeraiMati);
  hasil.add(jumlahPegawai);
  hasil.add(jumlahSKDaftarKTP);
  hasil.add(jumlahSKKelahiran);
  hasil.add(jumlahSKKematian);
  hasil.add(jumlahSKPindah);

  return hasil;
}