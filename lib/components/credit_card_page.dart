import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/credit_card_form.dart';
import 'package:mymoney/components/crud_page.dart';
import 'package:mymoney/controllers/credit_card_page_controller.dart';
import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/models/credit_card.dart';
import 'package:uuid/uuid.dart';

class CreditCardPage extends CrudPage<CreditCard> {

  CreditCardPage({super.key});

  @override
  _CreditCardPageState createState() => _CreditCardPageState();

}

class _CreditCardPageState extends CrudPageState<CreditCard> {
  @override
  CrudPageController<CreditCard> createController() {
    return CreditCardPageController();
  }

  @override
  CreditCard createNewItem() {
    return CreditCard(name: '', typeId: -1, accountId: -1, closingDay: 1, payingDay: 1, limitValue: 1, active: true, uuid: const Uuid().v4(), userId: '', lastUpdate: DateTime.now(), syncRelease: true);
  }

  @override
  int getItemId(CreditCard item) {
    return item.id!!;
  }

  @override
  Widget? getItemLeading(CreditCard item) {
    return null;
  }

  @override
  Widget? getItemTitle(CreditCard item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Row(
          children: [
            Chip(label: Text(item.type?.name??'')),
            const Text('  '),
            Chip(label: Text(AppLocalizations.of(context)!.closingDayLabel(item.closingDay)))
          ],
        )
      ],
    );
  }

  @override
  String getTitle(BuildContext context) {
    return AppLocalizations.of(context)!.creditCards;
  }

  @override
  Widget navigateToForm(BuildContext context, CreditCard item) {
    return CreditCardForm(model: item);
  }

}