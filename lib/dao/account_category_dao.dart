import 'package:mymoney/dao/crud_dao.dart';
import 'package:mymoney/models/category.dart';

class CategoryDao extends CrudDao<Category> {

  static final _instance = CategoryDao._internal();

  factory CategoryDao() {
    return _instance;
  }

  CategoryDao._internal();

  @override
  Map<String, dynamic> convertEntityToMap(Category entity) {
    return {
      'name': entity.name,
      'parent_id': entity.parentId,
      'active': entity.active ? 1 : 0,
      'user_id': entity.userId,
      'uuid': entity.uuid,
      'last_update': entity.lastUpdate.toIso8601String(),
      'sync_release': entity.syncRelease ? 1 : 0
    };
  }

  @override
  Category convertMapToEntity(Map<String, dynamic> map) {
    return Category(id: map['id'], name: map['name'], parentId: map['parent_id'], active: map['active'] == 1,
        userId: map['user_id'], uuid: map['uuid'],
        lastUpdate: DateTime.parse(map['last_update'] ?? ''),
        syncRelease: map['sync_release'] == 1);
  }

  @override
  String tableName() {
    return 'tb_category';
  }

}