import 'package:flutter/material.dart';
import 'package:toodoo/Home.dart';
import 'package:toodoo/LoginPage.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "home":(context){
          Map a = ModalRoute.of(context).settings.arguments;
          print(a['email']);
          return Home(a['email']);
        },
        "login":(_)=>LoginPage(),
      },
     initialRoute: "login",
      
    );
  }
}