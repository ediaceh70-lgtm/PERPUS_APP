class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String role; // 'admin' or 'siswa'
  final String? phone;
  final String? address;
  final String? classYear;
  final DateTime createdAt;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.phone,
    this.address,
    this.classYear,
    required this.createdAt,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'phone': phone,
      'address': address,
      'classYear': classYear,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? 'siswa',
      phone: map['phone'],
      address: map['address'],
      classYear: map['classYear'],
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      isActive: (map['isActive'] ?? 1) == 1,
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? role,
    String? phone,
    String? address,
    String? classYear,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      classYear: classYear ?? this.classYear,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}