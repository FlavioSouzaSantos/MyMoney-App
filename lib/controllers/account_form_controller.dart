import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/dao/account_dao.dart';
import 'package:mymoney/dao/settings_dao.dart';
import 'package:mymoney/models/account.dart';
import 'package:mymoney/models/settings.dart';

class AccountFormController extends CrudFormController<Account> {

  AccountFormController() : super(crudDao: AccountDao());

  @override
  Future<Account> beforeInsertItem(Account item) async {
    Settings? settings = await SettingsDao().getSettings();
    item.userId = settings?.uuidLogged??'';
    return item;
  }

  @override
  int? getItemId(Account item) {
    return item.id;
  }
}