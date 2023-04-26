import 'package:mymoney/models/account_type.dart';

class Account {
  int? id;
  String name;
  AccountType? type;
  int typeId;
  double initialValue;
  String uuid;
  String userId;
  DateTime lastUpdate;
  bool syncRelease;

  Account({
    this.id,
    required this.name,
    this.type,
    required this.typeId,
    required this.initialValue,
    required this.uuid,
    required this.userId,
    required this.lastUpdate,
    required this.syncRelease
  });
}