import 'package:mymoney/dao/crud_dao.dart';
import 'package:mymoney/models/credit_card_type.dart';

class CreditCardTypeDao extends CrudDao<CreditCardType> {

  static final _instance = CreditCardTypeDao._internal();

  factory CreditCardTypeDao() {
    return _instance;
  }

  CreditCardTypeDao._internal();

  @override
  Map<String, dynamic> convertEntityToMap(CreditCardType entity) {
    return {
      'name': entity.name,
      'active': entity.active ? 1 : 0,
      'uuid': entity.uuid
    };
  }

  @override
  CreditCardType convertMapToEntity(Map<String, dynamic> map) {
    return CreditCardType(id: map['id'], name: map['name'], active: map['active'] == 1, uuid: map['uuid']);
  }

  @override
  String tableName() {
    return 'tb_credit_card_type';
  }

}