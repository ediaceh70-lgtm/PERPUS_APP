import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/buku.dart';
import '../database/db_helper.dart';

class BookProvider extends ChangeNotifier {
  final _dbHelper = DatabaseHelper();
  List<Buku> _books = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Buku> get books => _books;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadBooks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _books = await _dbHelper.getAllBooks();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load books: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchBooks(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _books = await _dbHelper.searchBooks(query);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Search failed: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBook({
    required String judul,
    required String pengarang,
    required String isbn,
    required String penerbit,
    required int tahunTerbit,
    required String kategori,
    required String deskripsi,
    required int stok,
    String? gambarUrl,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newBook = Buku(
        id: const Uuid().v4(),
        judul: judul,
        pengarang: pengarang,
        isbn: isbn,
        penerbit: penerbit,
        tahunTerbit: tahunTerbit,
        kategori: kategori,
        deskripsi: deskripsi,
        stok: stok,
        stokTersedia: stok,
        gambarUrl: gambarUrl,
        createdAt: DateTime.now(),
      );

      await _dbHelper.insertBook(newBook);
      _books.add(newBook);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to add book: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBook(Buku book) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _dbHelper.updateBook(book);
      final index = _books.indexWhere((b) => b.id == book.id);
      if (index != -1) {
        _books[index] = book;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to update book: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
}