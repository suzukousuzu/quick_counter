import 'package:flutter/material.dart';
import 'package:quick_counter/constants.dart';
import 'package:quick_counter/model/counter_model.dart';

class TestTile extends StatelessWidget {

  TestTile({this.onPress,this.number,this.isEnd,this.isComplete});
  final Function onPress;
  final String number;
  final bool isEnd;
  final bool isComplete;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: (() {
              if (isEnd == true || isComplete == true) {
                return Colors.white38;
              } else {
                return Color(0xFF1D1E33);
              }
            })(),
            border: (() {
              if (isEnd == true || isComplete == true) {
                return Border.all(color: Colors.white38);
              } else {
                return  Border.all(color: Colors.red);
              }
            })(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              number,
              style: kTextStyle,
            ),
          )),
    );
  }
}
