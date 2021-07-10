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
  bool buttonDisplay = true;
  bool isUpdate = false;

  void updateResult(String result) {
    if (selectedCard == Select.numberSelected) {
      clearTimeNumber = double.parse(result);
      if (TopclearTimeNumber == "00.00") {
        TopclearTimeNumber = clearTimeNumber.toString() + "s";
      } else if (double.parse(TopclearTimeNumber) > clearTimeNumber) {
        TopclearTimeNumber = clearTimeNumber.toString() + "s";
      }
    } else if (selectedCard == Select.uppercaseSelected) {
      clearTimeUppercase = double.parse(result);
      if (TopclearTimeUppercase == "00.00") {
        TopclearTimeUppercase = clearTimeUppercase.toString() + "s";
      } else if (double.parse(TopclearTimeUppercase) > clearTimeUppercase) {
        TopclearTimeUppercase = clearTimeUppercase.toString() + "s";
      }
    } else if (selectedCard == Select.childSelected) {
      clearTimeChild = double.parse(result);
      if (TopclearTimeChild == "00.00") {
        TopclearTimeChild = clearTimeChild.toString() + "s";
      } else if (double.parse(TopclearTimeChild) > clearTimeChild) {
        TopclearTimeChild = clearTimeChild.toString() + "s";
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
          .orderBy('time', descending: false)
          .snapshots();
      notifyListeners();
    } else if (selectedCard == Select.uppercaseSelected) {
      snapshots = _firestore
          .collection('UpperCase')
          .orderBy('time', descending: false)
          .snapshots();
      notifyListeners();
    } else if (selectedCard == Select.childSelected) {
      snapshots = _firestore
          .collection('child')
          .orderBy('time', descending: false)
          .snapshots();
      notifyListeners();
    }

    snapshots.listen((snapshot) {
      indexNumber = 0;
      final docs = snapshot.docs;
      for (var scores in docs) {
        final nickName = scores.data()['name'];
        final time = scores.data()['time'];
        if (nickName != null) {
          if (nickName != "") {
            if (indexNumber <= 4) {
              indexNumber += 1;
              final scoreBunddle = ScoreBunddle(
                nickName: nickName,
                time: time,
                indexNumber: indexNumber,
              );

              scoreBubbles.add(scoreBunddle);
              notifyListeners();
            }
          }
        }
      }
    });
  }

   void fetchScore() {
    Stream<QuerySnapshot> number;
    Stream<QuerySnapshot> upperCase;
    Stream<QuerySnapshot> child;
    isUpdate = false;
    number = _firestore
        .collection('number')
        .orderBy('time', descending: true)
        .snapshots();

    number.listen((snapshot) {
      TopclearTimeNumber = "00.00";
      final docs = snapshot.docs;
      for (var scores in docs) {
        final nickName = scores.data()['name'];
        if (this.nickName == nickName) {
          isUpdate = true;
          double kclearTimeNumber = double.parse(scores.data()['time']);
          if (kclearTimeNumber < double.parse(TopclearTimeNumber) || TopclearTimeNumber == "00.00") {
            TopclearTimeNumber = kclearTimeNumber.toString();

          }
        }
      }
      notifyListeners();
    });

    upperCase = _firestore
        .collection('UpperCase')
        .orderBy('time', descending: true)
        .snapshots();

    upperCase.listen((snapshot) {
      TopclearTimeUppercase = "00.00";
      final docs = snapshot.docs;
      for (var scores in docs) {
        final nickName = scores.data()['name'];
        if (this.nickName == nickName) {
          isUpdate = true;
          double kTopclearTimeUppercase = double.parse(scores.data()['time']);
          if (kTopclearTimeUppercase > double.parse(TopclearTimeUppercase) || TopclearTimeUppercase == "00.00" ) {
            TopclearTimeUppercase = kTopclearTimeUppercase.toString();
          }
        }
      }
      notifyListeners();
    });

    child = _firestore
        .collection('child')
        .orderBy('time', descending: true)
        .snapshots();

    child.listen((snapshot) {
      TopclearTimeChild = "00.00";
      final docs = snapshot.docs;
      for (var scores in docs) {
        final nickName = scores.data()['name'];
        if (this.nickName == nickName) {
          isUpdate = true;
          double kTopclearTimeChild = double.parse(scores.data()['time']);
          if (kTopclearTimeChild > double.parse(TopclearTimeChild)|| TopclearTimeChild == "00.00") {
            TopclearTimeChild = kTopclearTimeChild.toString();
          }

        }
      }
      notifyListeners();
    });
  }

  void updateDisplay() {
    this.nickName = nickName;
    if (this.nickName == "") {
      buttonDisplay = false;
    } else {
      buttonDisplay = true;
    }
    notifyListeners();
  }
}
