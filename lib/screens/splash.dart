import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/screens/editor.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> nextscreen() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Editor()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextscreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Note App",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff458BE7),
          ),
        ),
      ),
    );
  }
}
