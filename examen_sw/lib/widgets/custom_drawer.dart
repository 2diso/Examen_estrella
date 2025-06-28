import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              accountName: Text(
                user?.displayName ?? 'Usuario Galáctico',
                style: const TextStyle(color: Colors.yellow),
              ),
              accountEmail: Text(
                user?.email ?? 'Sin correo',
                style: const TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[800],
                child: Text(
                  (user?.email?.isNotEmpty ?? false)
                      ? user!.email![0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.yellow),
              title: const Text("Inicio", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list, color: Colors.yellow),
              title: const Text("Personajes", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/list');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.yellow),
              title: const Text("Perfil", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/about');
              },
            ),
            const Divider(color: Colors.white38),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("Cerrar sesión", style: TextStyle(color: Colors.white)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
