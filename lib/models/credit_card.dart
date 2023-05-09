import 'package:mymoney/models/credit_card_type.dart';
import 'package:mymoney/models/account.dart';

class CreditCard {
  int? id;
  String name;
  CreditCardType? type;
  int typeId;
  Account? account;
  int accountId;
  int closingDay;
  int payingDay;
  double limitValue;
  bool active;
  String uuid;
  String userId;
  DateTime lastUpdate;
  bool syncRelease;

  CreditCard({
    this.id,
    required this.name,
    this.type,
    required this.typeId,
    this.account,
    required this.accountId,
    required this.closingDay,
    required this.payingDay,
    required this.limitValue,
    required this.active,
    required this.uuid,
    required this.userId,
    required this.lastUpdate,
    required this.syncRelease
  });
}