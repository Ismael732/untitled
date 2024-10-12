import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agendar Serviço')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDateField(context),
            _buildTimeField(context),
            _buildDescriptionField(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showConfirmationDialog(context),
              child: Text('Confirmar Agendamento'),
            ),
          ],
        ),
      ),
    );
  }

  TextField _buildDateField(BuildContext context) {
    return TextField(
      controller: _dateController,
      decoration: InputDecoration(labelText: 'Data', icon: Icon(Icons.calendar_today)),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2021),
          lastDate: DateTime(2030),
        );
        if (pickedDate != null) {
          setState(() {
            _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          });
        }
      },
    );
  }

  TextField _buildTimeField(BuildContext context) {
    return TextField(
      controller: _timeController,
      decoration: InputDecoration(labelText: 'Hora', icon: Icon(Icons.access_time)),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
        if (pickedTime != null) {
          setState(() {
            _timeController.text = "${pickedTime.hour}:${pickedTime.minute}";
          });
        }
      },
    );
  }

  TextField _buildDescriptionField() {
    return TextField(
      controller: _descriptionController,
      decoration: InputDecoration(labelText: 'Descrição do Serviço', icon: Icon(Icons.description)),
      maxLines: 3,
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmação'),
        content: Text('Agendamento confirmado com sucesso!'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK')),
        ],
      ),
    );
  }
}
