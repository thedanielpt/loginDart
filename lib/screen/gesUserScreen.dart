import 'package:flutter/material.dart';

class GesUserScreen extends StatefulWidget {
  const GesUserScreen({super.key});

  @override
  State<GesUserScreen> createState() => _GesUserScreenState();
}

class _GesUserScreenState extends State<GesUserScreen> {

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/rafa.png'),
          fit: BoxFit.cover,
        ),
      ),

    );
  }

}