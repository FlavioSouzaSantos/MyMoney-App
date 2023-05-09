import 'package:mymoney/components/search_list.dart';
import 'package:mymoney/dao/account_dao.dart';
import 'package:mymoney/models/account.dart';

class SearchListAccount extends SearchList<Account> {

  SearchListAccount({super.key, required super.onSelectedItem, super.selectedItem}) : super(crudDao: AccountDao(), fieldName: 'name');

  @override
  String getItemLabel(Account item){
    return item.name;
  }
}