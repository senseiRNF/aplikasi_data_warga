import 'package:aplikasi_data_warga/widget/widget_global.dart';
import 'package:flutter/material.dart';

/// Koleksi fungsi yang dapat digunakan di semua halaman (global functions)

void pindahKeHalaman(BuildContext context, Widget sasaran, Function panggilKembali) {
  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext targetContext) => sasaran)).then((hasil) {
    panggilKembali(hasil);
  });
}

void timpaDenganHalaman(BuildContext context, Widget sasaran) {
  Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext targetContext) => sasaran));
}

void tutupHalaman(BuildContext context, var hasil) {
  Navigator.of(context).pop(hasil);
}

void dialogOK(BuildContext context, String pesan, Function tekanOK, Function tutupDialog) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TeksGlobal(isi: pesan, warna: Colors.black, posisi: TextAlign.center),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TombolGlobal(judul: 'OK', warnaTombol: Colors.white, warnaJudul: Colors.black54, fungsiTekan: () {
                    tekanOK();
                  })
                ],
              ),
            ],
          ),
        ),
      );
    },
  ).then((hasil) {
    tutupDialog();
  });
}

void dialogOpsi(BuildContext context, String pesan, Function tekanYa, Function tekanTidak) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TeksGlobal(isi: pesan, warna: Colors.black, posisi: TextAlign.center),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TombolGlobal(judul: 'Tidak', warnaTombol: Colors.white, warnaJudul: Colors.red, fungsiTekan: () {
                      tekanTidak();
                    }),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TombolGlobal(judul: 'Ya', warnaTombol: Colors.white, warnaJudul: Colors.black54, fungsiTekan: () {
                      tekanYa();
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void dialogDaftarOpsi(BuildContext context, List daftarOpsi, Function tutupDialog) {
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
                      isi: daftarOpsi[indeks],
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

String konversiHari(String hari) {
  String hasil;

  switch(hari) {
    case 'Sunday':
      hasil = 'Minggu';
      break;
    case 'Monday':
      hasil = 'Senin';
      break;
    case 'Tuesday':
      hasil = 'Selasa';
      break;
    case 'Wednesday':
      hasil = 'Rabu';
      break;
    case 'Thursday':
      hasil = 'Kamis';
      break;
    case 'Friday':
      hasil = 'Jumat';
      break;
    case 'Saturday':
      hasil = 'Sabtu';
      break;
  }

  return hasil;
}

String hitungUmur(int tahunLahir) {
  String hasil;

  int umur = DateTime.now().year - tahunLahir;
  hasil = umur.toString();

  return hasil;
}