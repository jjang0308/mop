import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mop/ddd.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

List<String>cities = ["서울시", "울산시", "인천시"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
        Scaffold(
          appBar: AppBar(
            title: Text('data', style: TextStyle(color: Colors.white),),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
        body: ListView.builder(
     itemCount: cities.length,
      itemBuilder: (context, index){
        return Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 100,
          child: Text(cities[index]),
        );
      },
    ),
        ),
    );
  }
}