import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/book_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';

class BukuPage extends StatefulWidget {
  const BukuPage({Key? key}) : super(key: key);

  @override
  State<BukuPage> createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  late TextEditingController judulController;
  late TextEditingController pengarangController;
  late TextEditingController isbnController;
  late TextEditingController penerbitController;
  late TextEditingController tahunController;
  late TextEditingController kategoriController;
  late TextEditingController deskripsiController;
  late TextEditingController stokController;

  @override
  void initState() {
    super.initState();
    judulController = TextEditingController();
    pengarangController = TextEditingController();
    isbnController = TextEditingController();
    penerbitController = TextEditingController();
    tahunController = TextEditingController();
    kategoriController = TextEditingController();
    deskripsiController = TextEditingController();
    stokController = TextEditingController();
    context.read<BookProvider>().loadBooks();
  }

  @override
  void dispose() {
    judulController.dispose();
    pengarangController.dispose();
    isbnController.dispose();
    penerbitController.dispose();
    tahunController.dispose();
    kategoriController.dispose();
    deskripsiController.dispose();
    stokController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Books'),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, _) {
          return bookProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: bookProvider.books.map((book) {
                    return CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.judul,
                                      style: Theme.of(context).textTheme.titleMedium,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      book.pengarang,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: book.stokTersedia > 0
                                      ? AppColors.success.withOpacity(0.1)
                                      : AppColors.error.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${book.stokTersedia} / ${book.stok}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: book.stokTersedia > 0 ? AppColors.success : AppColors.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Chip(label: Text(book.kategori)),
                              const SizedBox(width: 8),
                              Chip(label: Text('${book.tahunTerbit}')),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  text: 'Edit',
                                  onPressed: () => _showEditDialog(context, book),
                                  isOutlined: true,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: CustomButton(
                                  text: 'Delete',
                                  onPressed: () {},
                                  isOutlined: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Book'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: judulController, decoration: const InputDecoration(labelText: 'Judul')),
              TextField(controller: pengarangController, decoration: const InputDecoration(labelText: 'Pengarang')),
              TextField(controller: isbnController, decoration: const InputDecoration(labelText: 'ISBN')),
              TextField(controller: penerbitController, decoration: const InputDecoration(labelText: 'Penerbit')),
              TextField(controller: tahunController, decoration: const InputDecoration(labelText: 'Tahun')),
              TextField(controller: kategoriController, decoration: const InputDecoration(labelText: 'Kategori')),
              TextField(controller: deskripsiController, decoration: const InputDecoration(labelText: 'Deskripsi')),
              TextField(controller: stokController, decoration: const InputDecoration(labelText: 'Stok')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              context.read<BookProvider>().addBook(
                judul: judulController.text,
                pengarang: pengarangController.text,
                isbn: isbnController.text,
                penerbit: penerbitController.text,
                tahunTerbit: int.tryParse(tahunController.text) ?? 2024,
                kategori: kategoriController.text,
                deskripsi: deskripsiController.text,
                stok: int.tryParse(stokController.text) ?? 0,
              );
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, book) {
    judulController.text = book.judul;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Book'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: judulController, decoration: const InputDecoration(labelText: 'Judul')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Save')),
        ],
      ),
    );
  }
}