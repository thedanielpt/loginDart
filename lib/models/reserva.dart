class Reserva {
  final int id;
  final int usuarioId;
  final int pistaId;
  final String fecha; // yyyy-MM-dd
  final String hora;  // HH:mm

  const Reserva({
    required this.id,
    required this.usuarioId,
    required this.pistaId,
    required this.fecha,
    required this.hora,
  });

  factory Reserva.fromMap(Map<String, Object?> map) => Reserva(
        id: map['id'] as int,
        usuarioId: map['usuarioId'] as int,
        pistaId: map['pistaId'] as int,
        fecha: map['fecha'] as String,
        hora: map['hora'] as String,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'usuarioId': usuarioId,
        'pistaId': pistaId,
        'fecha': fecha,
        'hora': hora,
      };
}
