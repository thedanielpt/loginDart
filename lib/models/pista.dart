class Pista {
  final int id;
  final String nombre;
  final String descripcion;
  final String tipo;
  final int capacidad;

  const Pista({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.tipo,
    required this.capacidad,
  });

  factory Pista.fromMap(Map<String, Object?> map) => Pista(
        id: map['id'] as int,
        nombre: map['nombre'] as String,
        descripcion: map['descripcion'] as String,
        tipo: map['tipo'] as String,
        capacidad: map['capacidad'] as int,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
        'tipo': tipo,
        'capacidad': capacidad,
      };
}
