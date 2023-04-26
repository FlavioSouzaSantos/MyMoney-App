import 'package:mymoney/dao/account_type_dao.dart';
import 'package:mymoney/dao/crud_dao.dart';
import 'package:mymoney/models/account.dart';

class AccountDao extends CrudDao<Account> {

  static final _instance = AccountDao._internal();

  factory AccountDao() {
    return _instance;
  }

  AccountDao._internal();

  @override
  Map<String, dynamic> convertEntityToMap(Account entity) {
    return {
      'name': entity.name,
      'type_id': entity.typeId,
      'initial_value': entity.initialValue,
      'uuid': entity.uuid,
      'user_id': entity.userId,
      'last_update': entity.lastUpdate.toIso8601String(),
      'sync_release': entity.syncRelease ? 1 : 0
    };
  }

  @override
  Account convertMapToEntity(Map<String, dynamic> map) {
    return Account(id: map['id'], name: map['name'], typeId: map['type_id'],
        initialValue: map['initial_value'], uuid: map['uuid'],
        userId: map['user_id'],
        lastUpdate: DateTime.parse(map['last_update'] ?? ''),
        syncRelease: map['sync_release'] == 1);
  }

  @override
  Future<Account> loadDependencies(Account entity) async {
    entity.type = await AccountTypeDao().findById(entity.typeId);
    return entity;
  }

  @override
  String tableName() {
    return 'tb_account';
  }

}