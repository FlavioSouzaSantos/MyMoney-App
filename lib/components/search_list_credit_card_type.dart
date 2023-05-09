import 'package:mymoney/components/search_list.dart';
import 'package:mymoney/dao/credit_card_typeDao.dart';
import 'package:mymoney/models/credit_card_type.dart';

class SearchListCreditCardType extends SearchList<CreditCardType> {

  SearchListCreditCardType({super.key, required super.onSelectedItem, super.selectedItem}) : super(crudDao: CreditCardTypeDao(), fieldName: 'name');

  @override
  String getItemLabel(CreditCardType item) {
    return item.name;
  }

}