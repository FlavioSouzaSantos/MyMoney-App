import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mymoney/components/home_page.dart';
import 'package:mymoney/dao/database_config.dart';
import 'package:mymoney/dao/settings_dao.dart';
import 'package:mymoney/models/settings.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseConfig().getDatabase();

  var settings = await SettingsDao().getSettings();
  if(settings == null){
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    settings = Settings(uuidInstalation: const Uuid().v4(), appVersion: packageInfo.version);
    await SettingsDao().insert(settings);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyMoney App',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt')
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
