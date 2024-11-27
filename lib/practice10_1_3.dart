import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mop/ddd.dart';
import 'package:mop/practice10_1_1.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyDataModel with ChangeNotifier{
  int data2 = 0;
  void changeData1(){
    data2++;
    notifyListeners();
  }
  String data1 = "hello";

  void changeData2(){
    if(data1 == "hello"){
      data1 = "world";
    }else{
      data1 = "hello";
    }
    notifyListeners();
  }
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('consumer Test'),
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<MyDataModel>.value(
              value: MyDataModel(),
              child: HomeWidget(),
            ),
          ],
          child: HomeWidget(),
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    print('homewidget build');
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<MyDataModel>(
              builder: (context, model, child) {
                return Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'consumer, data1 : ${model.data1} , data2 : ${model.data2}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                );
              },
            ),
            Selector<MyDataModel, int>(
                builder: (context, data, child){
                  return Container(
                    color: Colors.cyan,
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'selector, data : ${data}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }, selector: (context, model) => model.data2
            ),
            Column(
              children: [
                ElevatedButton(onPressed: (){
                  var model1 = Provider.of<MyDataModel>(context, listen: false);
                  model1.changeData1();
                },
                    child: Text('model data1 change')
                )
                ,
                ElevatedButton(onPressed: (){
                  var model2 = Provider.of<MyDataModel>(context, listen: false);
                  model2.changeData2();
                },
                    child: Text('model data2 change')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class SubWidget1 extends StatelessWidget{
//
//   MyDataModel model;
//   Widget? child;
//   SubWidget1(this.model1, this.model2, this.child);
//
//   @override
//   Widget build(BuildContext context) {
//     print('subWidget1 build');
//     return Container(
//       color: Colors.green,
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Text(
//             'I am SubWidget1, ${model1.data}, ${model2.data}',
//             style: TextStyle(
//               color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 20,
//             ),
//           ),
//           child!
//         ],
//       ),
//     );
//   }
// }
//
// class SubWidget2 extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     print('subWidget2 build');
//     return Container(
//       color: Colors.deepPurpleAccent,
//       padding: EdgeInsets.all(20),
//       child:
//       Text(
//         'I am SubWidget2',
//         style: TextStyle(
//           color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 20,
//         ),
//       ),
//     );
//   }
// }
//
