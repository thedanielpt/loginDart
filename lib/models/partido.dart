class Partido {
  final int id;
  final int arbitroId;
  final int equipo1Id;
  final int equipo2Id;
  final int reservaId;

  const Partido({
    required this.id,
    required this.arbitroId,
    required this.equipo1Id,
    required this.equipo2Id,
    required this.reservaId,
  });

  factory Partido.fromMap(Map<String, Object?> map) => Partido(
        id: map['id'] as int,
        arbitroId: map['arbitroId'] as int,
        equipo1Id: map['equipo1Id'] as int,
        equipo2Id: map['equipo2Id'] as int,
        reservaId: map['reservaId'] as int,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'arbitroId': arbitroId,
        'equipo1Id': equipo1Id,
        'equipo2Id': equipo2Id,
        'reservaId': reservaId,
      };
}
