import 'package:flutter/material.dart';
import 'package:safe_password/pages/create_password.dart';
import 'package:safe_password/pages/edit_password.dart';
import 'package:safe_password/pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
      routes: {
        '/home': (ctx) => const HomePage(),
        '/create': (ctx) => CreatePasswordPage(),
        '/edit': (ctx) => EditPasswordPage()
      },
    );
  }
}
