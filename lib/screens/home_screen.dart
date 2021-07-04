import 'package:flutter/material.dart';
import 'package:quick_counter/constants.dart';
import 'package:quick_counter/widget/selected_card.dart';
import 'package:quick_counter/widget/test_pattern.dart';
import 'test_screen.dart';
import 'package:quick_counter/model/select_data.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class HomeScreen extends StatelessWidget {
  String result;
  String nickName;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectData()..fetchName(),
      child: SafeArea(
          child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/blackhole (2).jpeg'),
            fit: BoxFit.cover,
          )),
          child: Consumer<SelectData>(builder: (context, model, child) {
            model.getName();
            return Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //問題パターン表示部分
                TestPatern(
                  clearSecondNumber: model.TopclearTimeNumber,
                  clearSecondUpperCase: model.TopclearTimeUppercase,
                  clearSecondChild: model.TopclearTimeChild,
                ),
                Center(
                  child: Text(
                    'Quick',
                    style: KTitleTextStyle,
                  ),
                ),
                Center(child: Text('Countre', style: KTitleTextStyle)),
                Container(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 60.0, right: 60.0, bottom: 10.0),
                  child: TextField(
                    controller: TextEditingController(text: model.nickName),
                    onChanged: (value) {
                      nickName = value;
                      model.setName(nickName);
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter NickName',
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SelectedCard(
                        onPress: () {
                          model.selectNumber();
                          model.fetchName();
                        },
                        text: ' 1-30',
                        width: model.selectedCard == Select.numberSelected
                            ? kActiveBorderWidth
                            : kInActiveBorderWidth,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: SelectedCard(
                        onPress: () {
                          model.selectUppercase();
                          model.fetchName();
                        },
                        text: 'A-Z',
                        width: model.selectedCard == Select.uppercaseSelected
                            ? kActiveBorderWidth
                            : kInActiveBorderWidth,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: SelectedCard(
                        onPress: () {
                          model.selectChild();
                          model.fetchName();
                        },
                        text: 'a-z',
                        width: model.selectedCard == Select.childSelected
                            ? kActiveBorderWidth
                            : kInActiveBorderWidth,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                SelectedCard(
                  onPress: () async {
                    result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TestScreen(selectedCard: model.selectedCard)));
                    model.updateResult(result);
                  },
                  text: 'PLAY!',
                  width: kInActiveBorderWidth,
                ),
                SizedBox(
                  height: 70.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              child: Text(
                                "SOUND EFFECT:",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "----------",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "Font:",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "SourceSansPro",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "Pacifico",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "CON:",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "KOTA",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "BACKGROUND:",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "BLACKHOLE",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "SPECIAL THANKS:",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "KOTA SUZUKI",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              )),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                              width: double.infinity,
                              child: Text(
                                "(c)2019 KotaSuzuki Inc.",
                                textAlign: TextAlign.left,
                                style: leadersBoardText,
                              ))
                        ],
                      ),
                    ),
                    model.scoreBubbles == null
                        ? Container()
                        : ConstrainedBox(
                            constraints: BoxConstraints.expand(
                                height: 180.0, width: 200.0),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF1D1E33),
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(children: [
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    "LeaderBoard",
                                    textAlign: TextAlign.left,
                                    style: leaderBoardTitle,
                                  ),
                                ),
                                ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: model.scoreBubbles,
                                )
                              ]),
                            ),
                          ),
                  ],
                ),
              ],
            );
          }),
        ),
      )),
    );
  }
}
