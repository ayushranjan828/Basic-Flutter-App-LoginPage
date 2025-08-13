import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/picsum_repository.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PicsumRepository _picsumRepo = PicsumRepository();
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _picsumRepo,
      child: MaterialApp(
        title: 'Picsum Advanced',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => SplashScreen(),
          '/login': (_) => LoginScreen(),
          '/home': (_) => HomeScreen(),
        },
      ),
    );
  }
}
