import 'package:mymoney/dao/database_config.dart';
import 'package:sqflite/sqflite.dart';

abstract class CrudDao<T> {

  Future<int> insert(T entity) async {
    Database db = await DatabaseConfig().getDatabase();
    return await db.insert(tableName(), convertEntityToMap(entity),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update(T entity, int id) async {
    Database db = await DatabaseConfig().getDatabase();
    return await db.update(tableName(), convertEntityToMap(entity),
        where: 'id = ?', whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> delete(int id) async {
    Database db = await DatabaseConfig().getDatabase();
    await db.delete(tableName(), where: 'id = ?', whereArgs: [id]);
  }

  Future<T?> findById(int id) async {
    Database db = await DatabaseConfig().getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName(), where: "id = ?", whereArgs: [id]);
    return maps.isNotEmpty ? await loadDependencies(convertMapToEntity(maps[0])) : null;
  }

  Future<List<T>> findAll() async {
    Database db = await DatabaseConfig().getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName());
    return List.generate(maps.length, (index) => convertMapToEntity(maps[index]));
  }

  Future<List<T>> findByField(String fieldName, String sqlOperator, String fieldValue) async {
    Database db = await DatabaseConfig().getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName(),
    where: 'upper($fieldName) $sqlOperator ?', whereArgs: [fieldValue]);
    return List.generate(maps.length, (index) => convertMapToEntity(maps[index]));
  }

  Future<T> loadDependencies(T entity) async {
    return entity;
  }

  Map<String, dynamic> convertEntityToMap(T entity);
  T convertMapToEntity(Map<String, dynamic> map);
  String tableName();
}