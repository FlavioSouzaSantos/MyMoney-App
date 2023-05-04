import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/dao/tag_dao.dart';
import 'package:mymoney/models/tag.dart';

class TagPageController extends CrudPageController<Tag> {
  TagPageController() : super(crudDao: TagDao());

}