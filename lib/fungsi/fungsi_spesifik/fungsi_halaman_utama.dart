import 'package:aplikasi_data_warga/layanan/preferensi_global.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';

void muatHalamanUtama(Function fungsiMuat) async {
  String nama = await tampilkanNama();
  String surel = await tampilkanSurel();

  fungsiMuat(nama, surel);
}

/*
void kirimSurelBantuan(String penerima, String isiPesan) async {
  Email surel = Email(
    recipients: [penerima],
    subject: 'Bantuan dan Saran Aplikasi',
    body: isiPesan,
  );

  await FlutterEmailSender.send(surel);
}*/
