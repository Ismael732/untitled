import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Map<String, dynamic>> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
    final data = await _dbHelper.getContacts();
    setState(() {
      _contacts = data;
    });
  }

  void _addContact() async {
    String name = '';
    String phone = '';
    String email = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Novo Contato'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nome'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Telefone'),
              onChanged: (value) => phone = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) => email = value,
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
              if (name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty) {
                await _dbHelper.addContact(name, phone, email);
                _loadContacts();
                Navigator.of(context).pop();
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _editContact(int id, String currentName, String currentPhone, String currentEmail) async {
    String name = currentName;
    String phone = currentPhone;
    String email = currentEmail;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Contato'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nome'),
              onChanged: (value) => name = value,
              controller: TextEditingController(text: currentName),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Telefone'),
              onChanged: (value) => phone = value,
              controller: TextEditingController(text: currentPhone),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) => email = value,
              controller: TextEditingController(text: currentEmail),
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
              if (name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty) {
                await _dbHelper.updateContact(id, name, phone, email);
                _loadContacts();
                Navigator.of(context).pop();
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _deleteContact(int id) async {
    await _dbHelper.deleteContact(id);
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addContact,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            title: Text(contact['name']),
            subtitle: Text('${contact['phone']} • ${contact['email']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editContact(contact['id'], contact['name'], contact['phone'], contact['email']);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteContact(contact['id']);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
