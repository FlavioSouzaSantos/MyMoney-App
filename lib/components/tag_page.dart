import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/crud_page.dart';
import 'package:mymoney/components/tag_form.dart';
import 'package:mymoney/controllers/crud_page_controller.dart';
import 'package:mymoney/controllers/tag_page_controller.dart';
import 'package:mymoney/models/tag.dart';
import 'package:uuid/uuid.dart';

class TagPage extends CrudPage<Tag> {
  TagPage({super.key});

  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends CrudPageState<Tag> {
  @override
  CrudPageController<Tag> createController() {
    return TagPageController();
  }

  @override
  Tag createNewItem() {
    return Tag(name: '', active: true, uuid: const Uuid().v4(), userId:  '', lastUpdate: DateTime.now(), syncRelease: true);
  }

  @override
  int getItemId(Tag item) {
    return item.id!!;
  }

  @override
  Widget? getItemLeading(Tag item) {
    return null;
  }

  @override
  Widget? getItemTitle(Tag item) {
    return Text(item.name);
  }

  @override
  String getTitle(BuildContext context) {
    return AppLocalizations.of(context)!.tags;
  }

  @override
  Widget navigateToForm(BuildContext context, Tag item) {
    return TagForm(model: item);
  }

}