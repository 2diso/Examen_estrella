import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/personaje_model.dart';

class SwapiService {
  static Future<List<Personaje>> fetchPersonajes([String query = '']) async {
    // Usamos el endpoint alternativo compatible con Flutter Web
    final url = Uri.parse('https://swapi.py4e.com/api/people/?search=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      return results.map((json) => Personaje.fromJson(json)).toList();
    } else {
      throw Exception('Fallo al cargar personajes');
    }
  }
}
