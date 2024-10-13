import 'package:flutter/material.dart';
import 'medication.dart';

class AddMedicationDialog extends StatefulWidget {
  final Function(Medication) onAdd;

  AddMedicationDialog({required this.onAdd});

  @override
  _AddMedicationDialogState createState() => _AddMedicationDialogState();
}

class _AddMedicationDialogState extends State<AddMedicationDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  TimeOfDay _time = TimeOfDay.now();
  double _dose = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Medication'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Medication Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Dose (mg)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a dose';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onSaved: (value) => _dose = double.parse(value!),
            ),
            ElevatedButton(
              child: Text('Select Time'),
              onPressed: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  setState(() {
                    _time = selectedTime;
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onAdd(Medication(
                id: DateTime.now().toString(),
                name: _name,
                time: _time,
                dose: _dose,
              ));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
