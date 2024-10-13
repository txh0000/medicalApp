import 'package:flutter/material.dart';

class Medication {
  final String id;
  String name;
  TimeOfDay time;
  double dose;

  Medication({
    required this.id,
    required this.name,
    required this.time,
    required this.dose,
  });

  @override
  String toString() {
    // Format time without using TimeOfDay.format()
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    String hour = time.hourOfPeriod.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$name - $hour:$minute $period - ${dose}mg';
  }

  // Method to get formatted string when BuildContext is available
  String toStringWithContext(BuildContext context) {
    return '$name - ${time.format(context)} - ${dose}mg';
  }
}
