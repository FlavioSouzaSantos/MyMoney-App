import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/account_form.dart';
import 'package:mymoney/components/crud_page.dart';
import 'package:mymoney/controllers/account_page_controller.dart';
import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/models/account.dart';
import 'package:uuid/uuid.dart';

class AccountPage extends CrudPage<Account> {

  AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends CrudPageState<Account> {

  @override
  CrudPageController<Account> createController() {
    return AccountPageController();
  }

  @override
  Account createNewItem() {
    return Account(name: '', typeId: 0, initialValue: 0, uuid: const Uuid().v4(), userId: '', lastUpdate: DateTime.now(), syncRelease: true);
  }

  @override
  int getItemId(Account item) {
    return item.id!!;
  }

  @override
  Widget? getItemLeading(Account item) {
    return null;
  }

  @override
  Widget? getItemTitle(Account item) {
    return Text(item.name);
  }

  @override
  String getTitle(BuildContext context) {
    return AppLocalizations.of(context)!.accounts;
  }

  @override
  Widget navigateToForm(BuildContext context, Account item) {
    return AccountForm(model: item);
  }

}