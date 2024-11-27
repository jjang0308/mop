import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  @override
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{

  static List<Widget> _widgetOptions = <Widget>[
    NativeCallWidget2(),
    NativeCallWidget(),
    NativeCallWidget3()
  ];

  int _selectedIndex = 0;

  void onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Integrating Platform Example'),
        ),
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'First',
                backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Second',
                backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Third',
                backgroundColor: Colors.green
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}


class NativeCallWidget extends StatefulWidget{

  @override
  State createState() {
    return NativeCallWidgetState2();
  }
}

class NativeCallWidgetState extends State<NativeCallWidget2>{

  String? resultMessage;
  String? receiveMessage;

  Future<Null> nativeCall()async{
    const channel = BasicMessageChannel<String>('myMessageChannel', StringCodec());
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
    return  Container(
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
      );
  }
}

class NativeCallWidget2 extends StatefulWidget {
  @override
  State createState() {
    return NativeCallWidgetState();
  }
}

class NativeCallWidgetState2 extends State<NativeCallWidget> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? resultMessage;
  String? receiveMessage;

  @override
  void initState() {
    super.initState();
    const methodChannel = MethodChannel('myMethodChannel');
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'twoMethod':
          setState(() {
            receiveMessage = "${call.arguments}";
          });
          return 'Reply from Dart';
      }
    });
  }

  Future<void> nativeCall() async {
    const methodChannel = MethodChannel('myMethodChannel');
    try {
      var details = {'username': username, 'password': password};
      // 먼저 Map<dynamic, dynamic>으로 데이터를 받음
      final Map<dynamic, dynamic> result =
      await methodChannel.invokeMethod('oneMethod', details);

      // 타입 캐스팅 후 Map<String, dynamic>으로 변환
      setState(() {
        resultMessage = "${result['status']}";
      });
    } on PlatformException catch (e) {
      setState(() {
        resultMessage = "Error: ${e.message}";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurpleAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          nativeCall();
                        }
                      },
                      child: Text('login'),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'result : $resultMessage',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      'receiveMessage :',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),Text(
                      '$receiveMessage',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
class NativeCallWidget3 extends StatefulWidget {
  @override
  State<NativeCallWidget3> createState() => NaticeCallWidgetState3();
}

class NaticeCallWidgetState3 extends State<NativeCallWidget3> {

  String? receiveMessage;

  @override
  void initState() {
    super.initState();
    nativeCall();
  }

  Future<Null> nativeCall() async {
    const channel = EventChannel('eventChannel');
    channel.receiveBroadcastStream().listen((dynamic event) {
      setState(() {
        receiveMessage = '${event}';
      });
    }, onError: (dynamic error) {
      print('receive error: ${error.message}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurpleAccent, // 배경색 설정
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$receiveMessage',
                style: TextStyle(fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


