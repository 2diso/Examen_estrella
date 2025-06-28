import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/personaje_model.dart';

class PersonajeDetailScreen extends StatefulWidget {
  final Personaje personaje;

  const PersonajeDetailScreen({super.key, required this.personaje});

  @override
  State<PersonajeDetailScreen> createState() => _PersonajeDetailScreenState();
}

class _PersonajeDetailScreenState extends State<PersonajeDetailScreen> {
  bool esFavorito = false;

  String get docId =>
      widget.personaje.nombre.toLowerCase().replaceAll(' ', '_');

  Future<void> verificarFavorito() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance
        .collection('favoritos')
        .doc(user.uid)
        .collection('personajes')
        .doc(docId);

    final doc = await docRef.get();
    setState(() {
      esFavorito = doc.exists;
    });
  }

  Future<void> toggleFavorito() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance
        .collection('favoritos')
        .doc(user.uid)
        .collection('personajes')
        .doc(docId);

    if (esFavorito) {
      await docRef.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Eliminado de favoritos')),
      );
    } else {
      await docRef.set({
        'nombre': widget.personaje.nombre,
        'genero': widget.personaje.genero,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Añadido a favoritos')),
      );
    }

    setState(() {
      esFavorito = !esFavorito;
    });
  }

  @override
  void initState() {
    super.initState();
    verificarFavorito();
  }

  @override
  Widget build(BuildContext context) {
    final personaje = widget.personaje;

    return Scaffold(
      appBar: AppBar(
        title: Text(personaje.nombre),
        actions: [
          IconButton(
            icon: Icon(
              esFavorito ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: toggleFavorito,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              personaje.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Género: ${personaje.genero}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
