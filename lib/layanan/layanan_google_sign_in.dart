import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ],
);

Future<void> masukDenganGoogle(BuildContext context) async {
  try {
    await googleSignIn.signIn();
  } catch(error) {
    print('ERROR pada layanan Sign In Google: $error');
  }
}