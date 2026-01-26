import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/loginScreen.dart';
import 'navegator/navegation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // necesario para usar await
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      initialRoute: "/",
      routes: Navegation.routes,
    );
  }
}
