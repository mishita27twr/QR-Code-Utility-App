import 'package:flutter/material.dart';
import 'qr_generator.dart';
import 'qr_scanner.dart';
import 'history_page.dart';
import 'main.dart'; // Ensure this is imported to access themeNotifier

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    QRGeneratorPage(),
    QRScannerPage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.qr_code_2_rounded,
                color: colorScheme.onPrimary,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'QR Utility',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // ACTUAL TOGGLE LOGIC:
              // If it's dark, switch to light. Otherwise, switch to dark.
              if (themeNotifier.value == ThemeMode.dark) {
                themeNotifier.value = ThemeMode.light;
              } else {
                themeNotifier.value = ThemeMode.dark;
              }
            },
            icon: Icon(
              // The icon changes based on the CURRENT brightness of the app
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.qr_code_rounded),
            selectedIcon: Icon(Icons.qr_code_rounded),
            label: 'Generate',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner_rounded),
            selectedIcon: Icon(Icons.qr_code_scanner_rounded),
            label: 'Scan',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_rounded),
            selectedIcon: Icon(Icons.history_rounded),
            label: 'History',
          ),
        ],
      ),
    );
  }
}