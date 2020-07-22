import 'package:flutter/material.dart';

import 'Generate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Phoenix"),
          leading: Icon(Icons.menu),
        ),
        body: GenerateList(),
        floatingActionButton: ClipOval(
          child: Material(
            color: Colors.blue,
            child: SizedBox(
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.whatshot,
                    color: Colors.red,
                  ),
                  onPressed: () {},
                  splashColor: Colors.red,
                ),
              ),
              width: 50.0,
              height: 50.0,
            ),
          ),
        ),
      ),
    );
  }
}
