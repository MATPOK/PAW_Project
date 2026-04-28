import 'package:flutter/material.dart';

class Medication {
  final String name;
  final String dosage;
  final String time;
  bool isTaken;
  bool isMissed;

  Medication({
    required this.name,
    required this.dosage,
    required this.time,
    this.isTaken = false,
    this.isMissed = false,
  });
}