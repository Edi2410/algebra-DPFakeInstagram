import 'package:sqflite/sqflite.dart';

class SqlDb {
  static const databaseName = "mysql.db";
  static final SqlDb instance = SqlDb._instance();
  static Database? _database;

  SqlDb._instance();

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + databaseName;

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE UserData ('
          'id INTEGER PRIMARY KEY, '
          'uid TEXT, '
          'displayName TEXT, '
          'isAdministrator BOOLEAN NOT NULL DEFAULT 0 CHECK (isAdministrator '
          'IN (0, 1)))',
        );
        await db.execute(
          'CREATE TABLE PackageInfo ('
          'id INTEGER PRIMARY KEY, '
          'uid TEXT, '
          'packageName TEXT, '
          'date DATETIME DEFAULT CURRENT_TIMESTAMP)',
        );
        await db.execute(
          'CREATE TABLE Photo ('
          'id INTEGER PRIMARY KEY, '
          'uid TEXT, '
          'author TEXT, '
          'date DATETIME DEFAULT CURRENT_TIMESTAMP,'
          'description TEXT,'
          'hashtags TEXT,'
          'url TEXT)',
        );
        await db.execute(
          'CREATE TABLE ErrorLogs ('
          'id INTEGER PRIMARY KEY, '
          'uid TEXT, '
          'email TEXT, '
          'date DATETIME DEFAULT CURRENT_TIMESTAMP,'
          'action TEXT,'
          'error TEXT)',
        );
        await db.execute(
          'CREATE TABLE InfoLogs ('
          'id INTEGER PRIMARY KEY, '
          'uid TEXT, '
          'email TEXT, '
          'date DATETIME DEFAULT CURRENT_TIMESTAMP,'
          'action TEXT )',
        );
      },
    );
  }
}
