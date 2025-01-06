import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Avatar Creator'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text('Home Screen'),
      ),
    );
  }
}