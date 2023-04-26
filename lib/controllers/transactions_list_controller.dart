import 'package:flutter/widgets.dart';
import 'package:mymoney/components/transaction_list_and_filter.dart';
import 'package:mymoney/dao/transaction_dao.dart';
import 'package:mymoney/models/transaction.dart';

class TransactionsListController extends ValueNotifier<TransactionListState> {

  List<Transaction> provider = [];

  TransactionsListController() : super(TransactionListState.started);

  Future<void> search(int year, int month, TransactionTypeFilter type) async {
    value = TransactionListState.searching;
    return Future(() async => {
      provider = await TransactionDao().findAllByYearMonthAndType(year, month,
      type == TransactionTypeFilter.all ? TransactionType.values :
      (type == TransactionTypeFilter.revenue ? [TransactionType.revenue] : [TransactionType.expense]))
    }).then((value) => this.value = TransactionListState.success,
        onError: (Object e) => {value = TransactionListState.error}
    );
  }
}

enum TransactionListState {
  started,
  searching,
  success,
  error
}