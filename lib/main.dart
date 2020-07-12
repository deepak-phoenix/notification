import 'package:flutter/material.dart';

import 'package:notification/Generate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Phoenix"),
        ),
        body: GenerateList(),
      ),
    );
  }
}
