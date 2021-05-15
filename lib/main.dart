import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';
import 'profile.dart';
import 'video.dart';
import 'model/class.dart';
import 'model/data.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0; //for homepage and profile page
  User _user = User();
  DataBase _database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DataBase("authenticating");
    _user = _database.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 150,
              color: Colors.blueGrey[900],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                height: 40,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => _buttonTapped(0),
            ),
            Divider(
              color: Colors.blueGrey[900],
            ),
            InkWell(
              child: Container(
                height: 40,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Videos',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => _buttonTapped(1),
            ),
            Divider(
              color: Colors.blueGrey[900],
            ),
            InkWell(
              child: Container(
                height: 40,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => _buttonTapped(2),
            ),
          ],
        ),
      ),
      body: WillPopScope(
          child: _page == 0
              ? HomePage()
              : _page == 1
                  ? Videos()
                  : ProfileScreen(
                      user: _user,
                    ),
          onWillPop: _backButtonPressed),
    );
  }

  _buttonTapped(int _pa) {
    if (_page != _pa) {
      _page = _pa;
      setState(() {});
    }
    Navigator.pop(context);
  }

  Future<bool> _backButtonPressed() async {
    if (_page == 0)
      return true;
    else {
      _page = 0;
      setState(() {});
      return false;
    }
  }
}
