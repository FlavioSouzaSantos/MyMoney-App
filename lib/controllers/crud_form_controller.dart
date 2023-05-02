import 'package:flutter/cupertino.dart';
import 'package:mymoney/dao/crud_dao.dart';

abstract class CrudFormController<T> extends ValueNotifier<CrudFormState> {

  final CrudDao<T> crudDao;

  CrudFormController({required this.crudDao}) : super(CrudFormState.started);

  Future<void> save(T model) async {
    value = CrudFormState.saving;
    int? id = getItemId(model);
    if(id != null){
      model = await beforeUpdateItem(model);
      await crudDao.update(model, id);
    }else{
      model = await beforeInsertItem(model);
      await crudDao.insert(model);
    }
    value = CrudFormState.started;
  }

  int? getItemId(T item);
  Future<T> beforeInsertItem(T item) async => item;
  Future<T> beforeUpdateItem(T item) async => item;

}

enum CrudFormState {
  started,
  saving,
  error
}