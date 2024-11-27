import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mop/ddd.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  bool enabled = false;
  String stateText = "disable";

  void changeCheck(){
    if(enabled){
      stateText = "disable";
      enabled= false;
    }else{
      stateText = "enable";
      enabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('midterm Stateless',),
          
        ),
        body: Column(
          children: [
            Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage('images/cat.png'),fit: BoxFit.fill)
            ),
            width: 100,
            height: 100,
          ),
            Container(
              height: Size.infinite.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.black
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)
              ),
              child: Center(
                child: Text('Hello',
                style: TextStyle(
                  fontSize: 30,
                   fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),
      ],
        ) ,
      ),
    );
  }
}