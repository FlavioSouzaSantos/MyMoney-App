import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/dao/credit_card_dao.dart';
import 'package:mymoney/dao/settings_dao.dart';
import 'package:mymoney/models/credit_card.dart';
import 'package:mymoney/models/settings.dart';

class CreditCardFormController extends CrudFormController<CreditCard> {

  CreditCardFormController() : super(crudDao: CreditCardDao());

  @override
  int? getItemId(CreditCard item) {
    return item.id;
  }

  @override
  Future<CreditCard> beforeInsertItem(CreditCard item ) async {
    Settings? settings = await SettingsDao().getSettings();
    item.userId = settings?.uuidLogged??'';
    return item;
  }

  @override
  Future<CreditCard> beforeUpdateItem(CreditCard item ) async {
    item.syncRelease = true;
    item.lastUpdate = DateTime.now();
    return item;
  }
}