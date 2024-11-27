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
          title: Text('크기 설정 위젯 활용하기'),
        ),
        body: Column(
          children: [
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(color: Colors.red, width: 50.0, height: 50.0),
                  Container(color: Colors.green, width: 150.0, height: 150.0),
                  Container(color: Colors.blue, width: 100.0, height: 100.0),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 300,
                maxHeight: 50,
              ),
              child: Container(color: Colors.amber, width: 150, height: 150),
            ),
          ],
        ),
      ),
    );
  }
}
