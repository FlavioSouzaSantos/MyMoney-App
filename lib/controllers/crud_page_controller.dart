
import 'package:flutter/material.dart';
import 'package:mymoney/dao/crud_dao.dart';

abstract class CrudPageController<T> extends ValueNotifier<PageState> {

  CrudPageController({required this.crudDao}) : super(PageState.started);

  CrudDao<T> crudDao;
  List<T> provider = [];
  T? item;

  Future<void> loading() async {
    try{
      value = PageState.loading;
      provider = await crudDao.findAll();
      value = PageState.success;
    }catch(e){
      value = PageState.error;
    }
  }

  Future<void> loadById(int id) async {
    try{
      value = PageState.loading;
      item = await crudDao.findById(id);
      value = PageState.loadedItem;
    }catch(e){
      value = PageState.error;
    }
  }

  Future<void> delete(int id) async {
    try {
      value = PageState.deleting;
      await crudDao.delete(id);
      value = PageState.success;
    }catch(e){
      value = PageState.error;
    }
  }
}

enum PageState {
  started,
  loading,
  deleting,
  success,
  error,
  loadedItem
}