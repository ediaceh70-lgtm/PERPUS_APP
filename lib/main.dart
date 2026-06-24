import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
import 'config/router.dart';
import 'providers/auth_provider.dart';
import 'providers/book_provider.dart';
import 'providers/borrowing_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PerpusApp());
}

class PerpusApp extends StatelessWidget {
  const PerpusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => BorrowingProvider()),
      ],
      child: MaterialApp(
        title: 'Perpus - Library Management',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}