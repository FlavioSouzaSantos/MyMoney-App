import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/models/transaction.dart';

class ExpenseForm extends StatelessWidget {

  final Transaction? model;

  const ExpenseForm({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('TESTE')
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.check),
        label: Text(
          AppLocalizations.of(context)!.save,
        ),
        onPressed: _save,
      ),
    );
  }

  _save() {

  }
}