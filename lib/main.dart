import 'package:applocalization/Home_page.dart';
import 'package:applocalization/l10n/l10n.dart';
import 'package:applocalization/setting_provider.dart';
import 'package:applocalization/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.getLang();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingProvider())
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            supportedLocales: L10n.all,
            locale: Locale(Provider.of<SettingProvider>(context).local ??
                SharedPref.lang ??
                'en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            title: 'Localization',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color(Provider.of<SettingProvider>(context).themeClr ??
                  SharedPref.themeClr ??
                  Colors.blue.value),
            )),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
