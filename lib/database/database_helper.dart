import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "atendimetos.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
        "CREATE TABLE atendimento (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, descricao TEXT, data TEXT, ativo BOOLEAN, preco DOUBLE NOT NULL, foto TEXT);",
      ),
      version: _version,
    );
  }

  static Future<int> addAtendimento(Atendimento atendimento) async {
    final db = await _getDB();
    return await db.insert(
      'atendimento',
      atendimento.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateAtendimento(int id, Atendimento atendimento) async {
    final db = await _getDB();
    return await db.update(
      'atendimento',
      atendimento.toJson(),
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteAtendimento(int id) async {
    final db = await _getDB();
    return await db.delete('atendimento', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Atendimento>?> getAtendimentos() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('atendimento');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => Atendimento.fromJson(maps[index]),
    );
  }

  static Future<bool> alterarAtivo(int id, bool ativo) async {
    final db = await _getDB();
    int count = await db.update(
      'atendimento',
      {'ativo': ativo ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  static Future<List<Atendimento>?> getAtendimentosAtivos(bool ativo) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'atendimento',
      where: 'ativo = ?',
      whereArgs: [ativo ? 1 : 0],
    );

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => Atendimento.fromJson(maps[index]),
    );
  }
}
