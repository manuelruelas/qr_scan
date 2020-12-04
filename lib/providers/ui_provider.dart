import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier{
  int _selectedOption= 0;

  int get selectedOption=> _selectedOption;

  set selectedOption(int option){
    _selectedOption = option;
    notifyListeners();
  }
}