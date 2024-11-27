import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mop/ddd.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

 _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MyApp>
with SingleTickerProviderStateMixin{
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:AppBar(
          title: Text('탭바 뷰 활용하기'),
          bottom: TabBar(
            controller: controller,
              tabs: [
              Tab(text: 'One',),
              Tab(text: 'Two',),
              Tab(text: 'Three',),
          ]),
        ),
        body: TabBarView(
          controller:controller,
            children: <Widget>[
              Center(
                child: Text(
                  'One Screen',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  'Two Screen',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  'Three Screen',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
      ),
    );
  }


}