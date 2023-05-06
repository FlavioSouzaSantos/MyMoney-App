import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/credit_card_type_form.dart';
import 'package:mymoney/components/crud_page.dart';
import 'package:mymoney/controllers/credit_card_type_page_controller.dart';
import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/models/credit_card_type.dart';
import 'package:uuid/uuid.dart';

class CreditCardTypePage extends CrudPage<CreditCardType> {
  CreditCardTypePage({super.key});

  @override
  _CreditCardTypeState createState() => _CreditCardTypeState();
}

class _CreditCardTypeState extends CrudPageState<CreditCardType> {
  @override
  CrudPageController<CreditCardType> createController() {
    return CreditCardTypePageController();
  }

  @override
  CreditCardType createNewItem() {
    return CreditCardType(name: '', active: true, uuid: const Uuid().v4());
  }

  @override
  int getItemId(CreditCardType item) {
    return item.id!!;
  }

  @override
  Widget? getItemLeading(CreditCardType item) {
    return null;
  }

  @override
  Widget? getItemTitle(CreditCardType item) {
    return Text(item.name);
  }

  @override
  String getTitle(BuildContext context) {
    return AppLocalizations.of(context)!.creditCardTypes;
  }

  @override
  Widget navigateToForm(BuildContext context, CreditCardType item) {
    return CreditCardTypeForm(model: item);
  }

}