import 'package:flutter/material.dart';
import 'package:kejaksaan/pages/login.dart';
import 'dart:async';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

    void initState(){
    super.initState();
    splashscreenStart();
  }

    splashscreenStart() async{
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
     });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(107, 140, 66, 1), 
              Color.fromRGBO(107, 140, 66, 1),
            ],
          ),
        ),
        child: Center(
          child: Image.asset(
            'images/b.png',
            width: 303.59,
            height: 236, 
          ),
        ),
      ),
    );
  }
}