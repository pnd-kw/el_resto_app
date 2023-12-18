import 'package:el_resto_app/el_resto_detail.dart';
import 'package:el_resto_app/el_resto_list.dart';
import 'package:el_resto_app/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of this application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Resto App',
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const ElRestoList(),
        '/el-resto-detail': (context) => const ElRestoDetail(),
      },
    );
  }
}
