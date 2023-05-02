import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/dao/account_category_dao.dart';
import 'package:mymoney/models/category.dart';

class CategoryPageController extends CrudPageController<Category> {
  CategoryPageController() : super(crudDao: CategoryDao());
}