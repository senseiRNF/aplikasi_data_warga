import 'package:aplikasi_data_warga/fungsi/fungsi_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Koleksi widget yang dapat digunakan di semua halaman (global widgets)
///
/// Widget tanpa keadaan (stateless widget)

class TeksGlobal extends StatelessWidget {
  final String isi;
  final double ukuran;
  final Color warna;
  final bool tebal;
  final TextAlign posisi;

  TeksGlobal({
    @required this.isi,
    this.ukuran,
    this.warna,
    this.tebal,
    this.posisi,
  });

  double _periksaUkuran() {
    double hasil;

    ukuran != null ? hasil = ukuran : hasil = 14.0;

    return hasil;
  }

  Color _periksaWarna() {
    Color hasil;

    warna != null ? hasil = warna : hasil = Colors.black;

    return hasil;
  }

  FontWeight _periksaTebal() {
    FontWeight hasil;

    tebal != null && tebal ? hasil = FontWeight.bold : hasil = FontWeight.normal;

    return hasil;
  }

  TextAlign _periksaPosisi() {
    TextAlign hasil;

    posisi != null ? hasil = posisi : hasil = TextAlign.start;

    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      isi,
      style: TextStyle(
        fontSize: _periksaUkuran(),
        color: _periksaWarna(),
        fontWeight: _periksaTebal(),
      ),
      textAlign: _periksaPosisi(),
    );
  }
}

class InputTeksGlobal extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType jenisInput;
  final TextCapitalization kapitalisasi;

  InputTeksGlobal({
    @required this.label,
    @required this.controller,
    this.jenisInput,
    this.kapitalisasi,
  });

  TextInputType periksaJenisInput() {
    TextInputType result;

    jenisInput != null ? result = jenisInput : result = TextInputType.text;

    return result;
  }

  TextCapitalization periksaKapitalisasi() {
    TextCapitalization result;

    kapitalisasi != null ? result = kapitalisasi : result = TextCapitalization.none;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      controller: controller,
      keyboardType: periksaJenisInput(),
      textCapitalization: periksaKapitalisasi(),
    );
  }
}

class InputAngkaGlobal extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  InputAngkaGlobal({
    @required this.label,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters:
      [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FormatInputAngkaRibuan(),
      ],
    );
  }
}

class TombolGlobal extends StatelessWidget {
  final String judul;
  final Function fungsiTekan;
  final Color warnaTombol;
  final double ukuranJudul;
  final Color warnaJudul;

  TombolGlobal({
    @required this.judul,
    @required this.fungsiTekan,
    this.warnaTombol,
    this.ukuranJudul,
    this.warnaJudul,
  });

  Color _periksaWarnaTombol() {
    Color result;

    warnaTombol != null ? result = warnaTombol : result = Color(0xFFA1E5FB);

    return result;
  }

  double _periksaUkuranJudul() {
    double result;

    ukuranJudul != null ? result = ukuranJudul : result = 14.0;

    return result;
  }

  Color _periksaWarnaJudul() {
    Color result;

    warnaJudul != null ? result = warnaJudul : result = Colors.white;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        fungsiTekan();
      },
      style: ElevatedButton.styleFrom(
        primary: _periksaWarnaTombol(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0,),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: TeksGlobal(
          isi: judul,
          ukuran: _periksaUkuranJudul(),
          warna: _periksaWarnaJudul(),
          tebal: true,
        ),
      ),
    );
  }
}

class TombolTeksGlobal extends StatelessWidget {
  final String judul;
  final Function fungsiTekan;
  final double ukuranJudul;
  final Color warnaJudul;

  TombolTeksGlobal({
    @required this.judul,
    @required this.fungsiTekan,
    this.ukuranJudul,
    this.warnaJudul,
  });

  double _periksaUkuranJudul() {
    double result;

    ukuranJudul != null ? result = ukuranJudul : result = 14.0;

    return result;
  }

  Color _periksaWarnaJudul() {
    Color result;

    warnaJudul != null ? result = warnaJudul : result = Colors.black;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        fungsiTekan();
      },
      child: TeksGlobal(
        isi: judul,
        ukuran: _periksaUkuranJudul(),
        warna: _periksaWarnaJudul(),
      ),
    );
  }
}

class IndikatorProgressGlobal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0,),
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      ),
    );
  }
}

