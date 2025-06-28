
class Personaje {
  final String nombre;
  final String genero;

  Personaje({required this.nombre, required this.genero});

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
      nombre: json['name'] ?? 'Desconocido',
      genero: json['gender'] ?? 'n/a',
    );
  }
}
