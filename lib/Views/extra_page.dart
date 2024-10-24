import 'package:flutter/material.dart';

class Extrapage extends StatefulWidget {
  const Extrapage({super.key});

  @override
  State<Extrapage> createState() => _ExtrapageState();
}

class _ExtrapageState extends State<Extrapage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          children: [Text("Extra Page")],
        ),
      ),
    );
  }
}
