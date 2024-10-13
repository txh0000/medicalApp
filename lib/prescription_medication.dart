import 'package:flutter/material.dart';
import 'medication.dart';

class PrescriptionMedication extends Medication {
  String prescribedBy;
  DateTime prescriptionDate;

  PrescriptionMedication({
    required String id,
    required String name,
    required TimeOfDay time,
    required double dose,
    required this.prescribedBy,
    required this.prescriptionDate,
  }) : super(id: id, name: name, time: time, dose: dose);

  @override
  String toString() {
    return '${super.toString()} - Prescribed by $prescribedBy on ${prescriptionDate.toLocal().toString().split(' ')[0]}';
  }
}
