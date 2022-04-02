import 'package:flutter/material.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numberOfCorrect = 0;
    correctRate = 0;
    numberOfRemaining = widget.numberOfQuestions;

    // TODO 効果音の準備

    setQuestion();
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
          //TODO 答え合わせボタン
          onPressed: null,
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
          //TODO 戻るボタン
          onPressed: null,
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
        onPressed: null, //TODO
        child: Text(
          numberString,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  Widget _correctIncorrectImage() {
    return Center(child: Image.asset("assets/images/pic_correct.png"));
  }

  Widget _endMessage() {
    return const Center(
      child: Text(
        "テスト終了",
        style: TextStyle(fontSize: 80.0),
      ),
    );
  }

  void setQuestion() {}
}