class InputOpsi extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List daftarOpsi;
  final Function fungsiGanti;

  InputOpsi({
    @required this.label,
    @required this.controller,
    @required this.daftarOpsi,
    @required this.fungsiGanti,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dialogDaftarOpsi(context, daftarOpsi, (hasil) {
          fungsiGanti(hasil);
        });
      },
      borderRadius: BorderRadius.circular(5.0,),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        controller: controller,
        enabled: false,
      ),
    );
  }
}

class InputAngkaTanpaPemisah extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  InputAngkaTanpaPemisah({
    @required this.label,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters:
      [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
    );
  }
}

class InputTanggal extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final DateTime tanggal;
  final Function fungsiGanti;

  InputTanggal({
    @required this.label,
    @required this.controller,
    @required this.tanggal,
    @required this.fungsiGanti,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: tanggal != null ? tanggal : DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ).then((hasil) {
          if(hasil != null) {
            fungsiGanti(hasil);
          }
        });
      },
      borderRadius: BorderRadius.circular(5.0,),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        controller: controller,
        enabled: false,
      ),
    );
  }
}

class TombolMenuBerlatar extends StatelessWidget {
  final Function fungsiTombol;
  final String judul;
  final String gambar;

  TombolMenuBerlatar({
    @required this.fungsiTombol,
    @required this.judul,
    @required this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          fungsiTombol();
        },
        borderRadius: BorderRadius.circular(20.0,),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black38,
            ),
            borderRadius: BorderRadius.circular(20.0,),
          ),
          elevation: 10.0,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Opacity(
                  opacity: 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0,),
                      bottomLeft: Radius.circular(20.0,),
                    ),
                    child: SizedBox(
                      height: 100.0,
                      child: Image.asset(
                        gambar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(10.0,),
                  child: TeksGlobal(
                    isi: judul,
                    ukuran: 14.0,
                    posisi: TextAlign.center,
                    tebal: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LatarBelakangGlobal extends StatelessWidget {
  final Widget tampilan;

  LatarBelakangGlobal({
    @required this.tampilan,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'aset/gambar/latar_belakang.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        tampilan,
      ],
    );
  }
}

class InputNonAktif extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  InputNonAktif({
    @required this.label,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0,),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      controller: controller,
      enabled: false,
    );
  }
}

class InputJam extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function fungsiGanti;

  InputJam({
    @required this.label,
    @required this.controller,
    @required this.fungsiGanti,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child,
            );
          },
        ).then((hasil) {
          if(hasil != null) {
            fungsiGanti(hasil);
          }
        });
      },
      borderRadius: BorderRadius.circular(5.0,),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        controller: controller,
        enabled: false,
      ),
    );
  }
}
/// Widget dengan keadaan (stateful Widget)

class InputKataSandiGlobal extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  InputKataSandiGlobal({
    @required this.label,
    @required this.controller,
  });

  @override
  _InputKataSandiGlobalState createState() => _InputKataSandiGlobalState();
}

class _InputKataSandiGlobalState extends State<InputKataSandiGlobal> {
  bool sembunyikan = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0,),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                sembunyikan = !sembunyikan;
              });
            },
            icon: Icon(
              sembunyikan ? Icons.visibility : Icons.visibility_off,
            ),
          )
      ),
      obscureText: sembunyikan,
      controller: widget.controller,
    );
  }
}

class KotakCentangGlobal extends StatefulWidget {
  final String judul;
  final Function fungsiUbah;

  KotakCentangGlobal({
    @required this.judul,
    @required this.fungsiUbah,
  });

  @override
  _KotakCentangGlobalState createState() => _KotakCentangGlobalState();
}

class _KotakCentangGlobalState extends State<KotakCentangGlobal> {
  bool dicentang = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: CheckboxListTile(
        value: dicentang,
        onChanged: (value) {
          setState(() {
            dicentang = value;
          });

          widget.fungsiUbah(value);
        },
        title: TeksGlobal(
          isi: widget.judul,
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}

/// Lain-lain

class FormatInputAngkaRibuan extends TextInputFormatter {
  static const pemisah = '.'; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(pemisah, '');
    String newValueText = newValue.text.replaceAll(pemisah, '');

    if (oldValue.text.endsWith(pemisah) && oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = pemisah + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}