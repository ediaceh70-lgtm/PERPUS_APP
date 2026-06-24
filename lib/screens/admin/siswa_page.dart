import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../widgets/custom_card.dart';

class SiswaPage extends StatefulWidget {
  const SiswaPage({Key? key}) : super(key: key);

  @override
  State<SiswaPage> createState() => _SiswaPageState();
}

class _SiswaPageState extends State<SiswaPage> {
  final List<Map<String, String>> students = [
    {'id': '1', 'name': 'Ahmad Hidayat', 'email': 'ahmad@school.com', 'class': 'X-A'},
    {'id': '2', 'name': 'Siti Nur Azizah', 'email': 'siti@school.com', 'class': 'X-B'},
    {'id': '3', 'name': 'Budi Santoso', 'email': 'budi@school.com', 'class': 'XI-A'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Students'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return CustomCard(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(student['name']![0]),
              ),
              title: Text(student['name']!),
              subtitle: Text(student['email']!),
              trailing: Chip(label: Text(student['class']!)),
            ),
          );
        },
      ),
    );
  }
}