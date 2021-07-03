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
      create: (context) => SelectData(),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //問題パターン表示部分
               TestPatern(clearSecondNumber: model.TopclearTimeNumber, clearSecondUpperCase: model.TopclearTimeUppercase,clearSecondChild: model.TopclearTimeChild,),
                Center(
                  child: Text(
                    'Quick',
                    style: kTextStyle,
                  ),
                ),
                Center(child: Text('Countre', style: kTextStyle)),
                Container(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 60.0, right: 60.0, bottom: 30.0),
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
                        },
                        text: ' 1-30',
                        width: model.selectedCard == Select.numberSelected
                            ? kActiveBorderWidth
                            : kInActiveBorderWidth,
                      ),
                    ),
                    Expanded(
                      child: SelectedCard(
                        onPress: () {
                          model.selectUppercase();
                        },
                        text: 'A-Z',
                        width: model.selectedCard == Select.uppercaseSelected
                            ? kActiveBorderWidth
                            : kInActiveBorderWidth,
                      ),
                    ),
                    Expanded(
                      child: SelectedCard(
                        onPress: () {
                          model.selectChild();
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
                  height: 30.0,
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
                )
              ],
            );
          }),
        ),
      )),
    );
  }
}
