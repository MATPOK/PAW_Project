import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  // Zmienne przechowujące stan przełączników
  bool isDarkMode = false;
  bool isPushEnabled = true;
  bool isVoiceEnabled = false;
  bool isLargeText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('ProfileSettings', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'PREFERENCES',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 16),

            // Generujemy nasze kafelki z przełącznikami
            _buildSettingTile('DARK MODE', 'High contrast dark...', isDarkMode, (val) => setState(() => isDarkMode = val)),
            _buildSettingTile('PUSH NOTIFICATIONS', 'Alerts for medicati...', isPushEnabled, (val) => setState(() => isPushEnabled = val)),
            _buildSettingTile('VOICE ALERTS', 'Read medication n...', isVoiceEnabled, (val) => setState(() => isVoiceEnabled = val)),
            _buildSettingTile('LARGE TEXT', 'Maximum readabili...', isLargeText, (val) => setState(() => isLargeText = val)),

            const Spacer(), // Pcha przyciski na sam dół ekranu

            // Przycisk Help
            OutlinedButton.icon(
              onPressed: () {
                // Tu dodasz logikę pomocy
              },
              icon: const Icon(Icons.check_circle, color: Colors.black),
              label: const Text('HELP & SUPPORT', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 12),

            // Przycisk Logout
            ElevatedButton.icon(
              onPressed: () {
                // Tu dodasz logikę wylogowania
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('LOGOUT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC62828), // Ciemny czerwony
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Funkcja budująca pojedynczy kafelek w czarnej ramce
  Widget _buildSettingTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}