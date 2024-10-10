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

  void _loadServices() async {
    final data = await _dbHelper.getServices();
    setState(() {
      services = data;
    });
  }

  void _addService() async {
    String name = '';
    String status = '';
    String date = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar Serviço'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nome do Serviço'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Status'),
              onChanged: (value) => status = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Data'),
              onChanged: (value) => date = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (name.isNotEmpty && status.isNotEmpty && date.isNotEmpty) {
                await _dbHelper.addService(name, status, date);
                _loadServices();
                Navigator.of(context).pop();
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _editService(int id, String currentName, String currentStatus, String currentDate) async {
    String name = currentName;
    String status = currentStatus;
    String date = currentDate;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Serviço'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nome do Serviço'),
              onChanged: (value) => name = value,
              controller: TextEditingController(text: currentName),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Status'),
              onChanged: (value) => status = value,
              controller: TextEditingController(text: currentStatus),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Data'),
              onChanged: (value) => date = value,
              controller: TextEditingController(text: currentDate),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (name.isNotEmpty && status.isNotEmpty && date.isNotEmpty) {
                await _dbHelper.updateService(id, name, status, date);
                _loadServices();
                Navigator.of(context).pop();
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _deleteService(int id) async {
    await _dbHelper.deleteService(id);
    _loadServices();
  }

  void _showServiceDetails(BuildContext context, Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(
          service['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
        ),
        content: Text(
          'Status: ${service['status']}\nData: ${service['date']}\n\nDetalhes sobre o serviço podem ser adicionados aqui.',
          style: TextStyle(color: Colors.blueGrey),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text(
              'Fechar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Status de Serviço',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addService,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    service['status'] == 'Concluído'
                        ? Icons.check_circle
                        : service['status'] == 'Em andamento'
                        ? Icons.hourglass_empty
                        : Icons.pending,
                    color: service['status'] == 'Concluído'
                        ? Colors.green
                        : service['status'] == 'Em andamento'
                        ? Colors.orange
                        : Colors.red,
                    size: 40.0,
                  ),
                  title: Text(
                    service['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.blue[900],
                    ),
                  ),
                  subtitle: Text(
                    'Data: ${service['date']} - Status: ${service['status']}',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue[700]),
                        onPressed: () {
                          _editService(service['id'], service['name'], service['status'], service['date']);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteService(service['id']);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    _showServiceDetails(context, service);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
