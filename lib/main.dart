import 'package:flutter/material.dart';

import 'package:notification/Generate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        theme: ThemeData.light(),
        home: GenerateList(),
      ),
    );
  }
}
