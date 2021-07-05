import 'package:flutter/material.dart';
import 'package:quick_counter/constants.dart';
import 'package:quick_counter/model/select_data.dart';

class TestPatern extends StatelessWidget {
  TestPatern(
      {this.clearSecondNumber,
      this.clearSecondUpperCase,
      this.clearSecondChild});

  String clearSecondNumber = "";
  String clearSecondUpperCase = "";
  String clearSecondChild = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        children: [
          TableRow(children: [
            Center(
                child: Text(
              '1-30',
              style: kTopTextStyle,
            )),
            Center(
                child: Text(
              'A-Z',
              style: kTopTextStyle,
            )),
            Center(
                child: Text(
              'a-z',
              style: kTopTextStyle,
            )),
          ]),
          TableRow(children: [
            Center(
              child: (() {
                if (clearSecondNumber == "00.00") {
                  return Text(
                    '---',
                    style: kTopTextTimerStyle,
                  );
                } else {
                  return Text(
                    clearSecondNumber + "s",
                    style: kTopTextTimerStyle,
                  );
                }
              })(),
            ),
            Center(
              child: (() {
                if (clearSecondUpperCase == "00.00") {
                  return Text(
                    '---',
                    style: kTopTextTimerStyle,
                  );
                } else {
                  return Text(
                    clearSecondUpperCase + "s",
                    style: kTopTextTimerStyle,
                  );
                }
              })(),
            ),
            Center(
              child: (() {
                if (clearSecondChild == "00.00") {
                  return Text(
                    '---',
                    style: kTopTextTimerStyle,
                  );
                } else {
                  return Text(
                    clearSecondChild + "s",
                    style: kTopTextTimerStyle,
                  );
                }
              })(),
            ),
          ])
        ],
      ),
    );
  }
}
