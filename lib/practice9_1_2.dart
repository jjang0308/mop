import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List<dynamic> items = [];

  onPressClient() async {
    var client = http.Client();
    try {
      http.Response response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          items = json.decode(response.body);
        });
      } else {
        print('error........');
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 50,
              backgroundColor: Colors.yellow,
              title: Text('Jsonplaceholder Contents'),
              actions: <Widget>[
                IconButton(onPressed: onPressClient, icon: Icon(Icons.add)),
              ],
            ),
            SliverFixedExtentList(
              itemExtent:70,
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  if (index < items.length) {
                    return ListTile(
                      title: Text("${items[index]['id']}"),
                      subtitle: Text(items[index]['title']),
                    );
                  } else {
                    return null;
                  }
                },
                childCount: items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
