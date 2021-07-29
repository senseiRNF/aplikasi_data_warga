import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> preferensi = SharedPreferences.getInstance();

/// Fungsi pengaturan preferensi global (global preferences)
///
/// atur preferensi

Future<bool> aturEmail(String email) async {
  bool hasil;

  final SharedPreferences prefs = await preferensi;

  await prefs.setString('email', email).then((value) {
    hasil = true;
  }).catchError((e) {
    print(e);

    hasil = false;
  });

  return hasil;
}

Future<bool> aturNama(String nama) async {
  bool hasil;

  final SharedPreferences prefs = await preferensi;

  await prefs.setString('nama', nama).then((value) {
    hasil = true;
  }).catchError((e) {
    print(e);

    hasil = false;
  });

  return hasil;
}

Future<bool> aturJabatan(String jabatan) async {
  bool hasil;

  final SharedPreferences prefs = await preferensi;

  await prefs.setString('jabatan', jabatan).then((value) {
    hasil = true;
  }).catchError((e) {
    print(e);

    hasil = false;
  });

  return hasil;
}

/// tampilkan preferensi

Future<String> tampilkanEmail() async {
  String hasil;

  final SharedPreferences prefs = await preferensi;

  hasil = prefs.getString('email');

  return hasil;
}

Future<String> tampilkanNama() async {
  String hasil;

  final SharedPreferences prefs = await preferensi;

  hasil = prefs.getString('nama');

  return hasil;
}

Future<String> tampilkanJabatan() async {
  String hasil;

  final SharedPreferences prefs = await preferensi;

  hasil = prefs.getString('jabatan');

  return hasil;
}

/// hapus semua preferensi

Future<bool> hapusPreferensi() async {
  bool result;

  final SharedPreferences prefs = await preferensi;

  await prefs.clear().then((value) {
    result = true;
  }).catchError((e) {
    result = false;
  });

  return result;
}