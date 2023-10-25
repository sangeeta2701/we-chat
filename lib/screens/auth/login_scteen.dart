import 'package:flutter/material.dart';
import 'package:we_chat_app/screens/home_screen.dart';
import 'package:we_chat_app/utils/colors.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Welcome to We Chat",
        ),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: Duration(seconds: 1),
              top: mq.height * .15,
              //if true then show animation otherwise remove logo
              right: _isAnimate ? mq.width * 0.25 : -mq.width * 0.5,
              width: mq.width * 0.5,
              child: Image.asset("assets/icons/icon.png")),
          Positioned(
              bottom: mq.height * .15,
              left: mq.width * 0.05,
              width: mq.width * 0.9,
              height: mq.height * .05,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bColor.withOpacity(0.8),
                    shape: StadiumBorder(),
                    elevation: 1,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>HomeScreen()) );
                  },
                  icon: Image.asset(
                    "assets/images/img1.png",
                    height: mq.height * 0.03,
                  ),
                  label: RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: wColor,
                            fontSize: 18,
                          ),
                          children: [
                        TextSpan(text: "Login with "),
                        TextSpan(
                          text: "Google",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ]))))
        ],
      ),
    );
  }
}
