import 'package:flutter/material.dart';
import 'medication.dart';

class MedicationManager {
  List<Medication> _medications = [];

  void addMedication(Medication medication) {
    _medications.add(medication);
  }

  void removeMedication(String id) {
    _medications.removeWhere((med) => med.id == id);
  }

  void updateMedication(String id,
      {String? name, TimeOfDay? time, double? dose}) {
    var index = _medications.indexWhere((med) => med.id == id);
    if (index != -1) {
      var medication = _medications[index];
      _medications[index] = Medication(
        id: id,
        name: name ?? medication.name,
        time: time ?? medication.time,
        dose: dose ?? medication.dose,
      );
    }
  }

  List<Medication> getAllMedications() {
    return List.from(_medications);
  }
}
