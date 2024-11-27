import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Channel',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NativeCallWidget(),
    );
  }
}

class NativeCallWidget extends StatefulWidget {
  @override
  State createState() {
    return NativeCallWidgetState();
  }
}

class NativeCallWidgetState extends State<NativeCallWidget> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Method channel'),
      ),
      body: Container(
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
                          return 'Please enter your username';
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
                          return 'Please enter your password';
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
      ),
    );
  }
}
