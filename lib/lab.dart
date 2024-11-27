

class Myclass{
  final int data;
  const Myclass(this.data);
}

main(){
  var obj = const Myclass(10);
  var obj1 = const Myclass(10);
  //obj == obj1
  var obj2 = const Myclass(10);
  var obj3 = const Myclass(12);
  var obj4 = SubClass();
  //obj2 != obj3
  print('obj == obj1 : ${obj == obj1}');
  print('obj2 == obj3 : ${obj2 == obj3}');
  obj4.myfun();
}

class SuperClass{
  int mydata = 10;
  void myfun(){
    print('123');
  }
  SuperClass(this.mydata){}
}

class SubClass extends SuperClass{
  SubClass() : super(15){}
  int mydata = 10;
  @override
  void myfun() {
    super.myfun();
    print('${super.mydata} + ${mydata}');
  }
}
