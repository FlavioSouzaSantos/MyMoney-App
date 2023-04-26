import 'package:mymoney/components/search_list.dart';
import 'package:mymoney/dao/account_type_dao.dart';
import 'package:mymoney/models/account_type.dart';

class SearchListAccountType extends SearchList<AccountType> {

  SearchListAccountType({super.key, required super.onSelectedItem, super.selectedItem}) : super(crudDao: AccountTypeDao(), fieldName: 'name');

  @override
  String getItemLabel(AccountType item){
    return item.name;
  }
}