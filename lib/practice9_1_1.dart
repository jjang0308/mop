import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => OneScreen(),
        '/two': (context) => TwoScreen(),
      },
    );
  }
}

class User {
  final String name;
  final String phone;
  User({required this.name, required this.phone});
}

class OneScreenState extends State<OneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FutureBuilderScreen(),
                ),
              );
            },
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('images/cat.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class OneScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OneScreenState();
  }
}

class FutureBuilderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Waiting...',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return TwoScreen();
          } else {
            return Center(
              child: Text(
                'Unexpected state.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
        },
      ),
    );
  }
}

class TwoScreenState extends State<TwoScreen> {
  final List<User> users = [
    User(name: '홍길동', phone: '010-1111-1111'),
    User(name: '김철수', phone: '010-2222-2222'),
    User(name: '이영희', phone: '010-3333-3333')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('친구 목록'),
      ),
      body: ListView.separated(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('images/cat.png'),
            ),
            title: Text(users[index].name),
            subtitle: Text(users[index].phone),
            trailing: Icon(Icons.more_vert),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThreeScreen(user: users[index]),
                ),
              );
              if (result != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('입력한 메시지'),
                      content: Text('$result'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('확인'),
                        )
                      ],
                    );
                  },
                );
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 2, color: Colors.black);
        },
      ),
    );
  }
}

class TwoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TwoScreenState();
  }
}

class ThreeScreenState extends State<ThreeScreen> {
  final controller = TextEditingController();
  final User user;
  int countdown = 3;
  bool isCounting = false;
  Timer? countdownTimer;

  ThreeScreenState({required this.user});

  @override
  void dispose() {
    controller.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    setState(() {
      isCounting = true;
      countdown = 3;
    });

    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
      });

      if (countdown <= 0) {
        timer.cancel();
        setState(() {
          isCounting = false;
        });
        Navigator.pop(context, controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name} 에게 메시지 보내기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(height: 50),
            TextField(
              style: TextStyle(fontSize: 15.0),
              controller: controller,
              decoration: InputDecoration(
                labelText: '메시지를 입력하세요.',
                prefixIcon: Icon(Icons.input),
                border: OutlineInputBorder(),
                hintText: "메시지를 입력하세요.",
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: Text('메세지 전송 및 돌아가기'),
            ),
            ElevatedButton(
              onPressed: isCounting ? null : startCountdown,
              child: isCounting
                  ? Text('예약 메시지 발송 (${countdown}초 후 전송)')
                  : Text('예약 메시지 발송 (3초 후 전송)'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThreeScreen extends StatefulWidget {
  final User user;
  ThreeScreen({required this.user});

  @override
  State<StatefulWidget> createState() {
    return ThreeScreenState(user: user);
  }
}
