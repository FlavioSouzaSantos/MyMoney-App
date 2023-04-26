import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/controllers/search_list_controller.dart';
import 'package:mymoney/dao/crud_dao.dart';

abstract class SearchList<T> extends StatefulWidget {

  CrudDao<T> crudDao;
  String fieldName;
  T? selectedItem;

  SearchList({
    super.key,
    required this.crudDao,
    required this.fieldName,
    required this.onSelectedItem,
    this.selectedItem});

  @override
  _SearchListState<T> createState() => _SearchListState<T>();

  String getItemLabel(T item);
  final void Function(T item) onSelectedItem;
}

class _SearchListState<T> extends State<SearchList<T>> {

  late final SearchListController<T> _controller;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = SearchListController<T>(widget.crudDao, widget.fieldName);
    _controller.addListener(() {
      setState(() {});
    });
    _searchController.addListener(() {
      _startLoading();
    });
    _startLoading();
  }

  _startLoading() async {
    _controller.search(_searchController.text.trim().toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.search),
                Expanded(
                    child: TextField(
                      controller: _searchController,
                ))
              ],
            ),
            Expanded(child: _createContentFromState(),)
          ],
        )
      ),
    );
  }

  Widget _createContentFromState(){
    switch(_controller.value){
      case SearchListControllerState.loading:
        return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator()
        );
      case SearchListControllerState.error:
        return Container(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.error,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        );
      default:
        return RefreshIndicator(
          onRefresh: () => _controller.search(_searchController.value.text),
          child: ListView.separated(
            itemCount: _controller.provider.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(widget.selectedItem != null && widget.selectedItem == _controller.provider[index] ? Icons.radio_button_checked_outlined : Icons.circle_outlined),
                title: Text(widget.getItemLabel(_controller.provider[index])),
                selected: widget.selectedItem != null ? widget.selectedItem == _controller.provider[index] : false,
                onTap: () {
                  widget.onSelectedItem.call(_controller.provider[index]);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 2),
          ),
        );
    }
  }
}