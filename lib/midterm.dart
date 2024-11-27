import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mop/ddd.dart';
import 'package:mop/practice5_2_5.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(child:
              Text('손무경 병진', style: TextStyle(color: Colors.white, fontSize: 50),),
              decoration: BoxDecoration(
                color: Colors.black
              ),
              ),
              ListTile(
                title: Text('손무경'),
                onTap: (){

                },
              ),
              ListTile(
                title: Text('병진'),
                onTap: (){

                },
              ),

            ],
          ),
        ),
        appBar: AppBar(
          bottom: TabBar(
            controller: tabController,
              tabs: <Widget>[
            Tab(text: 'ONE',),
            Tab(text: 'ONE',),
            Tab(text: 'ONE',),
          ]),
          centerTitle: true,
          title: Text('Stateful test'),
          actions: <Widget>[
            IconButton(onPressed: (){},
                icon: const Icon(Icons.add_alert)),

            IconButton(onPressed: (){},
                icon: const Icon(Icons.add_alert)),

            ],

        ),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return MyWidgetState();
  }
}


class MyWidgetState extends State<MyWidget> {
  final controller = TextEditingController();
  bool enabled = false;
  String stateText = "disabled";
  int textCounter = 0;

  print_value(){
    print("print_value(): ${controller.text}");
    setState(() {
      textCounter = controller.text.length;
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(print_value);
  }
  void changeCheck() {
    setState(() {
      if (enabled) {
        stateText = "disable";
        enabled = false;
      } else {
        stateText = "enable";
        enabled = true;
      }
    });

    int selectedIndex = 0;
    void onItemTapped(int index){
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
        Container(
        color: Colors.yellow,
      child:
      Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AlertDialog(
            title: Text("data"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: true,
                        onChanged: (value){}),
                    Text('수신동의')
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('ok'))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Container(width: 50, height: 50, color: Colors.red,),
          Container(width: 100, height: 50, color: Colors.green,),
          Container(width: 200, height: 50, color: Colors.blue,),
          ]),
            Text(
            'Hello World!', textAlign: TextAlign.right, style: TextStyle(
           color: Colors.red, fontWeight: FontWeight.bold, fontSize: 40
          ),
          ),
          Row(
              children: [
          IconButton(onPressed: changeCheck,
            icon: (enabled ? Icon(Icons.check_box, size: 20,) :
            Icon(Icons.check_box_outline_blank, size: 20,)),
            color: Colors.red,
          ),

          Spacer(),
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Text('$stateText', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          ]),
          Column(
            children: [
              Stack(
                children: [
                  Container(width: 200, height: 200, color: Colors.white,),
                  Container(width: 100, height: 100, color: Colors.blue,),
                  Container(width: 50, height: 50, color: Colors.red,),
                ],
              )
            ],
          ),
          Column(
            children: [
              TextField(
                obscureText: true,
                style: TextStyle(fontSize: 20),
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.input),
                  hintText: "이름을 입력하세요.",
                  helperText: "이름 써라",
                  counterText: '$textCounter',
                ),
              ),
              ElevatedButton(onPressed: (){
                print('submit'+' '+':'+' ' + controller.text);
              }, child: Text('submit'))
            ],
          ),
          BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.add),
            label: 'First',
            backgroundColor: Colors.red),
            BottomNavigationBarItem(icon: Icon(Icons.add),
            label: 'second',
            backgroundColor: Colors.black)
          ]
          )
        ],
      ),
    ),
    ),
    );
  }
}

