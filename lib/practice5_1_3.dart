import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('이미지 위젯 활용하기'),
            ), // AppBar
            body: Column(
              children: [
                Image(
                  image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  ),
                ), // Image with NetworkImage
                Container(
                  color: Colors.red,
                  child: Image.asset(
                    'images/cat.png',
                    width: 200,
                    height: 100,
                    fit: BoxFit.fill,
                  ), // Image.asset
                ) // Container
              ],
            ) // Column
        ) // Scaffold
    ); // MaterialApp
  }
}
