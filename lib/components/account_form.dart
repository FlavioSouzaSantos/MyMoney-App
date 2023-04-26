import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:input_calculator/input_calculator.dart';
import 'package:mymoney/components/crud_form.dart';
import 'package:mymoney/components/dialog.dart';
import 'package:mymoney/components/search_list_account_type.dart';
import 'package:mymoney/controllers/account_form_controller.dart';
import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/models/account.dart';

class AccountForm extends CrudForm<Account> {

  AccountForm({super.key, required super.model});

  @override
  _AccountFormSate createState() => _AccountFormSate();

}

class _AccountFormSate extends CrudFormSate<Account> {

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
  CrudFormController<Account> createController() {
    return AccountFormController();
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

      Text(AppLocalizations.of(context)!.accountType),
      ActionChip(
        label: Text(widget.model.type?.name??AppLocalizations.of(context)!.placeholderAccountType),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20)
                ),
              ),
              builder: (ctx) => SearchListAccountType(
                selectedItem: widget.model.type,
                onSelectedItem: <AccountType>(item) {
                  setState(() {
                    widget.model.type = item;
                    widget.model.typeId = item?.id??0;
                  });
                  Navigator.pop(ctx);
                },
              )
          );
        },
      ),

      Text(AppLocalizations.of(context)!.initialValue),
      CalculatorTextFormField(
        initialValue: widget.model.initialValue,
        title: AppLocalizations.of(context)!.initialValue,
        validator: (val) {
          if(val == null || val.isEmpty || double.tryParse(val!) == 0){
            return AppLocalizations.of(context)!.fieldRequired;
          }
          if(double.tryParse(val!) == null){
            return AppLocalizations.of(context)!.fieldInvalid;
          }
          return null;
        },
        onSubmitted: (value) {
          setState(() {
            widget.model.initialValue = value??0;
          });
        },
      ),
    ];
  }

  @override
  String getTitle(BuildContext context) {
    return AppLocalizations.of(context)!.account;
  }
}