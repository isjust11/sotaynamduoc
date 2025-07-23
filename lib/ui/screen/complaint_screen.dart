import 'package:flutter/material.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gửi khiếu nại')),
      body: const Center(
        child: Text('Complaint Screen'),
      ),
    );
  }
} 