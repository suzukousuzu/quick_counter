import 'package:flutter/material.dart';
import 'package:quick_counter/constants.dart';

class SelectedCard extends StatelessWidget {
  SelectedCard({@required this.onPress, this.text, this.width});

  final Function onPress;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF1D1E33),
            border: Border.all(color: Colors.red, width: width),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: kTextStyle,
            ),
          )),
    );
  }
}