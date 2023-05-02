import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/dao/account_category_dao.dart';
import 'package:mymoney/dao/settings_dao.dart';
import 'package:mymoney/models/category.dart';
import 'package:mymoney/models/settings.dart';

class CategoryFormController extends CrudFormController<Category> {

  CategoryFormController() : super(crudDao: CategoryDao());

  @override
  int? getItemId(Category item) {
    return item.id;
  }

  @override
  Future<Category> beforeInsertItem(Category item) async {
    Settings? settings = await SettingsDao().getSettings();
    item.userId = settings?.uuidLogged??'';
    _setParentFromId(item);
    return item;
  }

  @override
  Future<Category> beforeUpdateItem(Category item) async {
    _setParentFromId(item);
    return item;
  }

  void _setParentFromId(Category item) async {
    if(item.parentId != null){
      Category? parent = await crudDao.findById(item.parentId!!);
      if(parent != null){
        item.parent = parent;
      }else{
        item.parentId = null;
      }
    }
  }
}