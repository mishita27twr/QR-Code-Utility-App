import 'package:flutter/material.dart';
import 'home_page.dart';

// 1. We create this notifier outside the class so it can be accessed from any file
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Wrap MaterialApp with ValueListenableBuilder to "listen" for theme changes
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'QR Utility',
          debugShowCheckedModeBanner: false,
          
          // Light Theme (Kept your exact colors)
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF7C3AED),
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            fontFamily: 'Roboto',
          ),
          
          // Dark Theme (Kept your exact colors)
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF7C3AED),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            fontFamily: 'Roboto',
          ),
          
          // 3. Use the value from the notifier here
          themeMode: currentMode, 
          
          home: const HomePage(),
        );
      },
    );
  }
}