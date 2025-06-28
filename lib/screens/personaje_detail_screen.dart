
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/personaje_model.dart';

class PersonajeDetailScreen extends StatelessWidget {
  final Personaje personaje;

  const PersonajeDetailScreen({super.key, required this.personaje});

  void agregarAFavoritos() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance
        .collection('favoritos')
        .doc(user.uid)
        .collection('personajes')
        .doc(personaje.nombre);

    await docRef.set({
      'nombre': personaje.nombre,
      'genero': personaje.genero,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personaje.nombre),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: agregarAFavoritos,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              personaje.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Género: \${personaje.genero}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
