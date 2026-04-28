import 'package:flutter/material.dart';
import 'dart:math';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('YOUR HISTORY',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
              const SizedBox(height: 32),

              // Wykres kołowy - Scentrowany kontener
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: CustomPaint(painter: ProgressPainter(0.85)),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Progress', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          Text('85%', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
              const Text('RECENT DAYS',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              const SizedBox(height: 16),

              // Poprawione paski postępu
              _buildDayBar('Monday', 3, 3, Colors.green[700]!),
              _buildDayBar('Tuesday', 2, 3, Colors.orange[700]!),
              _buildDayBar('Wednesday (Today)', 1, 3, Colors.blue[700]!),

              const SizedBox(height: 32),

              // Dolna karta - Czyste wyrównanie
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('TODAY\'S DETAILS',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 20),
                    _buildPillRow('Ibuprofen', '08:00 AM', true),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(thickness: 1.5, color: Colors.black12),
                    ),
                    _buildPillRow('Lisinopril', '02:00 PM', false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayBar(String day, int taken, int total, Color color) {
    double progress = taken / total;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 54, // Wyższy pasek
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.1),
      ),
      child: ClipRRect( // Zapewnia, że pasek nie wychodzi poza rogi
        borderRadius: BorderRadius.circular(9),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(color: color),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(day,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 15)),
                  Text('$taken/$total',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillRow(String name, String time, bool isTaken) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isTaken ? 'TAKEN' : 'PENDING',
                style: TextStyle(
                    color: isTaken ? Colors.green[800] : Colors.orange[800],
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 0.5
                )),
            const SizedBox(height: 2),
            Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        Text(time, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      ],
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;
  ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint bg = Paint()
      ..color = Colors.grey[200]!
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    Paint fg = Paint()
      ..color = Colors.black
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, bg);
    canvas.drawArc(Rect.fromLTRB(0, 0, size.width, size.height), -pi / 2, 2 * pi * progress, false, fg);
  }

  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}