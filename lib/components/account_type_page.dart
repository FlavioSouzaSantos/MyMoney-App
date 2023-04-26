import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/account_type_form.dart';
import 'package:mymoney/components/crud_page.dart';
import 'package:mymoney/controllers/account_type_page_controller.dart';
import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/models/account_type.dart';
import 'package:uuid/uuid.dart';

class AccountTypePage extends CrudPage<AccountType> {

  AccountTypePage({super.key});

  @override
  _AccountTypePageStage createState() => _AccountTypePageStage();
}

class _AccountTypePageStage extends CrudPageState<AccountType> {
  @override
  CrudPageController<AccountType> createController() {
    return AccountTypePageController();
  }

  @override
  AccountType createNewItem() {
    return AccountType(name: '', active: true, uuid: const Uuid().v4(), lastUpdate: DateTime.now(), syncRelease: true);
  }

  @override
  int getItemId(AccountType item) {
    return item.id!!;
  }

  @override
  Widget? getItemLeading(AccountType item) {
    return null;
  }

  @override
  String getItemName(AccountType item) {
    return item.name;
  }

  @override
  String getTitle(BuildContext context) {
    return AppLocalizations.of(context)!.accountTypes;
  }

  @override
  Widget navigateToForm(BuildContext context, AccountType item) {
    return AccountTypeForm(model: item);
  }

}