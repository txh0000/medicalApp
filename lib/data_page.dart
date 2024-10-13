import 'package:flutter/material.dart';
import 'medication_manager.dart';
import 'medication.dart';
import 'add_medication_dialog.dart';
import 'update_medication_dialog.dart';

class DataPage extends StatefulWidget {
  final MedicationManager medicationManager;
  final VoidCallback onLogout;

  DataPage({required this.medicationManager, required this.onLogout});

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  void _showAddMedicationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddMedicationDialog(
          onAdd: (medication) {
            setState(() {
              widget.medicationManager.addMedication(medication);
            });
            Navigator.of(context).pop(); // Close the dialog
            _showFeedback('Medication Successfully Added');
          },
        );
      },
    );
  }

  void _showUpdateMedicationDialog(Medication medication) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateMedicationDialog(
          medication: medication,
          onUpdate: (id, name, time, dose) {
            setState(() {
              widget.medicationManager
                  .updateMedication(id, name: name, time: time, dose: dose);
            });
            Navigator.of(context).pop(); // Close the dialog
            _showFeedback('Medication Successfully Updated');
          },
        );
      },
    );
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medications'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: widget.onLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.medicationManager.getAllMedications().length,
        itemBuilder: (context, index) {
          var medication = widget.medicationManager.getAllMedications()[index];
          return ListTile(
            title: Text(medication.name),
            subtitle: Text(
                '${medication.time.format(context)} - ${medication.dose}mg'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateMedicationDialog(medication),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      widget.medicationManager.removeMedication(medication.id);
                    });
                    _showFeedback('Medication Successfully Removed');
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMedicationDialog,
        child: Icon(Icons.add),
        tooltip: 'Add Medication',
      ),
    );
  }
}
