import 'package:flutter/material.dart';
import '../screen/loginScreen.dart';
import '../screen/passwordForgetScreen.dart';
import '../screen/registroScreen.dart';

class Navegation {
  static final routes = <String, WidgetBuilder>{
    "/": (context) => LoginScreen(),
    "/gesUser": (context) => LoginScreen(),
    "/registro": (context) => RegistroScreen(),
    "/passwordForgetScreen": (context) => PasswordForgetScreen(),
  };
}
