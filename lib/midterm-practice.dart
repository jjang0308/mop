import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mop/ddd.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: Text(
          "Pageview Test"
        ),
      ),
      body: MyWidget6(),

      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Examples'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyWidget()),
                );
              },
              child: Text('Go to PageView Example'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyWidget2()),
                );
              },
              child: Text('Go to GridView Example'),
            ),
          ],
        ),
      ),
    );
  }
}


class MyWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return MyWigetState();
  }
}

class MyWigetState extends State<MyWidget>{
  PageController controller = PageController(
    initialPage: 1,
    viewportFraction: 1.3
  );

  @override
  void setState(VoidCallback fn) {

  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: [
        Container(margin: EdgeInsets.all(20), color: Colors.blue,),
        Container(margin: EdgeInsets.all(20), color: Colors.red,),
        Container(margin: EdgeInsets.all(20), color: Colors.green,),
      ],
    );
  }
}

class MyWidget2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return MyWidget2State();
  }
}

class MyWidget2State extends State<MyWidget2>{

  List<String>cities = ['서울시', '인천시', '울산시','경기도'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index){
        return Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          height: 100,
          width: 100,
          child: Text(cities[index]),
        );
      },
    );
  }
}

class MyWidget3 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyWiget3State();
  }
}

class MyWiget3State extends State<MyWidget3> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(onPressed: (){showModalBottomSheet(
          context: context,
          builder: (context){
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text('ADD'),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  ),ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('DELETE'),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          }
      );
        }, child: Text('BOTTOMmodal')),
    );
  }
}

class MyWidget4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Theme(data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: Colors.black)
              ),
                child: Container(
                      height: 48,
                  alignment: Alignment.center,
                  child: Text('AppBar Bottom text'),
                  ),
              ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/cat.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text('AppBar Title'),
          actions: <Widget>[
            IconButton(onPressed: (){}, icon: const Icon(Icons.add_alert)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.phone)),
            ],
        ),
        body: Center(
          child: Text('data'),
        ),
      ),
    );
  }
}

class MyWidget5State extends State<MyWidget5>{

  int selectedIndex = 0;

  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(preferredSize: const Size.fromHeight(48.0),
              child: Theme(data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  secondary: Colors.black
                )
              ),
                  child: Text('data'))),
        ),
        body: Center(
          child: Text('AppBar ex'),
        ),
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
            backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Third',
            backgroundColor: Colors.purple
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Fourth',
              backgroundColor: Colors.pink
          ),
        ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: onItemTapped,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(child: Text('Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 20),),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              ),
              ListTile(
                title: Text('1'),
                onTap: (){},
              ),ListTile(
                title: Text('2'),
                onTap: (){},
              ),ListTile(
                title: Text('3'),
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget5 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyWidget5State();
  }
}

class MyWidget6 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyWidget6State();
  }
}

class MyWidget6State extends State<MyWidget6>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(onPressed: (){},
                  icon: Icon(Icons.expand)),
              expandedHeight: 200,
              floating: true, // false면 오류남
              pinned: false, //true면 끝까지 올려도 1줄정도는 남아있음, false면 안남아있음
              snap: true, //true 면 멈춘 다음에도 끝까지 나오기, false면 멈추면 그냥 멈춰버림
              elevation: 50,
              backgroundColor: Colors.pink,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/cat.png"),
                fit: BoxFit.fill),
              ),
            ),
              title: Text('data'),
              actions: <Widget>[
                IconButton(onPressed: (){}, icon: Icon(Icons.add_alert)),
                IconButton(onPressed: (){}, icon: Icon(Icons.phone)),
              ],
            ),
            SliverFixedExtentList(itemExtent: 50,delegate: SliverChildBuilderDelegate((BuildContext context, int index){
              return ListTile(
              title: Text("Hello World Item $index"),
              );
    })
            )],
        ),
      ),
    );
  }
}

