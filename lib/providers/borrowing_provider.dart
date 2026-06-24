import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/peminjaman.dart';
import '../database/db_helper.dart';

class BorrowingProvider extends ChangeNotifier {
  final _dbHelper = DatabaseHelper();
  List<Peminjaman> _borrowings = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Peminjaman> get borrowings => _borrowings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAllBorrowings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _borrowings = await _dbHelper.getAllBorrowings();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load borrowings: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUserBorrowings(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _borrowings = await _dbHelper.getBorrowingsByUser(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load borrowings: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createBorrowing({
    required String userId,
    required String bukuId,
    int daysToReturn = 7,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final now = DateTime.now();
      final peminjaman = Peminjaman(
        id: const Uuid().v4(),
        userId: userId,
        bukuId: bukuId,
        tanggalPinjam: now,
        tanggalKembaliTarget: now.add(Duration(days: daysToReturn)),
        status: 'active',
      );

      await _dbHelper.insertBorrowing(peminjaman);
      _borrowings.add(peminjaman);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to create borrowing: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> returnBook(String peminjamanId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final index = _borrowings.indexWhere((p) => p.id == peminjamanId);
      if (index != -1) {
        final updated = _borrowings[index].copyWith(
          status: 'returned',
          tanggalKembaliAktual: DateTime.now(),
        );
        await _dbHelper.updateBorrowing(updated);
        _borrowings[index] = updated;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to return book: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
}