import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/dao/account_type_dao.dart';
import 'package:mymoney/models/account_type.dart';

class AccountTypePageController extends CrudPageController<AccountType> {
  AccountTypePageController() : super(crudDao: AccountTypeDao());
}