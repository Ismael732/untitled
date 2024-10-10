import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 2, // Incrementar a versão do banco de dados
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Adicionar tratamento para atualizações do banco de dados
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Criação da tabela de usuários
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');

    // Criação da tabela de contatos
    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        email TEXT
      )
    ''');

    // Criação da tabela de serviços
    await db.execute('''
      CREATE TABLE services(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        status TEXT,
        date TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Criação da tabela de serviços quando a versão é atualizada para 2
      await db.execute('''
        CREATE TABLE services(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          status TEXT,
          date TEXT
        )
      ''');
    }
  }

  // Métodos para a tabela de usuários (já existentes)

  Future<int> saveUser(String username, String password) async {
    final db = await database;
    return await db.insert('users', {'username': username, 'password': password});
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // Métodos para a tabela de contatos

  Future<int> addContact(String name, String phone, String email) async {
    final db = await database;
    return await db.insert('contacts', {'name': name, 'phone': phone, 'email': email});
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await database;
    return await db.query('contacts');
  }

  Future<int> updateContact(int id, String name, String phone, String email) async {
    final db = await database;
    return await db.update('contacts', {'name': name, 'phone': phone, 'email': email}, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  // Métodos para a tabela de serviços

  Future<int> addService(String name, String status, String date) async {
    final db = await database;
    return await db.insert('services', {'name': name, 'status': status, 'date': date});
  }

  Future<List<Map<String, dynamic>>> getServices() async {
    final db = await database;
    return await db.query('services');
  }

  Future<int> updateService(int id, String name, String status, String date) async {
    final db = await database;
    return await db.update('services', {'name': name, 'status': status, 'date': date}, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteService(int id) async {
    final db = await database;
    return await db.delete('services', where: 'id = ?', whereArgs: [id]);
  }
}
