import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quick_counter/widget/selected_card.dart';
import 'package:quick_counter/widget/test_card.dart';
import 'package:quick_counter/constants.dart';
import 'package:provider/provider.dart';
import 'package:quick_counter/model/counter_model.dart';
import 'package:quick_counter/model/select_data.dart';
import 'package:quick_counter/alphabet_data.dart';
import 'package:soundpool/soundpool.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class TestScreen extends StatelessWidget {
  TestScreen({this.selectedCard});

  final Select selectedCard;
  List randomList;

  String topText;
  Soundpool soundpool;
  int soundIdCorrect;
  int soundIdInCorrect;
  int soundIdStart;
  bool isBlank = false;


  List shuffle(List items) {
    var random = new Random();
    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final list = List<int>.generate(30, (i) => i + 1);
    if (selectedCard == Select.numberSelected) {
      randomList = shuffle(list);
    } else if (selectedCard == Select.uppercaseSelected) {
      randomList = shuffle(uppercaseData);
    } else {
      randomList = shuffle(childcaseData);
    }

    if (selectedCard == Select.numberSelected) {
      topText = "1";
    } else if (selectedCard == Select.uppercaseSelected) {
      topText = "A";
    } else if (selectedCard == Select.childSelected) {
      topText = "a";
    }

    initSounds();

    return ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/blackhole (2).jpeg'),
              fit: BoxFit.cover,
            )),
            child: Consumer<CounterModel>(builder: (context, model, child) {
              model.topText = topText;
              model.isEnd || model.isComplete ? null : model.startStopWatch();
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        model.timeDisplay,
                        style: kTextStyle,
                      ),
                      SelectedCard(
                        onPress: () {
                          //TODO QUIT押下時にタイマーを止める処理
                          model.stopTimer();
                          if (model.isComplete) {
                            Navigator.pop(context, model.timeDisplay);
                            return Future.value(false);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        text: 'QUIT',
                        width: kInActiveBorderWidth,
                      )
                    ],
                  ),
                  (() {
                    if (model.isEnd) {
                      return Text("GAMEOVER", style: kTextStyle);
                    }else if(model.isComplete) {
                      return Text("Congratulations!", style: kTextStyle);
                    } else {
                      return Text(model.topText, style: kTextStyle);
                    }
                  })(),
                  SizedBox(
                    height: 80.0,
                  ),
                  GridView.count(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 5,
                    children: List.generate(randomList.length, (index) {
                      return TestCard(
                        onPress: () {
                          if(model.isPushed) {
                            if (selectedCard == Select.numberSelected) {
                              model.updateCurrentNumber(randomList[index]);
                              topText = model.topText;
                            } else
                            if (selectedCard == Select.uppercaseSelected) {
                              if (randomList[index] == " ") {
                                isBlank = true;
                              } else {
                                model.updateCurrentUppercase(randomList[index]);
                                topText = model.topText;
                              }
                            } else if (selectedCard == Select.childSelected) {
                              if (randomList[index] == " ") {
                                isBlank = true;
                              } else {
                                model.updateCurrentChild(randomList[index]);
                                topText = model.topText;
                              }
                            }
                              if (model.isEnd == true ) {
                                soundpool.play(soundIdInCorrect);
                                model.stopTimer();
                              } else if (model.isEnd == false && isBlank == false && model.isComplete == false || randomList[index] == "30" || randomList[index] == "Z" || randomList[index] == "z") {
                                soundpool.play(soundIdCorrect);
                              }

                            //タイマーを止める処理
                            if (model.isComplete == true || model.isEnd == true) {
                              model.stopTimer();
                            }
                          }
                        },
                        number: randomList[index].toString(),
                      );
                    }),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void initSounds() async {
    soundpool = Soundpool();
    soundIdCorrect = await loadSound('sounds/「えいっ！」.mp3');
    soundIdInCorrect = await loadSound('sounds/「いたっ！」.mp3');
    soundIdStart = await loadSound('sounds/「よ、よろしくお願いします」.mp3');
    soundpool.play(soundIdStart);
  }

  Future<int> loadSound(String soundPath) {
    return rootBundle.load(soundPath).then((value) => soundpool.load(value));
  }
}
