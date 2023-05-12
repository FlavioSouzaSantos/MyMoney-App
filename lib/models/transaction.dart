import 'package:mymoney/models/account.dart';
import 'package:mymoney/models/category.dart';
import 'package:mymoney/models/credit_card.dart';
import 'package:mymoney/models/tag.dart';

enum TransactionType {
  revenue,
  expense
}

class Transaction {
  int? id;
  TransactionType type;
  String description;
  DateTime data;
  double value;
  Category? category;
  int categoryId;
  Account? account;
  int accountId;
  bool fixed;
  bool pending;
  String? observation;
  Tag? tag;
  int? tagId;
  int installmentNumber;
  int totalInstallment;
  CreditCard? creditCard;
  int? creditCardId;
  String userId;
  String uuid;
  String? uuidGroup;
  DateTime lastUpdate;
  bool syncRelease;

  Transaction({
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
    required this.totalInstallment,
    this.creditCard,
    this.creditCardId,
    required this.userId,
    required this.uuid,
    this.uuidGroup,
    required this.lastUpdate,
    required this.syncRelease
  });

  Transaction clone() {
    return Transaction(
        type: type,
        description: description,
        data: data,
        value: value,
        category: category,
        categoryId: categoryId,
        account: account,
        accountId: accountId,
        fixed: fixed,
        pending: pending,
        observation: observation,
        tag: tag,
        tagId: tagId,
        installmentNumber: installmentNumber,
        totalInstallment: totalInstallment,
        creditCard: creditCard,
        creditCardId: creditCardId,
        userId: userId,
        uuid: uuid,
        uuidGroup: uuidGroup,
        lastUpdate: lastUpdate,
        syncRelease: syncRelease
    );
  }
}