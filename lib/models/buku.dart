class Buku {
  final String id;
  final String judul;
  final String pengarang;
  final String isbn;
  final String penerbit;
  final int tahunTerbit;
  final String kategori;
  final String deskripsi;
  final int stok;
  final int stokTersedia;
  final String? gambarUrl;
  final double rating;
  final int jumlahReview;
  final DateTime createdAt;
  final bool isAvailable;

  Buku({
    required this.id,
    required this.judul,
    required this.pengarang,
    required this.isbn,
    required this.penerbit,
    required this.tahunTerbit,
    required this.kategori,
    required this.deskripsi,
    required this.stok,
    required this.stokTersedia,
    this.gambarUrl,
    this.rating = 0.0,
    this.jumlahReview = 0,
    required this.createdAt,
    this.isAvailable = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'pengarang': pengarang,
      'isbn': isbn,
      'penerbit': penerbit,
      'tahunTerbit': tahunTerbit,
      'kategori': kategori,
      'deskripsi': deskripsi,
      'stok': stok,
      'stokTersedia': stokTersedia,
      'gambarUrl': gambarUrl,
      'rating': rating,
      'jumlahReview': jumlahReview,
      'createdAt': createdAt.toIso8601String(),
      'isAvailable': isAvailable ? 1 : 0,
    };
  }

  factory Buku.fromMap(Map<String, dynamic> map) {
    return Buku(
      id: map['id'] ?? '',
      judul: map['judul'] ?? '',
      pengarang: map['pengarang'] ?? '',
      isbn: map['isbn'] ?? '',
      penerbit: map['penerbit'] ?? '',
      tahunTerbit: map['tahunTerbit'] ?? 0,
      kategori: map['kategori'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      stok: map['stok'] ?? 0,
      stokTersedia: map['stokTersedia'] ?? 0,
      gambarUrl: map['gambarUrl'],
      rating: (map['rating'] ?? 0.0).toDouble(),
      jumlahReview: map['jumlahReview'] ?? 0,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      isAvailable: (map['isAvailable'] ?? 1) == 1,
    );
  }

  Buku copyWith({
    String? id,
    String? judul,
    String? pengarang,
    String? isbn,
    String? penerbit,
    int? tahunTerbit,
    String? kategori,
    String? deskripsi,
    int? stok,
    int? stokTersedia,
    String? gambarUrl,
    double? rating,
    int? jumlahReview,
    DateTime? createdAt,
    bool? isAvailable,
  }) {
    return Buku(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      pengarang: pengarang ?? this.pengarang,
      isbn: isbn ?? this.isbn,
      penerbit: penerbit ?? this.penerbit,
      tahunTerbit: tahunTerbit ?? this.tahunTerbit,
      kategori: kategori ?? this.kategori,
      deskripsi: deskripsi ?? this.deskripsi,
      stok: stok ?? this.stok,
      stokTersedia: stokTersedia ?? this.stokTersedia,
      gambarUrl: gambarUrl ?? this.gambarUrl,
      rating: rating ?? this.rating,
      jumlahReview: jumlahReview ?? this.jumlahReview,
      createdAt: createdAt ?? this.createdAt,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
