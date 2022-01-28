import 'package:boats_app/screens/home_screen.dart';
import 'package:boats_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boats App',
      home: const HomeScreen(),
      theme: AppTheme.mainTheme,
    );
  }
}
