import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/transaction_filter.dart';
import 'package:mymoney/components/transaction_list.dart';
import 'package:mymoney/controllers/transactions_list_controller.dart';

class TransactionListAndFitler extends StatefulWidget {

  TransactionTypeFilter typeFilter = TransactionTypeFilter.all;
  DateTime dateFilter = DateTime.now();

  TransactionListAndFitler({super.key});

  @override
  _TransactionListAndFitler createState()  => _TransactionListAndFitler();

}

class _TransactionListAndFitler extends State<TransactionListAndFitler> {

  final TransactionsListController controller = TransactionsListController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
    _startSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionFilter(
          typeFilter: widget.typeFilter,
          dateFilter: widget.dateFilter,
          onClickTypeFilter: (value) => setState(() {
            widget.typeFilter = value;
            _startSearch();
          }),
          onClickDateFilter: (value) => setState(() {
            widget.dateFilter = value;
            _startSearch();
          }),
        ),
        Expanded(child: _createContentContainer())
      ],
    );
  }

  _startSearch() async {
    controller.search(widget.dateFilter.year,
        widget.dateFilter.month,
        widget.typeFilter);
  }

  Widget _createContentContainer() {
    switch(controller.value){
      case TransactionListState.searching:
        return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator()
        );
      case TransactionListState.error:
        return Container(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.error,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        );
      default:
        return TransactionList(transactions: controller.provider);
    }
  }
}

enum TransactionTypeFilter {
  all,
  revenue,
  expense
}