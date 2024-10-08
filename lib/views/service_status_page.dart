import 'package:flutter/material.dart';

class ServiceStatusPage extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {'name': 'Manutenção de Sistema', 'status': 'Concluído', 'date': '05/10/2024'},
    {'name': 'Atualização de Software', 'status': 'Em andamento', 'date': '08/10/2024'},
    {'name': 'Instalação de Servidor', 'status': 'Pendente', 'date': '10/10/2024'},
    {'name': 'Backup de Dados', 'status': 'Concluído', 'date': '01/10/2024'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status de Serviço'),
        backgroundColor: Colors.blue[700],
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Card(
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
              ),
              title: Text(service['name']),
              subtitle: Text('Data: ${service['date']} - Status: ${service['status']}'),
              trailing: IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  _showServiceDetails(context, service);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showServiceDetails(BuildContext context, Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(service['name']),
        content: Text(
            'Status: ${service['status']}\nData: ${service['date']}\n\nDetalhes sobre o serviço podem ser adicionados aqui.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
