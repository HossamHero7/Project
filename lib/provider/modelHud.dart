import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier{
  bool loading=false;
  changeLoad(bool value){
    loading=value;
    notifyListeners();
  }
}