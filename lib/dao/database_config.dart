import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConfig {
  static final _instance = DatabaseConfig._internal();

  Database? _database;

  factory DatabaseConfig() {
    return _instance;
  }

  DatabaseConfig._internal();

  Future<Database> getDatabase() async {
    if(_database != null) return _database!;

    return _database = await openDatabase(
      join(await getDatabasesPath(), 'my_money.db'),
      version: 1,
      onCreate: _onCreateDatabase,
      onUpgrade: _onUpgradeDatabase
    );
  }

  Future _onCreateDatabase(Database db, int version) async {
    db.execute('CREATE TABLE IF NOT EXISTS tb_settings(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, uuid_logged TEXT, token TEXT, uuid_instalation TEXT NOT NULL, app_version TEXT NOT NULL);');
    db.execute('CREATE TABLE IF NOT EXISTS tb_account_type(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, active INTEGER NOT NULL, uuid TEXT NOT NULL, last_update TEXT NOT NULL, sync_release INTEGER NOT NULL);');
    db.execute('CREATE TABLE IF NOT EXISTS tb_account(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, type_id INTEGER NOT NULL, initial_value REAL NOT NULL, uuid TEXT NOT NULL, user_id TEXT NOT NULL, last_update TEXT NOT NULL, sync_release INTEGER NOT NULL,'
        ' FOREIGN KEY(type_id) REFERENCES tb_account_type(id))');
    db.execute('CREATE TABLE IF NOT EXISTS tb_category(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, parent_id INTEGER, active INTEGER NOT NULL, uuid TEXT NOT NULL, user_id TEXT NOT NULL, last_update TEXT NOT NULL, sync_release INTEGER NOT NULL)');
    db.execute('CREATE TABLE IF NOT EXISTS tb_tag(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, active INTEGER NOT NULL, uuid TEXT NOT NULL, user_id TEXT NOT NULL, last_update TEXT NOT NULL, sync_release INTEGER NOT NULL)');
    db.execute('CREATE TABLE IF NOT EXISTS tb_credit_card_type(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, active INTEGER NOT NULL, uuid TEXT NOT NULL)');
    db.execute('CREATE TABLE IF NOT EXISTS tb_credit_card(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, type_id INTEGER NOT NULL, account_id INTEGER, closing_day INTEGER NOT NULL, paying_day INTEGER NOT NULL, limit_value REAL NOT NULL, active INTEGER NOT NULL, uuid TEXT NOT NULL, user_id TEXT NOT NULL, last_update TEXT NOT NULL, sync_release INTEGER NOT NULL,'
        ' FOREIGN KEY(type_id) REFERENCES tb_credit_card_type(id),'
        ' FOREIGN KEY(account_id) REFERENCES tb_account(id))');
    db.execute('CREATE TABLE IF NOT EXISTS tb_transaction(id INTEGER PRIMARY KEY AUTOINCREMENT, type INTEGER NOT NULL, description TEXT NOT NULL, date TEXT NOT NULL, value REAL NOT NULL, category_id INTEGER NOT NULL, account_id INTEGER, fixed INTEGER NOT NULL, pending INTEGER NOT NULL, observation TEXT, tag_id INTEGER, installment_number INTEGER NOT NULL, credit_card_id INTEGER, uuid TEXT NOT NULL, uuid_group TEXT, user_id TEXT NOT NULL, last_update TEXT NOT NULL, sync_release INTEGER NOT NULL,'
        ' FOREIGN KEY(category_id) REFERENCES tb_category(id),'
        ' FOREIGN KEY(account_id) REFERENCES tb_account(id),'
        ' FOREIGN KEY(tag_id) REFERENCES tb_tag(id), '
        ' FOREIGN KEY(credit_card_id) REFERENCES tb_credit_card(id))');
  }

  Future _onUpgradeDatabase(Database db, int oldVersion, int newVersion) async {

  }

  Future close() async {
    final db = await _instance.getDatabase();
    db.close();
  }
}