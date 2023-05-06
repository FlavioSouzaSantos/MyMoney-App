import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/crud_form.dart';
import 'package:mymoney/controllers/credit_card_type_form_controller.dart';
import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/models/credit_card_type.dart';

class CreditCardTypeForm extends CrudForm<CreditCardType> {

  CreditCardTypeForm({required super.model});

  @override
  _CreditCardTypeFormState createState() => _CreditCardTypeFormState();

}

class _CreditCardTypeFormState extends CrudStateForm<CreditCardType> {

  final FocusNode _nameFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.model.name;
  }

  @override
  CrudFormController<CreditCardType> createController() {
    return CreditCardTypeFormControlle();
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
      Row(
        children: [
          Text(AppLocalizations.of(context)!.active),
          Switch(
              value: widget.model.active,
              onChanged: widget.inProgress ? null : (value) {
                setState(() {
                  widget.model.active = value;
                });
              }
          )
        ],
      )
    ];
  }

  @override
  String getTitle(BuildContext context) {
    return AppLocalizations.of(context)!.creditCardType;
  }

}