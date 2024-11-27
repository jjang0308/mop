import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mop/ddd.dart';
import 'package:mop/practice10_1_1.dart';
import 'package:mop/practice10_1_2.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<MyDataModel1>.value(value: MyDataModel1(),),
      ChangeNotifierProvider<MyDataModel2>.value(value: MyDataModel2(),),
      StreamProvider<int>(create: (context) => streamFun(), initialData: 0,)
    ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget{

  @override
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{

  static List<Widget> _widgetOptions = <Widget>[
    FirstWidget(),
    SecondWidget(),
    ThirdWidget(),
    FourthWidget()
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
          title: Text('Provider Package'),
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
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Fourth',
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

Stream<int> streamFun() async*{
  for(int i = 1; i<= 100; i++){
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

class MyDataModel1 with ChangeNotifier{
  int count = 0;
  String data = "Mobile";

  void increment(){
    count++;
    notifyListeners();
  }
   void toggleText(){
    data = data == "Mobile" ? "Programming" : "Mobile";
    notifyListeners();
   }
}

class MyDataModel2 with ChangeNotifier{
  String text = "Hello";

  void toggleText(){
    text = text == "Hello" ? "World" : "Hello";
    notifyListeners();
  }
}


class FirstWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var int_data = Provider.of<MyDataModel1>(context);
    var string_data = Provider.of<MyDataModel2>(context);

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter : ${int_data.count}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.orange,
              ),
            ),Text(
              'String : ${string_data.text}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var streamState = Provider.of<int>(context);
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'stream : ${streamState}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ThirdWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    print('homewidget build');
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer2<MyDataModel1, MyDataModel2>(
              builder: (context, model1, model2, child){
                return SubWidget1(model1, model2, child);
              },
              child: SubWidget2(),
            ),
            Column(
              children: [
                ElevatedButton(onPressed: (){
                  var model1 = Provider.of<MyDataModel1>(context, listen: false);
                  model1.increment();
                },
                    child: Text('Count Increment')
                )
                ,
                ElevatedButton(onPressed: (){
                  var model2 = Provider.of<MyDataModel2>(context, listen: false);
                  model2.toggleText();
                },
                    child: Text('Toggle Text')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SubWidget1 extends StatelessWidget{

  MyDataModel1 model1;
  MyDataModel2 model2;
  Widget? child;
  SubWidget1(this.model1, this.model2, this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'I am SubWidget1',
            style: TextStyle(
              color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 20,
            ),
          ), Text(
            'Counter : ${model1.count}',
            style: TextStyle(
              color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 20,
            ),
          ), Text(
            'String : ${model2.text}',
            style: TextStyle(
              color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 20,
            ),
          ),
          child!
        ],
      ),
    );
  }
}

class SubWidget2 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      padding: EdgeInsets.all(20),
      child:
      Text(
        'I am SubWidget2',
        style: TextStyle(
          color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 20,
        ),
      ),
    );
  }
}


class FourthWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Selector<MyDataModel1, String>(
                builder: (context, data, child){
                  return Container(
                    color: Colors.cyan,
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'selector String : ${data}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }, selector: (context, model) => model.data
            ),
            Column(
              children: [
                ElevatedButton(onPressed: (){
                  var model = Provider.of<MyDataModel1>(context, listen: false);
                  model.toggleText();
                },
                    child: Text('Toggle Text')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
