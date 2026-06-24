class Peminjaman {
  final String id;
  final String userId;
  final String bukuId;
  final DateTime tanggalPinjam;
  final DateTime tanggalKembaliTarget;
  final DateTime? tanggalKembaliAktual;
  final String status; // 'active', 'returned', 'overdue'
  final int denda;
  final String? catatan;

  Peminjaman({
    required this.id,
    required this.userId,
    required this.bukuId,
    required this.tanggalPinjam,
    required this.tanggalKembaliTarget,
    this.tanggalKembaliAktual,
    required this.status,
    this.denda = 0,
    this.catatan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'bukuId': bukuId,
      'tanggalPinjam': tanggalPinjam.toIso8601String(),
      'tanggalKembaliTarget': tanggalKembaliTarget.toIso8601String(),
      'tanggalKembaliAktual': tanggalKembaliAktual?.toIso8601String(),
      'status': status,
      'denda': denda,
      'catatan': catatan,
    };
  }

  factory Peminjaman.fromMap(Map<String, dynamic> map) {
    return Peminjaman(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      bukuId: map['bukuId'] ?? '',
      tanggalPinjam: DateTime.parse(map['tanggalPinjam'] ?? DateTime.now().toIso8601String()),
      tanggalKembaliTarget: DateTime.parse(map['tanggalKembaliTarget'] ?? DateTime.now().toIso8601String()),
      tanggalKembaliAktual: map['tanggalKembaliAktual'] != null 
          ? DateTime.parse(map['tanggalKembaliAktual']) 
          : null,
      status: map['status'] ?? 'active',
      denda: map['denda'] ?? 0,
      catatan: map['catatan'],
    );
  }

  Peminjaman copyWith({
    String? id,
    String? userId,
    String? bukuId,
    DateTime? tanggalPinjam,
    DateTime? tanggalKembaliTarget,
    DateTime? tanggalKembaliAktual,
    String? status,
    int? denda,
    String? catatan,
  }) {
    return Peminjaman(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      bukuId: bukuId ?? this.bukuId,
      tanggalPinjam: tanggalPinjam ?? this.tanggalPinjam,
      tanggalKembaliTarget: tanggalKembaliTarget ?? this.tanggalKembaliTarget,
      tanggalKembaliAktual: tanggalKembaliAktual ?? this.tanggalKembaliAktual,
      status: status ?? this.status,
      denda: denda ?? this.denda,
      catatan: catatan ?? this.catatan,
    );
  }

  bool get isOverdue {
    if (status == 'returned') return false;
    return DateTime.now().isAfter(tanggalKembaliTarget);
  }
}