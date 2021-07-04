import 'package:flutter/material.dart';
import 'dart:async';
import 'package:quick_counter/model/select_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CounterModel extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  String topText;
  bool isEnd = false;
  bool isComplete = false;
  bool isPushed = true;

  String timeDisplay = '00.00';
  var swatch = Stopwatch();

  void updateCurrentNumber(int testText) {
    if (topText == testText.toString() && topText != "3") {
      topText = (testText + 1).toString();
    } else if (topText == testText.toString() && topText == "3") {
      isComplete = true;
      isPushed = false;
    } else {
      isEnd = true;
      isPushed = false;
    }
    notifyListeners();
  }

  void updateCurrentUppercase(String testText) {
    if (topText == testText) {
      if (testText == "A") {
        topText = "B";
      } else if (testText == "B") {
        topText = "C";
      } else if (testText == "C") {
        topText = "D";
      } else if (testText == "D") {
        topText = "E";
      } else if (testText == "E") {
        topText = "F";
      } else if (testText == "F") {
        topText = "G";
      } else if (testText == "G") {
        topText = "H";
      } else if (testText == "H") {
        topText = "I";
      } else if (testText == "I") {
        topText = "J";
      } else if (testText == "J") {
        topText = "K";
      } else if (testText == "K") {
        topText = "L";
      } else if (testText == "L") {
        topText = "M";
      } else if (testText == "M") {
        topText = "N";
      } else if (testText == "N") {
        topText = "O";
      } else if (testText == "O") {
        topText = "P";
      } else if (testText == "P") {
        topText = "Q";
      } else if (testText == "Q") {
        topText = "R";
      } else if (testText == "R") {
        topText = "S";
      } else if (testText == "S") {
        topText = "T";
      } else if (testText == "T") {
        topText = "U";
      } else if (testText == "U") {
        topText = "V";
      } else if (testText == "V") {
        topText = "W";
      } else if (testText == "W") {
        topText = "X";
      } else if (testText == "X") {
        topText = "Y";
      } else if (testText == "Y") {
        topText = "Z";
      } else if (testText == "Z") {
        isComplete = true;
      }
    }
    else if (topText != testText && isComplete == false) {
      isEnd = true;
    }
    notifyListeners();
  }

  void updateCurrentChild(testText) {
    if (topText == testText) {
      if (testText == "a") {
        topText = "b";
      } else if (testText == "b") {
        topText = "c";
      } else if (testText == "c") {
        topText = "d";
      } else if (testText == "d") {
        topText = "e";
      } else if (testText == "e") {
        topText = "f";
      } else if (testText == "f") {
        topText = "g";
      } else if (testText == "g") {
        topText = "h";
      } else if (testText == "h") {
        topText = "i";
      } else if (testText == "i") {
        topText = "j";
      } else if (testText == "j") {
        topText = "k";
      } else if (testText == "k") {
        topText = "l";
      } else if (testText == "l") {
        topText = "m";
      } else if (testText == "m") {
        topText = "n";
      } else if (testText == "n") {
        topText = "o";
      } else if (testText == "o") {
        topText = "p";
      } else if (testText == "p") {
        topText = "q";
      } else if (testText == "q") {
        topText = "r";
      } else if (testText == "r") {
        topText = "s";
      } else if (testText == "s") {
        topText = "t";
      } else if (testText == "t") {
        topText = "u";
      } else if (testText == "u") {
        topText = "v";
      } else if (testText == "v") {
        topText = "w";
      } else if (testText == "w") {
        topText = "x";
      } else if (testText == "x") {
        topText = "y";
      } else if (testText == "y") {
        topText = "z";
      } else if (testText == "z") {
        isComplete = true;
      }
    }
    else if (topText != testText && isComplete == false){
      isEnd = true;
    }
    notifyListeners();
  }

  Future<void> startStopWatch() async {
    await swatch.start();
    startTimer();
    notifyListeners();
  }

  void startTimer() {
    Timer(Duration(milliseconds: 1), keepRunning);
    notifyListeners();
  }

  void keepRunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    timeDisplay = swatch.elapsed.inSeconds.toString().padLeft(2, "0") +
        "." +
        (swatch.elapsed.inMicroseconds % 60).toString().padLeft(2, "0");
    notifyListeners();
  }

  void stopTimer()  {
    swatch.stop();
    notifyListeners();
  }

  Future addScore(String nickName, Select select) async {
    if (select == Select.numberSelected) {
      await FirebaseFirestore.instance
          .collection('number')
          .add({'name': nickName, 'time': timeDisplay});
      notifyListeners();
    } else if (select == Select.uppercaseSelected) {
      await FirebaseFirestore.instance
          .collection('UpperCase')
          .add({'name': nickName, 'time': timeDisplay});
      notifyListeners();
    } else if (select == Select.childSelected) {
      await FirebaseFirestore.instance
          .collection('child')
          .add({'name': nickName, 'time': timeDisplay});
      notifyListeners();
    }

  }
}
