import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:input_calculator/input_calculator.dart';
import 'package:mymoney/components/crud_form.dart';
import 'package:mymoney/components/search_list_account.dart';
import 'package:mymoney/components/search_list_credit_card_type.dart';
import 'package:mymoney/controllers/credit_card_form_controller.dart';
import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/models/credit_card.dart';

class CreditCardForm extends CrudForm<CreditCard> {

  CreditCardForm({super.key, required super.model});

  @override
  _creditCardFormState createState()  => _creditCardFormState();

}

class _creditCardFormState extends CrudStateForm<CreditCard> {

  final FocusNode _nameFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final List<int> days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31];

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
  CrudFormController<CreditCard> createController() {
    return CreditCardFormController();
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

      Text(AppLocalizations.of(context)!.creditCardType),
      ActionChip(
        label: Text(widget.model.type?.name??AppLocalizations.of(context)!.placeholderCreditCardType),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20)
                ),
              ),
              builder: (ctx) => SearchListCreditCardType(
                selectedItem: widget.model.type,
                onSelectedItem: <CreditCardType>(item) {
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

      Text(AppLocalizations.of(context)!.account),
      ActionChip(
        label: Text(widget.model.account?.name??AppLocalizations.of(context)!.placeholderAccount),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20)
                ),
              ),
              builder: (ctx) => SearchListAccount(
                selectedItem: widget.model.account,
                onSelectedItem: <Account>(item) {
                  setState(() {
                    widget.model.account = item;
                    widget.model.accountId = item?.id??0;
                  });
                  Navigator.pop(ctx);
                },
              )
          );
        },
      ),

      Text(AppLocalizations.of(context)!.limitValue),
      CalculatorTextFormField(
        initialValue: widget.model.limitValue,
        title: AppLocalizations.of(context)!.limitValue,
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
            widget.model.limitValue = value??0;
          });
        },
      ),

      Text(AppLocalizations.of(context)!.closingDay),
      DropdownButton<int>(
        value: widget.model.closingDay,
        items: days
          .map((item) => DropdownMenuItem<int>(
            value: item,
            child: Text('$item')
           )
          ).toList(),
        onChanged: (value) {
          setState(() {
            widget.model.closingDay = value??0;
          });
        }
      ),

      Text(AppLocalizations.of(context)!.payingDay),
      DropdownButton<int>(
          value: widget.model.payingDay,
          items: days
              .map((item) => DropdownMenuItem<int>(
              value: item,
              child: Text('$item')
          )
          ).toList(),
          onChanged: (value) {
            setState(() {
              widget.model.payingDay = value??0;
            });
          }
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
    return AppLocalizations.of(context)!.creditCard;
  }

}