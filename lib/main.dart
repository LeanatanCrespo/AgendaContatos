import 'package:agenda_contatos/principal.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Principal(),
    );
  }
}


