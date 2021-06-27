import 'package:flutter/material.dart';
import 'package:quick_counter/constants.dart';

class TestCard extends StatelessWidget {
  TestCard({this.onPress, this.number});

  final Function onPress;
  final String number;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPress,
      child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF1D1E33),
            border: Border.all(color: Colors.red),
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
