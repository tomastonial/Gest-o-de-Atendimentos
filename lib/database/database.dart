import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

Future<Database> initDatabase() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, "atendimentos.db");

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE atendimentos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          descricao TEXT,
          data TEXT,
          ativo boolean NOT NULL DEFAULT 1,
          foto TEXT
        )
      ''');
    },
  );
}
