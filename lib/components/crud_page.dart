import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/dialog.dart';
import 'package:mymoney/controllers/crud_page_controller.dart';

abstract class CrudPage<T> extends StatefulWidget {

  CrudPage({super.key});

}

abstract class CrudPageState<T> extends State<CrudPage<T>> {

  late CrudPageController<T> controller;

  CrudPageController<T> createController();
  Widget navigateToForm(BuildContext context, T item);
  String getTitle(BuildContext context);
  T createNewItem();
  String getItemName(T item);
  int getItemId(T item);
  Widget? getItemLeading(T item);

  @override
  void initState() {
    super.initState();
    controller = createController();
    controller.addListener(() {
      if(controller.value == PageState.loadedItem){
        Navigator.push(context, MaterialPageRoute(builder: (context) => navigateToForm(context, controller.item as T)),
        ).then((value) => controller.loading());
      }else{
        setState(() {});
      }
    });
    _startLoading();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
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
      body: Column(
        children: [
          Expanded(
              child: _createBodyFromState(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigateToForm(context, createNewItem())),
          ).then((value) => controller.loading());
        },
      ),
    );
  }

  _startLoading() async {
    controller.loading();
  }

  Widget _createBodyFromState(){
    switch(controller.value){
      case PageState.loading:
      case PageState.deleting:
        return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator()
        );
      case PageState.error:
        return Container(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.error,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        );
      default:
        return RefreshIndicator(
            onRefresh: () => controller.loading(),
            child: ListView.separated(
              itemCount: controller.provider.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(getItemName(controller.provider[index])),
                  leading: getItemLeading(controller.provider[index]),
                  tileColor: Colors.white,
                  onTap: () {
                    controller.loadById(getItemId(controller.provider[index]));
                  },
                  onLongPress: () {
                    showQuestionDialog(
                        context: context,
                        message: AppLocalizations.of(context)!.messageConfirmDeleteRecord,
                        yesFunction: () {
                          controller.delete(getItemId(controller.provider[index]))
                              .then((value) => controller.loading());
                        }
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 2,),
            ),
        );
    }
  }
}