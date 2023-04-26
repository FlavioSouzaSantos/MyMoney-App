import 'package:mymoney/dao/crud_dao.dart';
import 'package:mymoney/models/credit_card.dart';

class CreditCardDao extends CrudDao<CreditCard> {

  static final _instance = CreditCardDao._internal();

  factory CreditCardDao() {
    return _instance;
  }

  CreditCardDao._internal();

  @override
  Map<String, dynamic> convertEntityToMap(CreditCard entity) {
    return {
      'name': entity.name,
      'type_id': entity.typeId,
      'account_id': entity.accountId,
      'closing_day': entity.closingDay,
      'paying_day': entity.payingDay,
      'limit_value': entity.limitValue,
      'active': entity.active ? 1 : 0,
      'uuid': entity.uuid,
      'user_id': entity.userId,
      'last_update': entity.lastUpdate.toIso8601String(),
      'sync_release': entity.syncRelease ? 1 : 0
    };
  }

  @override
  CreditCard convertMapToEntity(Map<String, dynamic> map) {
    return CreditCard(id: map['id'], name: map['name'],
        typeId: map['type_id'], accountId: map['account_id'],
        closingDay: map['closing_day'], payingDay: map['paying_day'],
        limitValue: map['limit_value'], active: map['active'] == 1,
        uuid: map['uuid'], userId: map['user_id'],
        lastUpdate: DateTime.parse(map['last_update'] ?? ''),
        syncRelease: map['sync_release'] == 1);
  }

  @override
  String tableName() {
    return 'tb_credit_card';
  }

}