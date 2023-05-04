import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/crud_form.dart';
import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/controllers/tag_form_controller.dart';
import 'package:mymoney/models/tag.dart';

class TagForm extends CrudForm<Tag> {
  TagForm({super.key, required super.model});

  @override
  _TagFormState createState() => _TagFormState();

}

class _TagFormState extends CrudStateForm<Tag> {

  final FocusNode _nameFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.model.name;
  }

  @override
  CrudFormController<Tag> createController() {
    return TagFormController();
  }

  @override
  List<Widget> createFormFields(BuildContext context) {
    return [
      Text(AppLocalizations.of(context)!.name),
      TextFormField(
        enabled: !widget.inProgress,
        controller: _nameController,
        keyboardType: TextInputType.name,
        focusNode: _nameFocusNode,
        autofocus: true,
        validator: (val) {
          if(val == null || val.isEmpty){
            _nameFocusNode.requestFocus();
            return AppLocalizations.of(context)!.fieldRequired;
          }
          return null;
        },
        onSaved: (val) {
          setState(() {
            widget.model.name = val!.trim();
          });
        },
      ),
      Text(AppLocalizations.of(context)!.active),
      Switch(
          value: widget.model.active,
          onChanged: widget.inProgress ? null : (value) {
            setState(() {
              widget.model.active = value;
            });
          }
      )
    ];
  }

  @override
  String getTitle(BuildContext context) {
    return AppLocalizations.of(context)!.tag;
  }

}