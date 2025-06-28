import 'package:flutter/material.dart';
import '../models/personaje_model.dart';
import '../services/swapi_service.dart';
import 'personaje_detail_screen.dart';

class PersonajeListScreen extends StatefulWidget {
  const PersonajeListScreen({super.key});

  @override
  _PersonajeListScreenState createState() => _PersonajeListScreenState();
}

class _PersonajeListScreenState extends State<PersonajeListScreen> {
  List<Personaje> personajes = [];
  bool isLoading = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchPersonajes();
  }

  Future<void> fetchPersonajes([String query = '']) async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetched = await SwapiService.fetchPersonajes(query);
      setState(() {
        personajes = fetched;
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onSearch(String query) {
    searchQuery = query;
    fetchPersonajes(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
        title: const Text('Personajes de Star Wars'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: onSearch,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Buscar personaje',
                labelStyle: const TextStyle(color: Colors.yellow),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.yellow),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.amber, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              ),
            )
          else if (personajes.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'No se encontraron personajes.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: personajes.length,
                itemBuilder: (context, index) {
                  final personaje = personajes[index];
                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.yellow),
                      title: Text(
                        personaje.nombre,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Género: ${personaje.genero}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PersonajeDetailScreen(personaje: personaje),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
