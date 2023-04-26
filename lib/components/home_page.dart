import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
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
      bottomNavigationBar: AnimatedBottomNavigationBar(
          bottomBarItems: [
            BottomBarItemsModel(icon: const Icon(Icons.home),
                iconSelected: Icon(Icons.home, color: Theme.of(context).primaryColor),
                dotColor: Theme.of(context).primaryColor,
                title: AppLocalizations.of(context)!.menuHome,
                titleStyle: Theme.of(context).textTheme.labelSmall,
                onTap: () => setState(() => widget.menuIndex = 0)
            ),
            BottomBarItemsModel(icon: Icon(Icons.bar_chart, color: Theme.of(context).highlightColor),
                iconSelected: Icon(Icons.bar_chart, color: Theme.of(context).primaryColor),
                dotColor: Theme.of(context).primaryColor,
                title: AppLocalizations.of(context)!.menuTransactions,
                titleStyle: Theme.of(context).textTheme.labelSmall,
                onTap: () => setState(() => widget.menuIndex = 1)
            ),
            BottomBarItemsModel(icon: const Icon(Icons.settings),
                iconSelected: Icon(Icons.settings, color: Theme.of(context).primaryColor),
                dotColor: Theme.of(context).primaryColor,
                title: AppLocalizations.of(context)!.menuSettings,
                onTap: () => setState(() => widget.menuIndex = 2)
            ),
            BottomBarItemsModel(icon: const Icon(Icons.more_horiz),
                iconSelected: Icon(Icons.more_horiz, color: Theme.of(context).primaryColor),
                dotColor: Theme.of(context).primaryColor,
                title: AppLocalizations.of(context)!.menuPlus,
                titleStyle: Theme.of(context).textTheme.labelSmall,
                onTap: () => setState(() => widget.menuIndex = 3)
            ),
          ],
          bottomBarCenterModel: BottomBarCenterModel(
            centerBackgroundColor: Theme.of(context).primaryColor,
            centerIcon: const FloatingCenterButton(
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
            centerIconChild: [
              FloatingCenterButtonChild(
                child: const Icon(
                  Icons.money_off,
                  color: AppColors.white,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ExpenseForm()),
                  );
                },
              ),
              FloatingCenterButtonChild(
                child: const Icon(
                  Icons.credit_card_off,
                  color: AppColors.white,
                ),
                onTap: () => {},
              ),
              FloatingCenterButtonChild(
                child: const Icon(
                  Icons.money,
                  color: AppColors.white,
                ),
                onTap: () => {},
              ),
            ],
          )
      ),
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