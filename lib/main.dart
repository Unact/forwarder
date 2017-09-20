import 'package:flutter/material.dart';

import 'db_synch.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Экспедитор',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  DbSynch cfg = new DbSynch();
  final TextEditingController _controller = new TextEditingController();
  
  @override
  void initState() {
    super.initState();
    cfg.initDB();
  }
  
  @override
  Widget build(BuildContext context) {
    
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: [new BottomNavigationBarItem(         
                    icon: const Icon(Icons.airline_seat_recline_extra),
                    title: const Text('Доставка'),
                    backgroundColor: Theme.of(context).primaryColor,
              ),
              new BottomNavigationBarItem(         
                    icon: const Icon(Icons.account_box),
                    title: const Text('Настройки'),
                    backgroundColor: Theme.of(context).primaryColor,
              ),
      ],
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
    return new Scaffold(
      body: new Stack(        
          children: <Widget>[
            new Offstage(
              offstage: _currentIndex != 0,
              child: new TickerMode(
                enabled: _currentIndex == 0,
                child: new Scaffold(
                  appBar: new AppBar(
                    title: new Text("Маршруты и инкассации")
                  ),
                  body: new Container(
                    padding: const EdgeInsets.all(32.0),
                    child: new Column(
                      children: <Widget>[
                        new Text('Hello world!!!'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            new Offstage(
              offstage: _currentIndex != 1,
              child: new TickerMode(
                enabled: _currentIndex == 1,
                child: new Scaffold(
                  appBar: new AppBar(
                    title: new Text("Настройки подключения")
                  ),
                  body: new Container(
                    padding: const EdgeInsets.all(32.0),
                    child: new Column(
                      children: <Widget>[
                        new Text('Телефон или e-mail или имя'),
                        new TextField(
                          decoration: new InputDecoration(
                            hintText: 'Введите телефон или e-mail или имя',
                          ),
                        ),
                        new Text('Пароль'),
                        new TextField(
                          controller: _controller,
                          decoration: new InputDecoration(
                            hintText: 'Введите пароль',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),          
          ],
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}


