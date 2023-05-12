import 'package:flutter/widgets.dart';
import 'package:mymoney/controllers/crud_form_controller.dart';
import 'package:mymoney/dao/settings_dao.dart';
import 'package:mymoney/dao/transaction_dao.dart';
import 'package:mymoney/models/repeat_transaction.dart';
import 'package:mymoney/models/settings.dart';
import 'package:mymoney/models/transaction.dart';

class ExpenseFormController extends ValueNotifier<CrudFormState> {
  final TransactionDao dao;

  ExpenseFormController({required this.dao}) : super(CrudFormState.started);

  Future<void> save(Transaction model, RepeatTransaction? repeat) async {
    value = CrudFormState.saving;
    if(model.id != null){
      model.syncRelease = true;
      model.lastUpdate = DateTime.now();
      await dao.update(model, model.id!!);
    }else{
      Settings? settings = await SettingsDao().getSettings();
      model.userId = settings?.uuidLogged??'';
      if(repeat != null){
        await dao.insertWithRepeat(model, repeat);
      }else{
        await dao.insert(model);
      }
    }
    value = CrudFormState.started;
  }
}