import 'package:flutter/material.dart';
import 'package:mymoney/components/transaction_card.dart';
import 'package:mymoney/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(0),
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) {
          return TransactionCard(model: transactions[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}