import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.balance, required this.revenue, required this.expense});

  final double balance;
  final double revenue;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.accountBalance,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  AppLocalizations.of(context)!.currencyValue(balance),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Revenue(valor: revenue),
                const Spacer(),
                Expense(valor: expense),
              ],
            )
          ],
        ),
      )
    );
  }
}

class Revenue extends StatelessWidget {

  const Revenue({super.key, required this.valor});

  final double valor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.arrow_upward,
          color: Colors.green,
        ),
        const SizedBox(width: 15),
        Column(
          children: [
            Text(
              AppLocalizations.of(context)!.revenue,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              AppLocalizations.of(context)!.currencyValue(valor),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        )
      ],
    );
  }
}

class Expense extends StatelessWidget {

  const Expense({super.key, required this.valor});

  final double valor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.arrow_downward,
          color: Colors.red,
        ),
        const SizedBox(width: 15),
        Column(
          children: [
            Text(
              AppLocalizations.of(context)!.expense,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              AppLocalizations.of(context)!.currencyValue(valor),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        )
      ],
    );
  }
}