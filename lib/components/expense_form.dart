import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:input_calculator/input_calculator.dart';
import 'package:mymoney/components/dialog.dart';
import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/controllers/expense_form_controller.dart';
import 'package:mymoney/dao/transaction_dao.dart';
import 'package:mymoney/models/repeat_transaction.dart';
import 'package:mymoney/models/transaction.dart';

class ExpenseForm extends StatefulWidget {

  final Transaction model;
  final RepeatTransaction? repeat;
  bool inProgress=false;

  ExpenseForm({super.key, required this.model, this.repeat});

  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final ExpenseFormController _controller = ExpenseFormController(dao: TransactionDao());
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      switch (_controller.value) {
        case CrudFormState.saving:
          widget.inProgress = true;
          break;
        default:
          widget.inProgress = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.expense,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              color: Colors.white
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: widget.inProgress,
                    child: const LinearProgressIndicator()
                ),

                Text(AppLocalizations.of(context)!.value),
                CalculatorTextFormField(
                  initialValue: widget.model.value,
                  title: AppLocalizations.of(context)!.value,
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
                      widget.model.value = value??0;
                    });
                  },
                ),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: widget.inProgress ? null :  () => _validateAndSave(context),
        child: const Icon(Icons.check),
      ),
    );
  }

  _validateAndSave(BuildContext context){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

      showQuestionDialog(
          context: context,
          message: AppLocalizations.of(context)!.messageConfirmSaveRecord,
          yesFunction: () async => {
            await _controller.save(widget.model, widget.repeat),
            Navigator.pop(context)
          }
      );
    }
  }
}