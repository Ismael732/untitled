import 'package:flutter/material.dart';

class ReceiptsReviewsPage extends StatelessWidget {
  final List<Map<String, dynamic>> receipts = [
    {'service': 'Manutenção de Sistema', 'date': '05/10/2024', 'review': 'Excelente', 'rating': 5},
    {'service': 'Atualização de Software', 'date': '08/10/2024', 'review': 'Bom', 'rating': 4},
    {'service': 'Instalação de Servidor', 'date': '10/10/2024', 'review': 'Satisfatório', 'rating': 3},
    {'service': 'Backup de Dados', 'date': '01/10/2024', 'review': 'Excelente', 'rating': 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recibos e Avaliações'),
        backgroundColor: Colors.blue[700],
      ),
      body: ListView.builder(
        itemCount: receipts.length,
        itemBuilder: (context, index) {
          final receipt = receipts[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.receipt, color: Colors.blue),
              title: Text(receipt['service']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Data: ${receipt['date']}'),
                  Text('Avaliação: ${receipt['review']}'),
                  Row(
                    children: List.generate(5, (starIndex) {
                      return Icon(
                        starIndex < receipt['rating']
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.yellow,
                        size: 16,
                      );
                    }),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  _showReceiptDetails(context, receipt);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showReceiptDetails(BuildContext context, Map<String, dynamic> receipt) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(receipt['service']),
        content: Text(
            'Data: ${receipt['date']}\nAvaliação: ${receipt['review']}\nNota: ${receipt['rating']}/5'),
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
