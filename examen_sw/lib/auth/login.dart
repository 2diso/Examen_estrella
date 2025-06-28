import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final userCredential = await signInWithGoogle();
            if (userCredential != null && mounted) {
              Navigator.pushReplacementNamed(context, '/list');
            }
          },
          child: Text('Iniciar sesión'),
        ),
      ),
    );
  }
}

Future<UserCredential?> signInWithGoogle() async {
  final googleProvider = GoogleAuthProvider();

  try {
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  } catch (e) {
    print("Error al iniciar sesión con Google: $e");
    return null;
  }
}
