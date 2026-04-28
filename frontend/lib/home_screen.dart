import 'package:flutter/material.dart';
import 'medication_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Medication> myMedications = [
    Medication(name: 'Lisinopril', dosage: '20mg', time: '08:00 AM'),
    Medication(name: 'Metformin', dosage: '500mg', time: '12:30 PM'),
    Medication(name: 'Atorvastatin', dosage: '40mg', time: '06:00 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    int takenCount = myMedications.where((m) => m.isTaken).length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('PILL4U', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900)),
                  Text('$takenCount/${myMedications.length}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
              const Text('TODAY OCT 24', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: myMedications.length,
                  itemBuilder: (context, index) {
                    return _buildPillCard(myMedications[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPillCard(Medication med) {
    Color cardColor = Colors.black;
    if (med.isTaken) cardColor = Colors.green[700]!;
    if (med.isMissed) cardColor = Colors.red[700]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: cardColor, width: med.isTaken || med.isMissed ? 4.0 : 2.0),
        color: med.isTaken ? Colors.green[50] : (med.isMissed ? Colors.red[50] : Colors.white),
        borderRadius: BorderRadius.circular(12), // Dodane zaokrąglenie
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(med.time, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
              if (med.isTaken) const Icon(Icons.check_circle, color: Colors.green, size: 30),
            ],
          ),
          Text(med.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          if (!med.isTaken && !med.isMissed)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => med.isTaken = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Dodane zaokrąglenie
                    ),
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => med.isMissed = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[900],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Dodane zaokrąglenie
                    ),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ],
            )
          else
            TextButton(
              onPressed: () => setState(() { med.isTaken = false; med.isMissed = false; }),
              child: const Text('UNDO ACTION', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}