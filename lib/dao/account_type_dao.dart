import 'package:mymoney/dao/crud_dao.dart';
import 'package:mymoney/models/account_type.dart';

class AccountTypeDao extends CrudDao<AccountType> {

  static final _instance = AccountTypeDao._internal();

  factory AccountTypeDao() {
    return _instance;
  }

  AccountTypeDao._internal();

  @override
  Map<String, dynamic> convertEntityToMap(AccountType entity) {
    DateTime.parse(DateTime.now().toIso8601String());
    return {
      'name': entity.name,
      'active': entity.active ? 1 : 0,
      'uuid': entity.uuid,
      'last_update': entity.lastUpdate.toIso8601String(),
      'sync_release': entity.syncRelease ? 1 : 0
    };
  }

  @override
  AccountType convertMapToEntity(Map<String, dynamic> map) {
    return AccountType(id: map['id'], name: map['name'], active: map['active'] == 1,
        uuid: map['uuid'], lastUpdate: DateTime.parse(map['last_update'] ?? ''),
        syncRelease: map['sync_release'] == 1);
  }

  @override
  String tableName() {
    return 'tb_account_type';
  }

}