class Validators {
  Validators._();

  static String? required(String? value, {String message = "Campo obligatorio"}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return "Introduce un email";
    final v = value.trim();
    // validación simple (suficiente para apps de clase)
    if (!v.contains("@") || !v.contains(".")) return "Email inválido";
    return null;
  }
}
