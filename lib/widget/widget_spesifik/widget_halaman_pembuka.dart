import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

/// Widget tanpa keadaan (stateless widget)

class LatarPembuka extends StatelessWidget {
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
              Center(
                child: Padding(
                  padding: EdgeInsets.all(50.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'aset/gambar/gambar_karakter.png',
                        ),
                      ),
                      TeksGlobal(
                        isi: 'Aplikasi Desa Palasari\nKecamatan Legok',
                        ukuran: 20.0,
                        tebal: true,
                        posisi: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        IndikatorProgressGlobal(),
      ],
    );
  }
}