import 'package:flutter/material.dart';

import '../screen/loginScreen.dart';
import '../screen/registroScreen.dart';
import '../screen/passwordForgetScreen.dart';

import '../screen/admin/dashboard.dart';
import '../screen/admin/adminUsers/gesUserScreen.dart';
import '../screen/admin/adminUsers/AdminUserModificarCrearScreen.dart';

import '../screen/admin/adminPistas/gesPistasScreen.dart';
import '../screen/admin/adminPartidos/gesPartidosScreen.dart';
import '../screen/admin/adminEquipos/gesEquiposScreen.dart';
import '../screen/admin/AdminReservas/gesReservasScreen.dart';

import '../screen/usuarios/home.dart';

class Navegation {
  static final routes = <String, WidgetBuilder>{
    "/": (context) => LoginScreen(),
    "/registro": (context) => RegistroScreen(),
    "/passwordForgetScreen": (context) => PasswordForgetScreen(),

    "/admin": (context) => DashboardScreen(),

    "/usuariosAdmin": (context) => const AdminUserScreen(),

    "/usuariosAdminModificar": (context) =>
    const AdminUserModificarCrearScreen(accion: "Modificar"),

    "/usuariosAdminCrear": (context) =>
    const AdminUserModificarCrearScreen(accion: "Crear"),

    "/PartidosAdmin": (context) => AdminPartidosScreen(),
    "/PistasAdmin": (context) => AdminPistasScreen(),
    "/EquiposAdmin": (context) => AdminEquiposScreen(),
    "/ReservasAdmin": (context) => AdminReservasScreen(),

    "/homeUsers": (context) => HomeScreenUsers(),
  };
}