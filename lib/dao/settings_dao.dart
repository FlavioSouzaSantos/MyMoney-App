import 'package:mymoney/dao/crud_dao.dart';
import 'package:mymoney/dao/database_config.dart';
import 'package:mymoney/models/settings.dart';
import 'package:sqflite/sqflite.dart';

class SettingsDao extends CrudDao<Settings> {

  static final _instance = SettingsDao._internal();

  factory SettingsDao(){
    return _instance;
  }

  SettingsDao._internal();

  Future<Settings?> getSettings() async {
    Database db = await DatabaseConfig().getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName(), orderBy: 'id', limit: 1);
    return maps.isNotEmpty ? convertMapToEntity(maps[0]) : null;
  }

  @override
  Map<String, dynamic> convertEntityToMap(Settings entity) {
    return {
      'username': entity.username,
      'uuid_logged': entity.uuidLogged,
      'token': entity.token,
      'uuid_instalation': entity.uuidInstalation,
      'app_version': entity.appVersion
    };
  }

  @override
  Settings convertMapToEntity(Map<String, dynamic> map) {
    return Settings(id: map['id'], username: map['username'], uuidLogged: map['uuid_logged'],
        token: map['token'], uuidInstalation: map['uuid_instalation'], appVersion: map['app_version']);
  }

  @override
  String tableName() {
    return 'tb_settings';
  }

}