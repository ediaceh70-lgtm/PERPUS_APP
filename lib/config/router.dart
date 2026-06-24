import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_page.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/buku_page.dart';
import 'screens/admin/siswa_page.dart';
import 'screens/admin/peminjaman_page.dart';
import 'screens/admin/laporan_page.dart';
import 'screens/siswa/siswa_dashboard.dart';
import 'screens/siswa/daftar_buku.dart';
import 'screens/siswa/riwayat_page.dart';
import 'screens/siswa/profil_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/admin_dashboard':
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
      case '/buku_page':
        return MaterialPageRoute(builder: (_) => const BukuPage());
      case '/siswa_page':
        return MaterialPageRoute(builder: (_) => const SiswaPage());
      case '/peminjaman_page':
        return MaterialPageRoute(builder: (_) => const PeminjamanPage());
      case '/laporan_page':
        return MaterialPageRoute(builder: (_) => const LaporanPage());
      case '/siswa_dashboard':
        return MaterialPageRoute(builder: (_) => const SiswaDashboard());
      case '/daftar_buku':
        return MaterialPageRoute(builder: (_) => const DaftarBuku());
      case '/riwayat_page':
        return MaterialPageRoute(builder: (_) => const RiwayatPage());
      case '/profil_page':
        return MaterialPageRoute(builder: (_) => const ProfilPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}