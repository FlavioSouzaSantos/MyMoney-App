import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/dao/settings_dao.dart';
import 'package:mymoney/dao/tag_dao.dart';
import 'package:mymoney/models/settings.dart';
import 'package:mymoney/models/tag.dart';

class TagFormController extends CrudFormController<Tag> {

  TagFormController() : super(crudDao: TagDao());

  @override
  int? getItemId(Tag item) {
    return item.id;
  }

  @override
  Future<Tag> beforeInsertItem(Tag item) async {
    Settings? settings = await SettingsDao().getSettings();
    item.userId = settings?.uuidLogged??'';
    return item;
  }

  @override
  Future<Tag> beforeUpdateItem(Tag item) async {
    item.syncRelease = true;
    item.lastUpdate = DateTime.now();
    return item;
  }
}