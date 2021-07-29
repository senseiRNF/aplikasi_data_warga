import 'package:flutter/material.dart';

/// Widget dengan keadaan (stateful Widget)

//-------------------------------------------------------------//

/// Widget tanpa keadaan (stateless widget)

class KartuMenu extends StatelessWidget {
  final int noMenu;

  KartuMenu({
    @required this.noMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0,),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0,),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0,),
          ),
          elevation: 10.0,
        ),
      ),
    );
  }
}