import 'package:flutter/material.dart';
import 'package:quick_counter/constants.dart';


class ScoreBunddle extends StatelessWidget {
  ScoreBunddle({this.nickName, this.time, this.indexNumber});

  final String nickName;
  final String time;
  final int indexNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          indexNumber.toString()+".",
          style: leadersBoardText,
        ),
        Text(
          nickName + ":",
          style: leadersBoardText,
        ),
        Text(
          time,
          style: leadersBoardText,
        )
      ],
    );
  }
}
