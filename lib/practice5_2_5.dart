import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('텍스트 필드 위젯 활용하기'),
        ),
        body: TestScreen(),
      ), // Scaffold, MaterialApp
    );
  }
}

class TestScreen extends StatefulWidget {
  @override
  TestState createState() => TestState();
}

class TestState extends State<TestScreen> {
  final controller = TextEditingController();
  int textCounter = 0;

  _printValue() {
    print("_printValue(): ${controller.text}");
    setState(() {
      textCounter = controller.text.length;
    });
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build...");
    return Column(children: [
      Text('TextField Test'),
      TextField(
        style: TextStyle(fontSize: 15.0),
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Data',
          prefixIcon: Icon(Icons.input),
          border: OutlineInputBorder(),
          hintText: "Hint Text",
          helperText: "이름을 입력하세요.",
          counterText: "$textCounter characters",
        ), // InputDecoration
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.emailAddress,
        minLines: 5,
        maxLines: 5,
      ), // TextField
    ]); // Column
  }
}
