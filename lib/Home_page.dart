import 'package:applocalization/app_local.dart';
import 'package:applocalization/l10n/l10n.dart';
import 'package:applocalization/setting_provider.dart';
import 'package:applocalization/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? val;
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    SettingProvider prov = Provider.of(context);

    List<Map<String, dynamic>> myColors = [
      {"name": AppLocal.loc.blue, "myColor": Colors.blue},
      {"name": AppLocal.loc.green, "myColor": Colors.green},
      {"name": AppLocal.loc.purple, "myColor": Colors.purple},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocal.loc.application),
      ),
      body: Column(
        children: [
          Wrap(
            children: List.generate(L10n.all.length, (index) {
              return RadioListTile(
                title: Text(
                  L10n.all[index].languageCode == 'en'
                      ? AppLocal.loc.langEN
                      : AppLocal.loc.langAR,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                value: L10n.all[index].languageCode,
                groupValue: prov.local,
                onChanged: (String? value) {
                  SharedPref.addLang(value!);
                  prov.updateLocal(value);
                },
              );
            }),
          ),
          Center(
            child: Text(
              AppLocal.loc.setting,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Wrap(
            children: List.generate(
                myColors.length,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          val = myColors[index]["myColor"].value;
                          idx = index;
                          SharedPref.addThemeColor(val);
                          prov.updateThemeClr(val);
                        },
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: myColors[index]["myColor"],
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.check,
                                color: idx == index
                                    ? Colors.white
                                    : myColors[index]["myColor"])),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
