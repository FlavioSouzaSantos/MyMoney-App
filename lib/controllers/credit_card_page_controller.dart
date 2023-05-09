import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/dao/credit_card_dao.dart';
import 'package:mymoney/models/credit_card.dart';

class CreditCardPageController extends CrudPageController<CreditCard> {
  CreditCardPageController() : super(crudDao: CreditCardDao());
}