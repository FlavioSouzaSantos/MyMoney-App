import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/dao/credit_card_typeDao.dart';
import 'package:mymoney/models/credit_card_type.dart';

class CreditCardTypePageController extends CrudPageController<CreditCardType> {

  CreditCardTypePageController() : super(crudDao: CreditCardTypeDao());

}