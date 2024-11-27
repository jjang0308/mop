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
          title: Text('체크박스, 라디오 버튼, 슬라이더, 스위치 활용하기'),
        ),
        body: TestScreen(),
      ), // Scaffold, MaterialApp
    );
  }
}

class TestScreen extends StatefulWidget {
  @override
  TextState createState() => TextState();
}

class TextState extends State<TestScreen> {
  bool? isChecked = true;
  String? selectPlatform;
  double sliderValue = 5.0;
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Checkbox Test'),
        Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value;
                });
              },
            ),
            Text('checkbox value is $isChecked'),
          ],
        ),
        Text('Radio Test'),
        Row(
          children: [
            Radio(
              value: 'android',
              groupValue: selectPlatform,
              onChanged: (String? value) {
                setState(() {
                  selectPlatform = value;
                });
              },
            ),
            Text('android'),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 'ios',
              groupValue: selectPlatform,
              onChanged: (String? value) {
                setState(() {
                  selectPlatform = value;
                });
              },
            ),
            Text('ios'),
          ],
        ),
        SizedBox(height: 20),
        Text('select platform is $selectPlatform'),
        Text('Slider Test'),
        Slider(
          value: sliderValue,
          min: 0,
          max: 10,
          label: sliderValue.toString(),
          onChanged: (double value) {
            setState(() {
              sliderValue = value;
            });
          },
        ),
        Text('slider value is $sliderValue'),
        Text('Switch Test'),
        Switch(
          value: switchValue,
          onChanged: (bool value) {
            setState(() {
              switchValue = value;
            });
          },
        ),
        Text('select value is $switchValue'),
      ],
    );
  }
}
