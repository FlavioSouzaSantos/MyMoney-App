import 'package:mymoney/models/account.dart';
import 'package:mymoney/models/category.dart';
import 'package:mymoney/models/credit_card.dart';
import 'package:mymoney/models/tag.dart';

enum TransactionType {
  revenue,
  expense
}

class Transaction {
  final int? id;
  final TransactionType type;
  final String description;
  final DateTime data;
  final double value;
  final Category? category;
  final int categoryId;
  final Account? account;
  final int accountId;
  final bool fixed;
  final bool pending;
  final String? observation;
  final Tag? tag;
  final int? tagId;
  final int installmentNumber;
  final CreditCard? creditCard;
  final int? creditCardId;
  final String userId;
  final String uuid;
  final String? uuidGroup;
  final DateTime lastUpdate;
  final bool syncRelease;

  const Transaction({
    this.id,
    required this.type,
    required this.description,
    required this.data,
    required this.value,
    this.category,
    required this.categoryId,
    this.account,
    required this.accountId,
    required this.fixed,
    required this.pending,
    this.observation,
    this.tag,
    this.tagId,
    required this.installmentNumber,
    this.creditCard,
    this.creditCardId,
    required this.userId,
    required this.uuid,
    this.uuidGroup,
    required this.lastUpdate,
    required this.syncRelease
  });
}