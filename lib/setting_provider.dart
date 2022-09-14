import 'package:flutter/cupertino.dart';

class SettingProvider extends ChangeNotifier {
  String? local;
  int? themeClr;
  updateLocal(String? lang) {
    local = lang;
    notifyListeners();
  }

  updateThemeClr(int? clr) {
    themeClr = clr;
    notifyListeners();
  }
}
