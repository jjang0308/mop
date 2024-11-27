import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mop/ddd.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  PageController controller = PageController(
    initialPage: 1,
    viewportFraction: 0.8
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('페이지 뷰 활용하기'),
        ),
        body: PageView(
          controller: controller,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              color: Colors.red,
              child: Center(
                child: Text('One Page',
                style: TextStyle(color: Colors.white, fontSize: 30),),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              color: Colors.green,
              child: Center(
                child: Text('Two Page',
                  style: TextStyle(color: Colors.white, fontSize: 30),),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              color: Colors.blue,
              child: Center(
                child: Text('Three Page',
                  style: TextStyle(color: Colors.white, fontSize: 30),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}