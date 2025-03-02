import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double gpa;

  const ResultScreen({super.key, required this.gpa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPA Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your GPA is:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              gpa.toStringAsFixed(2),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Calculate Again'),
            ),
          ],
        ),
      ),
    );
  }
}

