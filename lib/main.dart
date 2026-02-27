import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fluter_maricarmen/provider/UserProvider.dart';
import 'firebase_options.dart';
import 'navegator/navegation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Navegation.routes,
      initialRoute: "/admin",
      debugShowCheckedModeBanner: false,
    );
  }
}