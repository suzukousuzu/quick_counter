import 'package:flutter/material.dart';
import 'package:quick_counter/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_counter/widget/score_bubble.dart';

enum Select { numberSelected, uppercaseSelected, childSelected }

class SelectData extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<ScoreBunddle> scoreBubbles = [];
  Select selectedCard = Select.numberSelected;
  double clearTimeNumber = 00.00;
  String TopclearTimeNumber = "---";
  double clearTimeUppercase = 00.00;
  String TopclearTimeUppercase = "---";
  double clearTimeChild = 00.00;
  String TopclearTimeChild = "---";
  String nickName;
  int indexNumber = 0;

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

  void fetchName() {
    scoreBubbles = [];
    Stream<QuerySnapshot> snapshots;
    if (selectedCard == Select.numberSelected) {
      snapshots = _firestore
          .collection('number')
          .orderBy('time', descending: true)
          .snapshots();
    } else if (selectedCard == Select.uppercaseSelected) {
      snapshots = _firestore
          .collection('UpperCase')
          .orderBy('ti,e', descending: true)
          .snapshots();
    } else if (selectedCard == Select.childSelected) {
      snapshots = _firestore
          .collection('child')
          .orderBy('time', descending: true)
          .snapshots();
    }

    snapshots.listen((snapshot) {
      indexNumber = 0;
      final docs = snapshot.docs;
      for (var scores in docs) {
        final nickName = scores.data()['name'];
        final tapScore = scores.data()['time'];
        if (nickName != null) {
          if (nickName != "") {
            if (indexNumber <= 4) {
              indexNumber += 1;
              final scoreBunddle = ScoreBunddle(
                nickName: nickName,
                score: tapScore,
                indexNumber: indexNumber,
              );
              scoreBubbles.add(scoreBunddle);
            }
          }
        }
      }
    });
    notifyListeners();
  }
}
