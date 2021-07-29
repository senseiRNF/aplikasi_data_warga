import 'package:anxiety_disorder_diagnostic/fungsi/fungsi_global.dart';
import 'package:anxiety_disorder_diagnostic/halaman/halaman_riwayat.dart';
import 'package:anxiety_disorder_diagnostic/widget/widget_global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> simpanData(String surel, double bobotCF, int jenisGangguan, Function fungsiBerhasil, Function fungsiGagal) async {
  CollectionReference riwayat = FirebaseFirestore.instance.collection(surel);

  return riwayat.add({
    'bobotCF': bobotCF,
    'jenisGangguan': jenisGangguan,
    'tanggal': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'jam': DateFormat('HH:mm').format(DateTime.now()),
  }).then((value) {
    fungsiBerhasil();
  }).catchError((error) {
    fungsiGagal();
  });
}

Future<void> hapusData(String surel, String idDokumen, Function fungsiBerhasil, Function fungsiGagal) async {
  CollectionReference riwayat = FirebaseFirestore.instance.collection(surel);

  return riwayat.doc(idDokumen).delete().then((value) {
    fungsiBerhasil();
  }).catchError((error) {
    fungsiGagal();
  });
}

/// Widget streambuilder untuk membaca data berdasarkan waktu nyata (Real time)

class LihatData extends StatefulWidget {
  final String surel;

  LihatData({
    @required this.surel,
  });

  @override
  _LihatDataState createState() => _LihatDataState();
}

class _LihatDataState extends State<LihatData> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection(widget.surel).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_off,
                size: 40.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              TeksGlobal(
                isi: 'Gagal terhubung ke server',
                ukuran: 20.0,
                tebal: true,
                posisi: TextAlign.center,
              ),
            ],
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: TeksGlobal(
                    isi: 'Sedang memuat...',
                    ukuran: 16.0,
                    tebal: true,
                    posisi: TextAlign.center,
                  ),
                ),
              ),
              IndikatorProgressGlobal(),
            ],
          );
        }

        return snapshot.data.docs.length != 0 ?
        ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.0,),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20.0,),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0,),
                            bottomLeft: Radius.circular(20.0,),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TeksGlobal(
                              isi: DateFormat('dd MMMM yyyy').format(DateTime.parse(data['tanggal'])),
                              ukuran: 20.0,
                              tebal: true,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            TeksGlobal(
                              isi: data['jam'],
                              ukuran: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0,),
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            pindahKeHalaman(context, HalamanRiwayat(
                              surel: widget.surel,
                              idDokumen: document.id,
                              jenisGangguan: data['jenisGangguan'],
                              bobotCFCombined: data['bobotCF'],
                            ), (panggilKembali) {

                            });
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                          ),
                          color: Colors.white,
                          iconSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ) :
        Center(
          child: TeksGlobal(
            isi: 'Tidak ada data tersimpan...',
            ukuran: 16.0,
            tebal: true,
            posisi: TextAlign.center,
          ),
        );
      },
    );
  }
}