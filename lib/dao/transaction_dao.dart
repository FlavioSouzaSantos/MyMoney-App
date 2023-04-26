import 'package:mymoney/dao/crud_dao.dart';
import 'package:mymoney/dao/database_config.dart';
import 'package:mymoney/models/transaction.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

class TransactionDao extends CrudDao<Transaction> {

  static final _instance = TransactionDao._internal();

  factory TransactionDao() {
    return _instance;
  }

  TransactionDao._internal();

  @override
  Map<String, dynamic> convertEntityToMap(Transaction entity) {
    return {
      'type': entity.type.index,
      'description': entity.description,
      'date': entity.data.toIso8601String(),
      'value': entity.value,
      'category_id': entity.categoryId,
      'account_id': entity.accountId,
      'fixed': entity.fixed ? 1 : 0,
      'pending': entity.pending ? 1 : 0,
      'observation': entity.observation,
      'tag_id': entity.tagId,
      'installment_number': entity.installmentNumber,
      'credit_card_id': entity.creditCardId,
      'user_id': entity.userId,
      'uuid_group': entity.uuidGroup,
      'uuid': entity.uuid,
      'last_update': entity.lastUpdate.toIso8601String(),
      'sync_release': entity.syncRelease ? 1 : 0
    };
  }

  @override
  Transaction convertMapToEntity(Map<String, dynamic> map) {
    return Transaction(id: map['id'], type: TransactionType.values.firstWhere((element) => element.index == map['type']),
        description: map['description'], data: DateTime.parse(map['date'] ?? ''),
        value: map['value'], categoryId: map['category_id'], accountId: map['account_id'],
        fixed: map['fixed'] == 1, pending: map['pending'], observation: map['observation'], tagId: map['tag_id'],
        installmentNumber: map['installment_number'], creditCardId: map['credit_card_id'],
        userId: map['user_id'], uuid: map['uuid'], uuidGroup: map['uuid_group'],
        lastUpdate: DateTime.parse(map['last_update'] ?? ''),
        syncRelease: map['sync_release'] == 1);
  }

  @override
  String tableName() {
    return 'tb_transaction';
  }

  Future<List<Transaction>> findAllByYearMonthAndType(int year, int month, List<TransactionType> transactionTypes) async{
    Database db = await DatabaseConfig().getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(tableName(),
        where : "cast(strftime('%Y', date / 1000, 'unixepoch', 'localtime') as int) = ? AND cast(strftime('%m', date / 1000, 'unixepoch', 'localtime') as int) = ? AND type IN (?)",
        whereArgs : [year, month, transactionTypes.map((e) => e.index).toList()]);
    return List.generate(maps.length, (index) => convertMapToEntity(maps[index]));
  }
}