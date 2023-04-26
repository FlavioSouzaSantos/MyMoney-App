import 'package:mymoney/dao/crud_dao.dart';
import 'package:mymoney/models/tag.dart';

class TagDao extends CrudDao<Tag> {

  static final _instance = TagDao._internal();

  factory TagDao() {
    return _instance;
  }

  TagDao._internal();

  @override
  Map<String, dynamic> convertEntityToMap(Tag entity) {
    return {
      'name': entity.name,
      'active': entity.active ? 1 : 0,
      'uuid': entity.uuid,
      'user_id': entity.userId,
      'last_update': entity.lastUpdate.toIso8601String(),
      'sync_release': entity.syncRelease ? 1 : 0
    };
  }

  @override
  Tag convertMapToEntity(Map<String, dynamic> map) {
    return Tag(id: map['id'], name: map['name'], active: map['active'] == 1,
        uuid: map['uuid'], userId: map['user_id'],
        lastUpdate: DateTime.parse(map['last_update'] ?? ''),
        syncRelease: map['sync_release'] == 1);
  }

  @override
  String tableName() {
    return 'tb_tag';
  }

}