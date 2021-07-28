import 'package:aplikasi_data_warga/halaman/halaman_pembuka.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Desa Palasari',
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HalamanPembuka(),
      },
    );
  }
}