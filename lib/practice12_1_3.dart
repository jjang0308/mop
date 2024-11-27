import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Channel Stream',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StreamExample(),
    );
  }
}

class StreamExample extends StatefulWidget {
  @override
  State<StreamExample> createState() => _StreamExampleState();
}

class _StreamExampleState extends State<StreamExample> {

  String? receiveMessage;

  @override
  void initState() {
    super.initState();
    nativeCall();
  }

  Future<Null> nativeCall() async {
    const channel = EventChannel('eventChannel');
    channel.receiveBroadcastStream().listen((dynamic event){
      setState(() {
        receiveMessage = '${event}';
      });
    },onError: (dynamic error){
      print('receive error: ${error.message}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Channel Stream'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$receiveMessage',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
