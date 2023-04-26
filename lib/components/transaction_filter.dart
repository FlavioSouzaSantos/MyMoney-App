import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/transaction_list_and_filter.dart';

class TransactionFilter extends StatelessWidget {

  const TransactionFilter({super.key, required this.typeFilter, required this.dateFilter, this.onClickTypeFilter, this.onClickDateFilter});

  final TransactionTypeFilter typeFilter;
  final DateTime dateFilter;
  final TypeFilterCallback? onClickTypeFilter;
  final DateFilterCallback? onClickDateFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButton(
                  value: typeFilter,
                  dropdownColor: Theme.of(context).primaryColor,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                      color: Colors.white
                  ),
                  items: [
                    DropdownMenuItem(
                      value: TransactionTypeFilter.all,
                      child: Text(
                        AppLocalizations.of(context)!.transactions,
                        style: TextStyle(
                            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                            color: Colors.white
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: TransactionTypeFilter.revenue,
                      child: Text(
                        AppLocalizations.of(context)!.revenue,
                        style: TextStyle(
                            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                            color: Colors.white
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: TransactionTypeFilter.expense,
                      child: Text(
                        AppLocalizations.of(context)!.expense,
                        style: TextStyle(
                            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                  onChanged: (value) => {
                    if(onClickTypeFilter != null && value != null){
                      onClickTypeFilter!(value)
                    }
                  }
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () => {
                      if(onClickDateFilter != null){
                        onClickDateFilter!(_decrementMont(dateFilter))
                      }
                    },
                    label: const Text(''),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _upperFirstChar(AppLocalizations.of(context)!.monthAndYear(dateFilter)),
                    style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                        color: Colors.white
                    ) ,
                  ),
                  TextButton.icon(
                    onPressed: () => {
                      if(onClickDateFilter != null){
                        onClickDateFilter!(_incrementMont(dateFilter))
                      }
                    },
                    label: const Text(''),
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}

DateTime _decrementMont(DateTime value){
  if(value.month == DateTime.january){
    return DateTime(value.year-1, DateTime.december, value.day);
  }
  return DateTime(value.year, value.month-1, value.day);
}

DateTime _incrementMont(DateTime value){
  if(value.month == DateTime.december){
    return DateTime(value.year+1, DateTime.january, value.day);
  }
  return DateTime(value.year, value.month+1, value.day);
}

String _upperFirstChar(String value){
  if(value.length > 1){
    return value[0].toUpperCase()+value.substring(1);
  }
  return value;
}

typedef TypeFilterCallback = void Function(TransactionTypeFilter value);
typedef DateFilterCallback = void Function(DateTime value);