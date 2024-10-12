import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class ServiceStatusPage extends StatefulWidget {
  @override
  _ServiceStatusPageState createState() => _ServiceStatusPageState();
}

class _ServiceStatusPageState extends State<ServiceStatusPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> services = [];

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    final data = await _dbHelper.getServices();
    setState(() {
      services = data;
    });
  }

  Future<void> _showServiceDialog({Map<String, dynamic>? service}) async {
    final TextEditingController nameController = TextEditingController(text: service?['name']);
    final TextEditingController statusController = TextEditingController(text: service?['status']);
    final TextEditingController dateController = TextEditingController(text: service?['date']);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(service == null ? 'Adicionar Serviço' : 'Editar Serviço'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nome do Serviço')),
            TextField(controller: statusController, decoration: InputDecoration(labelText: 'Status')),
            TextField(controller: dateController, decoration: InputDecoration(labelText: 'Data')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar')),
          TextButton(onPressed: () async {
            if (nameController.text.isNotEmpty && statusController.text.isNotEmpty && dateController.text.isNotEmpty) {
              if (service == null) {
                await _dbHelper.addService(nameController.text, statusController.text, dateController.text);
              } else {
                await _dbHelper.updateService(service['id'], nameController.text, statusController.text, dateController.text);
              }
              _loadServices();
              Navigator.of(context).pop();
            }
          }, child: Text('Salvar')),
        ],
      ),
    );
  }

  Future<void> _deleteService(int id) async {
    await _dbHelper.deleteService(id);
    _loadServices();
  }

  void _showServiceDetails(BuildContext context, Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(service['name']),
        content: Text('Status: ${service['status']}\nData: ${service['date']}'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Fechar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status de Serviço'),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () => _showServiceDialog())],
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text(service['name']),
              subtitle: Text('Data: ${service['date']} - Status: ${service['status']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.edit), onPressed: () => _showServiceDialog(service: service)),
                  IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteService(service['id'])),
                ],
              ),
              onTap: () => _showServiceDetails(context, service),
            ),
          );
        },
      ),
    );
  }
}
