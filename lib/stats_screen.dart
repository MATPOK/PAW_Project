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
              const Text('HISTORY & STATS', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
              const Text('Your weekly progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 32),

              // Karta z wykresem kołowym
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(border: Border.all(width: 2)),
                child: Column(
                  children: [
                    const Text('WEEKLY ADHERENCE', style: TextStyle(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 20),
                    // Nasz Custom Chart
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CustomPaint(painter: ProgressPainter(0.85)), // 85%
                        ),
                        const Column(
                          children: [
                            Text('85%', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900)),
                            Text('GOAL: 90%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem('TAKEN', '24', Colors.green),
                        _StatItem('MISSED', '4', Colors.red),
                        _StatItem('STREAK', '5 DAYS', Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text('PAST 7 DAYS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              const SizedBox(height: 16),
              _buildHistoryCard('MONDAY, OCT 23', '4/4 Doses Taken', true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(String date, String desc, bool success) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
              Text(desc, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: success ? Colors.green[800] : Colors.red[800],
            child: const Text('SUCCESS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

// Widget do rysowania kółka statystyk
class ProgressPainter extends CustomPainter {
  final double progress;
  ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.grey[200]!
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = Colors.green[800]!
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, backgroundPaint);
    double arcAngle = 2 * pi * progress;
    canvas.drawArc(Rect.fromLTRB(0, 0, size.width, size.height), -pi / 2, arcAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _StatItem extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatItem(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900)),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      ],
    );
  }
}