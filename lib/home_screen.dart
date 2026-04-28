import 'package:flutter/material.dart';
import 'main_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nagłówek
              const Text(
                'PILL4U',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                  color: Colors.black,
                ),
              ),
              const Text(
                'TODAY OCT 24', // Docelowo podepniemy tu aktualną datę z systemu
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),

              // Lista leków (scrollowana, gdy będzie ich więcej)
              Expanded(
                child: ListView(
                  children: [
                    _buildPillCard('08:00 AM', 'Lisinopril', '20mg'),
                    const SizedBox(height: 24),
                    _buildPillCard('12:30 PM', 'Metformin', '500mg'),
                    const SizedBox(height: 24),
                    _buildPillCard('06:00 PM', 'Atorvastatin', '40mg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Funkcja generująca pojedynczy kafelek leku (żeby nie pisać tego samego 3 razy)
  Widget _buildPillCard(String time, String name, String dose) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.zero, // Surowy, kwadratowy styl z makiety
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black),
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  dose,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              // Przycisk "Wzięte" (Niebieski)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    print('Wzięto $name');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: const Icon(Icons.check_circle, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(width: 16),
              // Przycisk "Pominięte" (Czerwony)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    print('Pominięto $name');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C), // Ciemny czerwony
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: const Icon(Icons.cancel, color: Colors.white, size: 28),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}