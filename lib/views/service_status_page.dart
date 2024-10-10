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
        title: Text(
          'Status de Serviço',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
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
                  trailing: IconButton(
                    icon: Icon(Icons.info, color: Colors.blue[700]),
                    onPressed: () {
                      _showServiceDetails(context, service);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
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
}
