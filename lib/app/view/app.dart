import 'package:beeapp/cheptel/view/cheptel_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, fontFamily: 'Montserrat'),
      home: CheptelPage(),
    );
  }
}
