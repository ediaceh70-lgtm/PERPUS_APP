import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../widgets/custom_card.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final List<Map<String, String>> history = [
    {
      'judul': 'The Great Gatsby',
      'tanggalPinjam': '2026-06-01',
      'tanggalKembali': '2026-06-15',
      'status': 'Returned',
    },
    {
      'judul': 'To Kill a Mockingbird',
      'tanggalPinjam': '2026-05-15',
      'tanggalKembali': '2026-05-30',
      'status': 'Returned',
    },
    {
      'judul': 'The Catcher in the Rye',
      'tanggalPinjam': '2026-04-20',
      'tanggalKembali': '2026-05-05',
      'status': 'Returned',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrowing History'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final record = history[index];
          return CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        record['judul']!,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        record['status']!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Borrowed', style: Theme.of(context).textTheme.bodySmall),
                          Text(record['tanggalPinjam']!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Returned', style: Theme.of(context).textTheme.bodySmall),
                          Text(record['tanggalKembali']!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}