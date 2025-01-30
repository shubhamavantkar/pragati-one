import 'package:flutter/material.dart';

class ETenderScreen extends StatelessWidget {
  const ETenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Tender'),
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('E-Tender Screen', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
