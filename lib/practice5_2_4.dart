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
          title: Text('기본 설정 위젯 활용하기'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 300,
                child: Row(
                  children: [
                    Container(
                      color: Colors.red,
                      width: 100,
                    ), // Container
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.amber,
                      ), // Container
                    ), // Expanded
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.yellow,
                      ), // Container
                    ), // Expanded
                  ],
                ), // Row
              ), // Container
              Container(
                color: Colors.green,
                height: 300,
                child: Row(
                  children: [
                    Image.asset('images/lab_instagram_icon_1.jpg'),
                    Image.asset('images/lab_instagram_icon_2.jpg'),
                    Image.asset('images/lab_instagram_icon_3.jpg'),
                    Spacer(),
                    Image.asset('images/lab_instagram_icon_4.jpg'),
                  ],
                ), // Row
              ), // Container
              Container(
                color: Colors.blue,
                height: 400,
              ), // Container
            ],
          ), // Column
        ), // SingleChildScrollView
      ), // Scaffold
    );
  }
}
