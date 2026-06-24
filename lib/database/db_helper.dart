import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/buku.dart';
import '../models/peminjaman.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'perpus_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT NOT NULL,
        phone TEXT,
        address TEXT,
        classYear TEXT,
        createdAt TEXT NOT NULL,
        isActive INTEGER NOT NULL
      )
    ''');

    // Books table
    await db.execute('''
      CREATE TABLE buku (
        id TEXT PRIMARY KEY,
        judul TEXT NOT NULL,
        pengarang TEXT NOT NULL,
        isbn TEXT NOT NULL UNIQUE,
        penerbit TEXT NOT NULL,
        tahunTerbit INTEGER NOT NULL,
        kategori TEXT NOT NULL,
        deskripsi TEXT NOT NULL,
        stok INTEGER NOT NULL,
        stokTersedia INTEGER NOT NULL,
        gambarUrl TEXT,
        rating REAL NOT NULL,
        jumlahReview INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        isAvailable INTEGER NOT NULL
      )
    ''');

    // Borrowings table
    await db.execute('''
      CREATE TABLE peminjaman (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        bukuId TEXT NOT NULL,
        tanggalPinjam TEXT NOT NULL,
        tanggalKembaliTarget TEXT NOT NULL,
        tanggalKembaliAktual TEXT,
        status TEXT NOT NULL,
        denda INTEGER NOT NULL,
        catatan TEXT,
        FOREIGN KEY (userId) REFERENCES users(id),
        FOREIGN KEY (bukuId) REFERENCES buku(id)
      )
    ''');
  }

  // User operations
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query('users', where: 'email = ?', whereArgs: [email]);
    if (maps.isEmpty) return null;
    return User.fromMap(maps.first);
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final maps = await db.query('users');
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  // Book operations
  Future<void> insertBook(Buku buku) async {
    final db = await database;
    await db.insert('buku', buku.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Buku>> getAllBooks() async {
    final db = await database;
    final maps = await db.query('buku');
    return List.generate(maps.length, (i) => Buku.fromMap(maps[i]));
  }

  Future<List<Buku>> searchBooks(String query) async {
    final db = await database;
    final maps = await db.query(
      'buku',
      where: 'judul LIKE ? OR pengarang LIKE ? OR kategori LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) => Buku.fromMap(maps[i]));
  }

  Future<void> updateBook(Buku buku) async {
    final db = await database;
    await db.update('buku', buku.toMap(), where: 'id = ?', whereArgs: [buku.id]);
  }

  // Borrowing operations
  Future<void> insertBorrowing(Peminjaman peminjaman) async {
    final db = await database;
    await db.insert('peminjaman', peminjaman.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Peminjaman>> getBorrowingsByUser(String userId) async {
    final db = await database;
    final maps = await db.query('peminjaman', where: 'userId = ?', whereArgs: [userId]);
    return List.generate(maps.length, (i) => Peminjaman.fromMap(maps[i]));
  }

  Future<List<Peminjaman>> getAllBorrowings() async {
    final db = await database;
    final maps = await db.query('peminjaman');
    return List.generate(maps.length, (i) => Peminjaman.fromMap(maps[i]));
  }

  Future<void> updateBorrowing(Peminjaman peminjaman) async {
    final db = await database;
    await db.update('peminjaman', peminjaman.toMap(), where: 'id = ?', whereArgs: [peminjaman.id]);
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}