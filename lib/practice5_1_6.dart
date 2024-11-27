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
          title: Text('컨테이너와 센터 위젯 활용하기'),
        ), // AppBar
        body: Container(
          height: Size.infinite.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Colors.yellow,
              ],
            ), // LinearGradient
          ), // BoxDecoration
          child: Center(
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('images/cat.png'), fit: BoxFit.cover
                ), // DecorationImage
              ), // BoxDecoration
              width: 200,
              height: 200,
            ), // Container
          ), // Center
        ), // Container
      ), // Scaffold
    ); // MaterialApp
  }
}
