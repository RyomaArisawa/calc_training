import 'package:flutter/material.dart';
import 'test_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DropdownMenuItem<int>> _menuItems = [];
  int _numberOfQuestions = 0;

  @override
  void initState() {
    super.initState();
    _setMenuItems();
    _numberOfQuestions = _menuItems[0].value!;
  }

  void _setMenuItems() {
    List<int> values = [10, 20, 30];

    for (int value in values) {
      _menuItems.add(
        DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/images/image_title.png"),
                const SizedBox(
                  height: 50.0,
                ),
                const Text(
                  "問題数を選択して『スタート」ボタンを押してください",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(
                  height: 80.0,
                ),
                DropdownButton(
                    items: _menuItems,
                    value: _numberOfQuestions,
                    onChanged: (int? value) => changeDropdownItem(value!)),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.skip_next),
                      label: const Text("スタート"),
                      onPressed: () => startTestScreen(context),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.brown,
                        onPrimary: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  changeDropdownItem(int value) {
    setState(() {
      _numberOfQuestions = value;
    });
  }

  startTestScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestScreen(numberOfQuestions: _numberOfQuestions),
      ),
    );
  }
}
