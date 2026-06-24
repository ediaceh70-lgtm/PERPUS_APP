import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../widgets/custom_card.dart';

class DaftarBuku extends StatefulWidget {
  const DaftarBuku({Key? key}) : super(key: key);

  @override
  State<DaftarBuku> createState() => _DaftarBukuState();
}

class _DaftarBukuState extends State<DaftarBuku> {
  final List<Map<String, dynamic>> books = [
    {
      'judul': 'The Great Gatsby',
      'pengarang': 'F. Scott Fitzgerald',
      'kategori': 'Fiction',
      'rating': 4.5,
      'stok': 5,
      'deskripsi': 'A classic American novel set in the Jazz Age',
    },
    {
      'judul': 'To Kill a Mockingbird',
      'pengarang': 'Harper Lee',
      'kategori': 'Fiction',
      'rating': 4.7,
      'stok': 3,
      'deskripsi': 'A gripping tale of racial injustice and childhood innocence',
    },
    {
      'judul': 'The Catcher in the Rye',
      'pengarang': 'J.D. Salinger',
      'kategori': 'Fiction',
      'rating': 4.2,
      'stok': 2,
      'deskripsi': 'A story about teenage rebellion and alienation',
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredBooks = books
        .where((book) => book['judul'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Catalog'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search books...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return CustomCard(
                  onTap: () {
                    _showBookDetails(context, book);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.book,
                              color: AppColors.primary,
                              size: 40,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book['judul'],
                                  style: Theme.of(context).textTheme.titleSmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book['pengarang'],
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${book['rating']}',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text(book['kategori']),
                            backgroundColor: AppColors.primaryLight,
                          ),
                          if (book['stok'] > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${book['stok']} Available',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          else
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Not Available',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showBookDetails(BuildContext context, Map<String, dynamic> book) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              book['judul'],
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'by ${book['pengarang']}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              book['deskripsi'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: book['stok'] > 0
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Book borrowed successfully!')),
                            );
                            Navigator.pop(context);
                          }
                        : null,
                    child: const Text('Borrow'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}