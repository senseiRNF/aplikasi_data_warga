import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

/// Widget dengan keadaan (stateful Widget)

/// Widget tanpa keadaan (stateless widget)

class TombolMasukAdmin extends StatelessWidget {
  final Function fungsiTombol;

  TombolMasukAdmin({
    @required this.fungsiTombol,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        fungsiTombol();
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black38,
          ),
          borderRadius: BorderRadius.circular(5.0,),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0,),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0,),
              child: SizedBox(
                height: 30.0,
                child: Image.asset(
                  'aset/gambar/ikon_google.png',
                ),
              ),
            ),
            Expanded(
              child: TeksGlobal(
                isi: 'Masuk dengan akun Google',
                ukuran: 14.0,
                posisi: TextAlign.center,
                tebal: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}