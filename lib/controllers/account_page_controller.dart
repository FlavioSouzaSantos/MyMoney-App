import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/dao/account_dao.dart';
import 'package:mymoney/models/account.dart';

class AccountPageController extends CrudPageController<Account> {
  AccountPageController() : super(crudDao: AccountDao());
}