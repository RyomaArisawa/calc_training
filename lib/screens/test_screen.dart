import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class TestScreen extends StatefulWidget {
  final int numberOfQuestions;

  TestScreen({required this.numberOfQuestions});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int numberOfRemaining = 0;
  int numberOfCorrect = 0;
  int correctRate = 0;

  int questionLeft = 0;
  int questionRight = 0;
  String operator = "";
  String answerString = "";

  late AudioPlayer _audioPlayer;

  bool isCalcButtonsEnabled = false;
  bool isAnswerCheckButtonEnabled = false;
  bool isBackButtonEnabled = false;
  bool isCorrectInCorrectImageEnabled = false;
  bool isEndMessageEnabled = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    numberOfCorrect = 0;
    correctRate = 0;
    numberOfRemaining = widget.numberOfQuestions;

    // TODO 効果音の準備
    _audioPlayer = AudioPlayer();
    setQuestion();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                //スコア表示部分
                _scorePart(),
                //問題表示部分
                _questionPart(),
                //電卓ボタン表示部分
                _calcButtons(),
                //答えあわせボタン
                _answerCheckButton(),
                //戻るボタン
                _backButton()
              ],
            ),
            _correctIncorrectImage(),
            _endMessage()
          ],
        ),
      ),
    );
  }

  //TODO スコア表示部分
  Widget _scorePart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(children: [
        const TableRow(children: [
          Center(
            child: Text(
              "残り問題数",
              style: TextStyle(fontSize: 10.0),
            ),
          ),
          Center(
            child: Text(
              "正解数",
              style: TextStyle(fontSize: 10.0),
            ),
          ),
          Center(
            child: Text(
              "正答率",
              style: TextStyle(fontSize: 10.0),
            ),
          ),
        ]),
        TableRow(children: [
          Center(
            child: Text(
              numberOfRemaining.toString(),
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          Center(
            child: Text(
              numberOfCorrect.toString(),
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          Center(
            child: Text(
              correctRate.toString(),
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ]),
      ]),
    );
  }

  //TODO 問題表示部分
  Widget _questionPart() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 40.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                questionLeft.toString(),
                style: const TextStyle(fontSize: 36.0),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                operator,
                style: const TextStyle(fontSize: 36.0),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                questionRight.toString(),
                style: const TextStyle(fontSize: 36.0),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "=",
                style: TextStyle(fontSize: 36.0),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                answerString,
                style: const TextStyle(fontSize: 60.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //TODO 電卓ボタン部分
  Widget _calcButtons() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 50.0),
        child: Table(
          children: [
            TableRow(children: [
              _calcButton("7"),
              _calcButton("8"),
              _calcButton("9"),
            ]),
            TableRow(children: [
              _calcButton("4"),
              _calcButton("5"),
              _calcButton("6"),
            ]),
            TableRow(children: [
              _calcButton("1"),
              _calcButton("2"),
              _calcButton("3"),
            ]),
            TableRow(children: [
              _calcButton("0"),
              _calcButton("-"),
              _calcButton("C"),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _answerCheckButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.brown),
          onPressed: isAnswerCheckButtonEnabled ? () => answerCheck() : null,
          child: const Text(
            "答え合わせ",
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.brown),
          onPressed: isBackButtonEnabled ? () => closeTestScreen() : null,
          child: const Text(
            "戻る",
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  _calcButton(String numberString) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.brown),
        onPressed:
        isCalcButtonsEnabled ? () => inputAnswer(numberString) : null,
        child: Text(
          numberString,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  Widget _correctIncorrectImage() {
    if (isCorrectInCorrectImageEnabled) {
      if (isCorrect) {
        return Center(
          child: Image.asset("assets/images/pic_correct.png"),
        );
      } else {
        return Center(
          child: Image.asset("assets/images/pic_incorrect.png"),
        );
      }
    } else {
      return Container();
    }
  }

  Widget _endMessage() {
    if (isEndMessageEnabled) {
      return const Center(
        child: Text(
          "テスト終了",
          style: TextStyle(fontSize: 80.0),
        ),
      );
    } else {
      return Container();
    }
  }

  void setQuestion() {
    isCalcButtonsEnabled = true;
    isAnswerCheckButtonEnabled = true;
    isBackButtonEnabled = false;
    isCorrectInCorrectImageEnabled = false;
    isEndMessageEnabled = false;
    answerString = "";

    Random random = Random();
    questionLeft = random.nextInt(100) + 1;
    questionRight = random.nextInt(100) + 1;

    if (random.nextInt(2) == 0) {
      operator = "+";
    } else {
      operator = "-";
    }
    setState(() {});
  }

  inputAnswer(String numString) {
    setState(() {
      if (numString == "C") {
        answerString = "";
      } else if (numString == "-") {
        if (answerString == "") answerString = "-";
      } else if (numString == "0") {
        if (answerString != "0" && answerString != "-") {
          answerString = answerString + numString;
        }
      } else if (answerString == "0") {
        answerString = numString;
      } else {
        answerString = answerString + numString;
      }
    });
  }

  answerCheck() {
    if (answerString == "" || answerString == "-") return;

    isCalcButtonsEnabled = false;
    isAnswerCheckButtonEnabled = false;
    isBackButtonEnabled = false;
    isCorrectInCorrectImageEnabled = true;
    isEndMessageEnabled = false;

    numberOfRemaining--;

    var myAnswer = int.parse(answerString).toInt();
    var realAnswer = 0;

    if (operator == "+") {
      realAnswer = questionLeft + questionRight;
    } else {
      realAnswer = questionLeft - questionRight;
    }

    if (realAnswer == myAnswer) {
      isCorrect = true;
      numberOfCorrect++;
    } else {
      isCorrect = false;
    }
    _playSound(isCorrect);

    correctRate =
        ((numberOfCorrect / (widget.numberOfQuestions - numberOfRemaining)) *
            100).toInt();

    if(numberOfRemaining == 0){
      isCalcButtonsEnabled = false;
      isAnswerCheckButtonEnabled = false;
      isBackButtonEnabled = true;
      isCorrectInCorrectImageEnabled = true;
      isEndMessageEnabled = true;
    }else{
      Timer(const Duration(seconds: 1), () => setQuestion());
    }
    setState(() {});
  }

  _playSound(bool isCorrect) async {
    if (isCorrect) {
      await _audioPlayer.setAsset("assets/sounds/sound_correct.mp3");
    } else {
      await _audioPlayer.setAsset("assets/sounds/sound_incorrect.mp3");
    }
    _audioPlayer.play();
  }

  closeTestScreen() {
    Navigator.pop(context);
  }
}
