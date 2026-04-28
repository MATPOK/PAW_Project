import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_settings.dart';
import 'add_medication_screen.dart';
import 'stats_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // Lista ekranów przypisana do zakładek
  final List<Widget> _screens = [
    const HomeScreen(), // Zakładka 0: HOME
    const StatsScreen(),
    const ProfileSettings(), // Zakładka 2: USER (Gotowe ustawienia)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex], // Wyświetla aktywny ekran

      // Dodajemy przycisk "+" tylko na ekranie HOME
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          // Otwieramy ekran dodawania jako nową stronę
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMedicationScreen()),
          );
        },
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      )
          : null,

      // Czarny pasek nawigacji z makiety
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Przełącza zakładki po kliknięciu
          });
        },
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        type: BottomNavigationBarType.fixed, // Zapobiega dziwnym animacjom ikon
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'STATS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'USER',
          ),
        ],
      ),
    );
  }
}