import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp5());
}

class MyApp1 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Provider Test'),
        ),
        body: Provider<int>(
              create: (context){
              int sum = 0;
              for(int i = 1; i<=10; i++){
                sum += i;
            }
              return sum;
          },
          child: SubWidget1(),
        ),
      ),
    );
  }
}

class Counter with ChangeNotifier{
  int _count = 0;
  int get count => _count;

  void increment(){
    _count++;
    notifyListeners();
  }
}


class MyApp2 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('changeNotifierProvider Test'),
        ),
        body: ChangeNotifierProvider<Counter>.value(
            value: Counter(),
            child: SubWidget2(),
        ),
      ),
    );
  }
}

// class MyApp4 extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('changeNotifierProvider Test'),
//         ),
//         body: MultiProvider(
//             providers: [
//               ChangeNotifierProvider<Counter>.value(value: Counter(),),
//               ProxyProvider<Counter, Sum>(
//                 update: (context, model, sum){
//                   if(sum != null){
//                     sum.sum = model.count;
//                     return sum;
//                   }else{
//                     return Sum(model);
//                   }
//                 },
//               ),
//               ProxyProvider2<Counter, Sum, String>(
//                 update: (context, model1, model2, sum){
//                   return "count : ${model1.count}, sum : ${model2.sum}";
//                 },
//               ),
//
//             ],
//           child: SubWidget4(),
//         ),
//       ),
//     );
//   }
// }


class MyApp3 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('changeNotifierProvider Test'),
        ),
        body: MultiProvider(
            providers: [
              Provider<int>.value(value: 20,),
              Provider<String>.value(value: "hello"),
              ChangeNotifierProvider<Counter>.value(value: Counter(),),
            ],
          child: SubWidget3(),
        ),
      ),
    );
  }
}


Stream<int> streamFun() async*{
  for(int i = 1; i<= 5; i++){
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

class MyApp5 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('futureProvider, StreamProvider Test'),
        ),
        body: MultiProvider(
            providers: [
              FutureProvider(
                  create: (context)=> Future.delayed(Duration(seconds: 4), () => "World"
                  ),
                  initialData: "hello"
              ),
              StreamProvider(create: (context) => streamFun(), initialData: 0)
            ],
          child: SubWidget5(),
        ),
      ),
    );
  }
}


class SubWidget5 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var streamState = Provider.of<int>(context);
    var futureState = Provider.of<String>(context);
    return Container(
      color: Colors.orange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'future : ${futureState}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),Text(
              'stream : ${streamState}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SubWidget4 extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     var counter = Provider.of<Counter>(context);
//     var sum = Provider.of<Sum>(context);
//     var string_data = Provider.of<String>(context);
//
//     return Container(
//       color: Colors.orange,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Provider :',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),Text(
//               'int_data : ${sum.sum}',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),Text(
//               'String_data : $string_data',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),Text(
//               'Counter data : ${counter.count}',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),
//             ElevatedButton(onPressed: (){
//               counter.increment();
//             },
//               child: Text('increment'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class SubWidget3 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<Counter>(context);
    var int_data = Provider.of<int>(context);
    var string_data = Provider.of<String>(context);

    return Container(
      color: Colors.orange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Provider :',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),Text(
              'int_data : $int_data',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),Text(
              'String_data : $string_data',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),Text(
              'Counter data : ${counter.count}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            ElevatedButton(onPressed: (){
              counter.increment();
            },
              child: Text('increment'),
            )
          ],
        ),
      ),
    );
  }
}


class SubWidget2 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<Counter>(context);
    return Container(
      color: Colors.orange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Provider count : ${counter.count}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ElevatedButton(onPressed: (){
              counter.increment();
              },
                child: Text('increment'),
            )
          ],
        ),
      ),
    );
  }
}


class SubWidget1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<int>(context);
    return Container(
      color: Colors.orange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'I am SubWidget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
             'Provider Data : ${data}',
             style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.bold,
               color: Colors.white,
             ),
            )
          ],
        ),
      ),
    );
  }
}