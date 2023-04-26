import 'package:mymoney/models/credit_card_type.dart';
import 'package:mymoney/models/account.dart';

class CreditCard {
  final int? id;
  final String name;
  final CreditCardType? type;
  final int typeId;
  final Account? account;
  final int accountId;
  final int closingDay;
  final int payingDay;
  final double limitValue;
  final bool active;
  final String uuid;
  final String userId;
  final DateTime lastUpdate;
  final bool syncRelease;

  const CreditCard({
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