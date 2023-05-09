import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/dialog.dart';
import 'package:mymoney/controllers/crud_form_controller.dart';

abstract class CrudForm<T> extends StatefulWidget {

  T model;
  bool inProgress=false;

  CrudForm({super.key, required this.model});
}

abstract class CrudStateForm<T> extends State<CrudForm<T>> {

  late final CrudFormController<T> _controller;
  final GlobalKey<FormState> _formKey = GlobalKey();

  CrudFormController<T> createController();
  List<Widget> createFormFields(BuildContext context);
  String getTitle(BuildContext context);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = createController();
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
          getTitle(context),
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              color: Colors.white
          ),
        ),
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
                ...createFormFields(context)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
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
            await _controller.save(widget.model),
            Navigator.pop(context)
          }
      );
    }
  }

}