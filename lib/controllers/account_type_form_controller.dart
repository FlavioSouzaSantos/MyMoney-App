import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/dao/account_type_dao.dart';
import 'package:mymoney/models/account_type.dart';

class AccountTypeFormController extends CrudFormController<AccountType> {

  AccountTypeFormController() : super(crudDao: AccountTypeDao());

  @override
  int? getItemId(AccountType item) {
    return item.id;
  }
}