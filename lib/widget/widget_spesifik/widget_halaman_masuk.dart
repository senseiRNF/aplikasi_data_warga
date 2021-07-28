import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

/// Widget dengan keadaan (stateful Widget)

class LatarMasuk extends StatefulWidget {
  final bool memuat;
  final Function fungsiTekan;

  LatarMasuk({
    @required this.memuat,
    @required this.fungsiTekan,
  });

  @override
  _LatarMasukState createState() => _LatarMasukState();
}

class _LatarMasukState extends State<LatarMasuk> {
  @override
  void initState() {
    super.initState();
  }

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Image.asset(
                            'aset/gambar/gambar_karakter.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TeksGlobal(
                          isi: 'Selamat Datang\ndi Aplikasi Desa Palasari Kecamatan Legok',
                          ukuran: 16.0,
                          tebal: true,
                          posisi: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  !widget.memuat ?
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0,),
                    child: TombolMasukAdmin(
                      fungsiTombol: () {
                        widget.fungsiTekan();
                      },
                    ),
                  ) :
                  IndikatorProgressGlobal(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

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