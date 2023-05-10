import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mymoney/components/balance_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mymoney/components/expense_form.dart';
import 'package:mymoney/components/plus_options.dart';
import 'package:mymoney/components/transaction_list_and_filter.dart';
import 'package:mymoney/dao/database_config.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  var menuIndex = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createContentFromMenuItem(widget.menuIndex),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() => widget.menuIndex = 0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: widget.menuIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() => widget.menuIndex = 1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: widget.menuIndex == 1 ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() => widget.menuIndex = 2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: widget.menuIndex == 2 ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() => widget.menuIndex = 3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.more_horiz,
                          color: widget.menuIndex == 3 ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Theme.of(context).primaryColor,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.money_off,
              color: Colors.red,
            ),
            backgroundColor: Colors.white,
            label: AppLocalizations.of(context)!.expense,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExpenseForm()),
              );
            }
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.credit_card_off,
              color: Colors.orange
            ),
            backgroundColor: Colors.white,
            label: AppLocalizations.of(context)!.expenseCard,
            onTap: () {

            }
          ),
          SpeedDialChild(
            child: const Icon(
            Icons.money,
              color: Colors.blue
            ),
            backgroundColor: Colors.white,
            label: AppLocalizations.of(context)!.revenue,
            onTap: () {

            }
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget? _createContentFromMenuItem(int menuIndex) {
    switch(menuIndex){
      case 0:
        return ListView(
          children: const [
            BalanceCard(balance: 1000.58, revenue: 10, expense: 5),
          ],
        );
      case 1:
        return TransactionListAndFitler();
      case 3:
        return const PlusOptions();
      default:
        return null;
    }
  }

  @override
  void dispose() async {
    await DatabaseConfig().close();
    super.dispose();
  }
}