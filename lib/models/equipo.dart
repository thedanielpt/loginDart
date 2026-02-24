class Equipo {
  final int id;
  final String nombre;
  final List<int> listaJugadoresIds;
  final int arbitroId;
  final String descripcion;

  const Equipo({
    required this.id,
    required this.nombre,
    required this.listaJugadoresIds,
    required this.arbitroId,
    required this.descripcion,
  });

  factory Equipo.fromDb({
    required Map<String, Object?> equipo,
    required List<int> jugadores,
  }) {
    return Equipo(
      id: equipo['id'] as int,
      nombre: equipo['nombre'] as String,
      listaJugadoresIds: jugadores,
      arbitroId: equipo['arbitroId'] as int,
      descripcion: equipo['descripcion'] as String,
    );
  }

  Map<String, Object?> toEquipoMap() => {
        'id': id,
        'nombre': nombre,
        'arbitroId': arbitroId,
        'descripcion': descripcion,
      };
}
