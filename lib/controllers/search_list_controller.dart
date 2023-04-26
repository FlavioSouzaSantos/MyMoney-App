
import 'package:flutter/material.dart';
import 'package:mymoney/dao/crud_dao.dart';

class SearchListController<T> extends ValueNotifier<SearchListControllerState> {

  CrudDao<T> crudDao;
  String fieldName;
  T? itemSelected;
  List<T> provider = <T>[];

  SearchListController(this.crudDao, this.fieldName) : super(SearchListControllerState.started);

  Future<void> search(String? strSearch) async {
    try{
      value = SearchListControllerState.loading;
      if(strSearch != null && strSearch.isNotEmpty){
        provider = await crudDao.findByField(fieldName, "LIKE", '%$strSearch%');
      }else {
        provider = await crudDao.findAll();
      }
      value = SearchListControllerState.success;
    }catch(e){
      value = SearchListControllerState.error;
    }
  }
}

enum SearchListControllerState {
  started,
  loading,
  success,
  error
}