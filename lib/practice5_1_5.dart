import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('제스처 감지기와 엘리베이트 버튼 활용하기'),
        ), // AppBar
        body: Column(
          children: [
            GestureDetector(
              child: Image.asset('images/icon/user.png'),
              onTap:(){
                print('image click...');
              },
              onVerticalDragStart: (DragStartDetails details){
                print('vertical drag start...global position : ${details.globalPosition.dx}, ${details.globalPosition.dy}');
                print('vertical drag start...local position : ${details.localPosition.dx}, ${details.localPosition.dy}');
              },
            ), // GestureDetector
            ElevatedButton(
              onPressed:(){
                print('ElevatedButton click...');
              },
              child: Text('Click Me'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
              ),
            ), // ElevatedButton
          ],
        ), // Column
      ), // Scaffold
    ); // MaterialApp
  }
}
