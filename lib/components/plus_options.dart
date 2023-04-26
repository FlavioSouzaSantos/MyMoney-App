import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/account_page.dart';
import 'package:mymoney/components/account_type_page.dart';

class PlusOptions extends StatelessWidget {

  const PlusOptions({super.key});

  @override
  Widget build(BuildContext context){
    return ListView.separated(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 10, right: 10),
            leading: _getIconItemFromIndex(context, index),
            title: Text(_getTextItemFromIndex(context, index)),
            onTap: () {
              _onClickItemFromIndex(context, index);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Padding(padding: EdgeInsets.only(left: 10, right: 10), child: Divider(height: 2)),
    );
  }

  String _getTextItemFromIndex(BuildContext context, int index){
    switch(index){
      case 0: return AppLocalizations.of(context)!.accountType;
      case 1: return AppLocalizations.of(context)!.accounts;
      case 2: return AppLocalizations.of(context)!.categories;
      case 3: return AppLocalizations.of(context)!.tags;
      case 4: return AppLocalizations.of(context)!.creditCardTypes;
      case 5: return AppLocalizations.of(context)!.creditCards;
      default: return '';
    }
  }

  Icon _getIconItemFromIndex(BuildContext context, int index){
    return const Icon(Icons.account_tree);
  }

  void _onClickItemFromIndex(BuildContext context, int index){
    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AccountTypePage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage()));
    }
  }
}