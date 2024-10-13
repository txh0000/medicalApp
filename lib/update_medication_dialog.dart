import 'package:flutter/material.dart';
import 'medication.dart';

class UpdateMedicationDialog extends StatefulWidget {
  final Medication medication;
  final Function(String, String, TimeOfDay, double) onUpdate;

  UpdateMedicationDialog({required this.medication, required this.onUpdate});

  @override
  _UpdateMedicationDialogState createState() => _UpdateMedicationDialogState();
}

class _UpdateMedicationDialogState extends State<UpdateMedicationDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late TimeOfDay _time;
  late double _dose;

  @override
  void initState() {
    super.initState();
    _name = widget.medication.name;
    _time = widget.medication.time;
    _dose = widget.medication.dose;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Medication'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name,
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
              initialValue: _dose.toString(),
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
              child: Text('Select Time (Current: ${_time.format(context)})'),
              onPressed: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: _time,
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
          child: Text('Update'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onUpdate(widget.medication.id, _name, _time, _dose);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
