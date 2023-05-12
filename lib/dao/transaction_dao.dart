import 'package:mymoney/dao/crud_dao.dart';
import 'package:mymoney/dao/database_config.dart';
import 'package:mymoney/models/repeat_transaction.dart';
import 'package:mymoney/models/transaction.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

class TransactionDao extends CrudDao<Transaction> {

  static final _instance = TransactionDao._internal();

  factory TransactionDao() {
    return _instance;
  }

  TransactionDao._internal();

  Future<List<int>> insertWithRepeat(Transaction entity, RepeatTransaction repeat) async {
    List<int> ids = [];
    List<Transaction> transactions = [];

    entity.totalInstallment = repeat.count;
    entity.installmentNumber = 1;
    entity.totalInstallment = repeat.count;
    transactions.add(entity);

    if(repeat.count > 1){
      for(var i=2; i <= repeat.count; i++){
        Transaction newEntity = entity.clone();
        newEntity.installmentNumber = i;
        transactions.add(newEntity);
      }
    }

    switch(repeat.type){
      case RepeatTransactionType.day: {
        transactions.getRange(1, repeat.count).forEach((element) {
          element.data = element.data.add(Duration(days: element.installmentNumber));
        });
      }
      break;
      case RepeatTransactionType.month: {
        transactions.getRange(1, repeat.count).forEach((element) {
          element.data = _addMonths(element.data, element.installmentNumber);
        });
      }
      break;
      case RepeatTransactionType.week: {
        transactions.getRange(1, repeat.count).forEach((element) {
          element.data = element.data.add(Duration(days: element.installmentNumber*DateTime.daysPerWeek));
        });
      }
      break;
      case RepeatTransactionType.year: {
        transactions.getRange(1, repeat.count).forEach((element) {
          element.data = DateTime(element.data.year+(element.installmentNumber-1),
              element.data.month, element.data.day);
        });
      }
      break;
    }

    for(Transaction item in transactions) {
      ids.add(await insert(item));
    }

    return ids;
  }

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
      'total_installment': entity.installmentNumber,
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
        installmentNumber: map['installment_number'], totalInstallment: map['total_installment'],
        creditCardId: map['credit_card_id'],
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

  DateTime _addMonths(DateTime value, int months){
    int addYears = months ~/ 12;
    return DateTime(value.year+addYears,
        value.month+(addYears > 0 ? months -(addYears*12) : months),
      value.day, value.hour, value.minute, value.second,
      value.millisecond, value.microsecond);
  }
}