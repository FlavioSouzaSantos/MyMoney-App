import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/dao/credit_card_typeDao.dart';
import 'package:mymoney/models/credit_card_type.dart';

class CreditCardTypeFormControlle extends CrudFormController<CreditCardType> {

  CreditCardTypeFormControlle() : super(crudDao: CreditCardTypeDao());

  @override
  int? getItemId(CreditCardType item) {
    return item.id;
  }

}