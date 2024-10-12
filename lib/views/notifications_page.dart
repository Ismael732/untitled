import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificações'),
        backgroundColor: Colors.blue[700],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue[700]),
            title: Text('Notificação 1'),
            subtitle: Text('Detalhes da notificação 1.'),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue[700]),
            title: Text('Notificação 2'),
            subtitle: Text('Detalhes da notificação 2.'),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue[700]),
            title: Text('Notificação 3'),
            subtitle: Text('Detalhes da notificação 3.'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
