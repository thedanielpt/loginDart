class User {
  String nombre;
  String rol;

  User({
    required this.nombre,
    required this.rol
  });

  // Convertir de Firestore a objeto
  factory User.fromFirestore(Map<String, dynamic> data, String id) {
    return User(
      nombre: data['nombre'] ?? '',
      rol: data['rol'] ?? '',
    );
  }

  // Convertir de objeto a Firestore
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'rol': rol,
    };
  }
}
