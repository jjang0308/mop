import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Channel',
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      home: NativeCallWidget(),
    );
  }
}

class NativeCallWidget extends StatefulWidget{

  @override
  State createState() {
    return NativeCallWidgetState();
  }
}

class NativeCallWidgetState extends State<NativeCallWidget>{

  String? resultMessage;
  String? receiveMessage;

  Future<Null> nativeCall()async{
    const channel =
    BasicMessageChannel<String>('myMessageChannel', StringCodec());
    String? result = await channel.send('Hello from Dart');
    setState(() {
      resultMessage = result;
    });
    channel.setMessageHandler((String? message) async {
      setState(() {
        receiveMessage = message;
      });
      return 'Reply from Dart';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('message channel'),
      ),
      body: Container(
        color: Colors.deepPurpleAccent,
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: (<Widget>[
            Text('resultMessage :', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
            Text('$resultMessage', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
            Text('receiveMessage :', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
            Text(' $receiveMessage', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
            ElevatedButton(onPressed: (){
              nativeCall();
            }, child: Text('native call')),
          ]),
        ),
        ),
      ),
    );
  }
}