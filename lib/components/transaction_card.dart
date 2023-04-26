import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mymoney/models/transaction.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionCard extends StatelessWidget {

  final Transaction model;

  const TransactionCard({super.key, required this.model});

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        Column(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              model.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Visibility(
              visible: model.pending,
              child: Text(
                DateFormat.yMMMd().format(model.data),
                style: Theme.of(context).textTheme.labelSmall
              )
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.category?.name??'',
                  style: Theme.of(context).textTheme.labelSmall
                ),
                Text(
                    "|",
                    style: Theme.of(context).textTheme.labelSmall
                ),
                Text(
                  model.account?.name??'',
                  style: Theme.of(context).textTheme.labelSmall
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                Text(
                  model.observation??'',
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              AppLocalizations.of(context)!.currencyValue(model.value),
              style: TextStyle(
                  color: model.type == TransactionType.expense ? Colors.red : Colors.green,
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize
              )
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: model.type == TransactionType.expense ? Colors.red : Colors.green,
              ),
              child: Icon(
                model.type == TransactionType.expense ? Icons.push_pin_outlined : Icons.check,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }
}