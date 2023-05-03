import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/dao/category_dao.dart';
import 'package:mymoney/models/category.dart';

class CategoryPageController extends CrudPageController<Category> {
  CategoryPageController() : super(crudDao: CategoryDao());

  @override
  Future<void> loading() async {
    try{
      value = PageState.loading;
      provider = [];

      List<Category> tempList = await crudDao.findAll();
      tempList.where((element) => element.parentId == null).
      forEach((element) {
        provider.add(element);
        tempList.where((element2) => element2.parentId != null && element2.parentId!! == element.id!!).
        forEach((element3) {
          provider.add(element3);
        });
      });

      value = PageState.success;
    }catch(e){
      value = PageState.error;
    }
  }
}