# PERPUS - Professional Library Management System

A modern, professional Flutter application for managing library operations with separate interfaces for administrators and students.

## Features

### Admin Features
- **Dashboard**: Overview of library statistics
- **Book Management**: Add, edit, and manage books
- **Student Management**: Manage student accounts
- **Borrowing Records**: Track all borrowing activities
- **Reports**: Generate library reports and analytics

### Student Features
- **Book Catalog**: Browse available books
- **Borrowing History**: View borrowing and return history
- **User Profile**: Manage personal information

## Architecture

```
lib/
├── main.dart                 # App entry point
├── config/
│   └── theme.dart           # Theme configuration
├── models/
│   ├── user.dart            # User model
│   ├── buku.dart            # Book model
│   └── peminjaman.dart      # Borrowing model
├── database/
│   └── db_helper.dart       # SQLite database helper
├── providers/
│   ├── auth_provider.dart   # Authentication state
│   ├── book_provider.dart   # Book management state
│   └── borrowing_provider.dart # Borrowing state
├── screens/
│   ├── auth/
│   │   └── login_page.dart
│   ├── admin/               # Admin screens
│   ├── siswa/               # Student screens
│   └── splash_screen.dart
└── widgets/
    ├── custom_button.dart
    └── custom_card.dart
```

## Getting Started

### Prerequisites
- Flutter 3.0+
- Dart 3.0+

### Installation

1. Clone the repository
```bash
git clone https://github.com/ediaceh70-lgtm/PERPUS_APP.git
cd PERPUS_APP
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Technologies Used

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **Database**: SQLite
- **UI**: Material Design 3
- **Typography**: Google Fonts (Poppins)
- **Charts**: FL Chart
- **Animations**: Flutter Animate

## Color Scheme

- **Primary**: Indigo (#6366F1)
- **Secondary**: Green (#10B981)
- **Accent**: Amber (#F59E0B)
- **Error**: Red (#EF4444)
- **Success**: Green (#10B981)
- **Warning**: Amber (#F59E0B)

## Database Schema

### Users Table
- id, name, email, password, role, phone, address, classYear, createdAt, isActive

### Books Table
- id, judul, pengarang, isbn, penerbit, tahunTerbit, kategori, deskripsi, stok, stokTersedia, gambarUrl, rating, jumlahReview, createdAt, isAvailable

### Borrowings Table
- id, userId, bukuId, tanggalPinjam, tanggalKembaliTarget, tanggalKembaliAktual, status, denda, catatan

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

MIT License - see LICENSE file for details

## Author

eDiaceh70
