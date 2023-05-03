import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/category_form.dart';
import 'package:mymoney/components/crud_page.dart';
import 'package:mymoney/controllers/category_page_controller.dart';
import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/models/category.dart';
import 'package:uuid/uuid.dart';

class CategoryPage extends CrudPage<Category> {
  CategoryPage({super.key});

  @override
  _CategoryPageState createState() => _CategoryPageState();

}

class _CategoryPageState extends CrudPageState<Category> {

  @override
  CrudPageController<Category> createController() {
    return CategoryPageController();
  }

  @override
  Category createNewItem() {
    return Category(name: '', active: true, uuid: const Uuid().v4(), userId: '', lastUpdate: DateTime.now(), syncRelease: true);
  }

  @override
  int getItemId(Category item) {
    return item.id!!;
  }

  @override
  Widget? getItemLeading(Category item) {
    if(item.parentId != null){
      return const Icon(Icons.subdirectory_arrow_right);
    }
    return null;
  }

  @override
  Widget? getItemTitle(Category item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text(item.name)),
        Visibility(
          visible: item.parentId == null,
          child: IconButton(
            icon: const Icon(Icons.add),
            tooltip: AppLocalizations.of(context)!.addSubcategoryToolTip,
            onPressed: () {
              Category newItem = createNewItem();
              newItem.parentId = item.id;
              newItem.parent = item;
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryForm(model: newItem)))
                  .then((value) => controller.loading());
            },
          )
        )
      ],
    );
  }

  @override
  String getTitle(BuildContext context) {
    return AppLocalizations.of(context)!.categories;
  }

  @override
  Widget navigateToForm(BuildContext context, Category item) {
    return CategoryForm(model: item);
  }

}