import 'package:flutter/material.dart';
import 'package:quick_counter/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Select { numberSelected, uppercaseSelected, childSelected }

class SelectData extends ChangeNotifier {
  Select selectedCard = Select.numberSelected;
  double clearTimeNumber = 00.00;
  String TopclearTimeNumber = "---";
  double clearTimeUppercase = 00.00;
  String TopclearTimeUppercase = "---";
  double clearTimeChild = 00.00;
  String TopclearTimeChild = "---";
  String nickName;

  void updateResult(String result) {
    if (selectedCard == Select.numberSelected) {
      clearTimeNumber = double.parse(result);
      if(TopclearTimeNumber == "---") {
        TopclearTimeNumber = clearTimeNumber.toString()+ "s";
      } else if(double.parse(TopclearTimeNumber) > clearTimeNumber) {
        TopclearTimeNumber = clearTimeNumber.toString() + "s";
      }
    } else if (selectedCard == Select.uppercaseSelected) {
      clearTimeUppercase = double.parse(result);
      if(TopclearTimeUppercase == "---") {
        TopclearTimeUppercase = clearTimeUppercase.toString()+ "s";
      }else if(double.parse(TopclearTimeUppercase) > clearTimeUppercase) {
        TopclearTimeUppercase = clearTimeUppercase.toString()+ "s";
      }
    } else if (selectedCard == Select.childSelected) {
      clearTimeChild = double.parse(result);
      if(TopclearTimeChild == "---") {
        TopclearTimeChild = clearTimeChild.toString()+ "s";
      }else if(double.parse(TopclearTimeChild) > clearTimeChild) {
        TopclearTimeChild = clearTimeChild.toString()+ "s";
      }

    }
    notifyListeners();
  }

  void selectNumber() {
    selectedCard = Select.numberSelected;
    notifyListeners();
  }

  void selectUppercase() {
    selectedCard = Select.uppercaseSelected;
    notifyListeners();
  }

  void selectChild() {
    selectedCard = Select.childSelected;
    notifyListeners();
  }

  Future<void> setName(String nickName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nickName);
    notifyListeners();
  }

  Future<void> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.nickName = prefs.getString('name') ?? '';
    notifyListeners();
  }
}
