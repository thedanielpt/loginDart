import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/UserProvider.dart';

class AdminUserModificarCrearScreen extends StatefulWidget {
  final String accion; // "crear" o "modificar" (o lo que uses)

  const AdminUserModificarCrearScreen({
    super.key,
    required this.accion,
  });

  @override
  State<AdminUserModificarCrearScreen> createState() =>
      _AdminUserModificarCrearScreenState();
}

class _AdminUserModificarCrearScreenState
    extends State<AdminUserModificarCrearScreen> {
  final TextEditingController _nombreController = TextEditingController();

  // ✅ Solo para CREAR
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePass = true;

  String? _rolSeleccionado;
  bool _initialized = false;
  bool _saving = false;

  bool get isCrear => widget.accion.toLowerCase() == "crear";

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();      // ✅
    _passwordController.dispose();   // ✅
    super.dispose();
  }

  Future<void> _guardar() async {
    if (_saving) return;

    final provider = context.read<UserProvider>();

    final nombre = _nombreController.text.trim();
    final rol = _rolSeleccionado;

    if (nombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("El nombre no puede estar vacío")),
      );
      return;
    }
    if (rol == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona un rol")),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      if (isCrear) {
        // ✅ CREAR
        final email = _emailController.text.trim();
        final pass = _passwordController.text;

        if (email.isEmpty || !email.contains("@")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email inválido")),
          );
          return;
        }
        if (pass.length < 6) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("La contraseña debe tener al menos 6 caracteres")),
          );
          return;
        }

        await provider.crearUsuario(email: email, password: pass, nombre: nombre, rol: rol);

      } else {
        // ✅ MODIFICAR (tu lógica)
        final u = provider.user;
        if (u == null) return;

        final id = u.id;
        if (id == null || id.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error: el usuario no tiene id (docId)")),
          );
          return;
        }

        await provider.modificarUsuario(id, nombre, rol);
      }

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, "/usuariosAdmin");
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se pudo guardar: $e")),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final u = provider.user;

    // ✅ Inicialización SOLO si es modificar
    if (!isCrear && u != null && !_initialized) {
      _nombreController.text = u.nombre;
      _rolSeleccionado = ["Admin", "Jugador", "Arbitro", "Entrenador"].contains(u.rol)
          ? u.rol
          : "Jugador";
      _initialized = true;
    }

    // ✅ En crear NO necesitas esperar user
    if (!isCrear && (provider.isLoading || u == null)) {
      return const Scaffold(
        backgroundColor: Color(0xFF1A1A40),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    final titulo = isCrear ? "Crear Usuario" : "Modificar Usuario";
    final textoBoton = isCrear ? "Crear" : "Guardar Cambios";

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/rafa.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: const Color(0xFF0F0F2D)),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.8)
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 500),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: const Color(0xCC1A1A40),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const Divider(color: Colors.white24, height: 40),

                      // ✅ SI CREAR: email + password editables
                      if (isCrear) ...[
                        const Text("Correo electrónico (usuario)",
                            style: TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          enabled: !_saving,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                            prefixIcon: const Icon(Icons.email_outlined,
                                color: Colors.white70),
                          ),
                        ),
                        const SizedBox(height: 16),

                        const Text("Contraseña",
                            style: TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          enabled: !_saving,
                          obscureText: _obscurePass,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Colors.white70),
                            suffixIcon: IconButton(
                              onPressed: _saving
                                  ? null
                                  : () => setState(() => _obscurePass = !_obscurePass),
                              icon: Icon(
                                _obscurePass ? Icons.visibility_off : Icons.visibility,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ] else ...[
                        // ✅ SI MODIFICAR: email fijo como lo tenías
                        const Text("Correo electrónico",
                            style: TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 8),
                        Text(
                          u!.email,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 24),
                      ],

                      const Text("Nombre completo",
                          style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nombreController,
                        enabled: !_saving,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.05),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(Icons.person_outline,
                              color: Colors.white70),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text("Rol de usuario",
                          style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _rolSeleccionado ?? "Jugador",
                            isExpanded: true,
                            dropdownColor: const Color(0xFF1A1A40),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.white70),
                            items: ["Admin", "Jugador", "Arbitro", "Entrenador"]
                                .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                                .toList(),
                            onChanged: _saving
                                ? null
                                : (newValue) =>
                                setState(() => _rolSeleccionado = newValue),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _saving ? null : _guardar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3D3D70),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: _saving
                              ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                              : Text(textoBoton,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: _saving
                              ? null
                              : () => Navigator.pushReplacementNamed(
                              context, "/usuariosAdmin"),
                          child: const Text("Volver",
                              style: TextStyle(color: Colors.white54)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}