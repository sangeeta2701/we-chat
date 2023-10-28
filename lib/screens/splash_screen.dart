import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_chat_app/screens/auth/login_scteen.dart';
import 'package:we_chat_app/screens/home_screen.dart';
import 'package:we_chat_app/utils/colors.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      //exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));
          print("User: ${FirebaseAuth.instance.currentUser}");
          if(FirebaseAuth.instance.currentUser != null){
            Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
          }else{
            Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      );
          }
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              // duration: Duration(seconds: 1),
              top: mq.height * .15,
              right: mq.width * 0.25,
              width: mq.width * 0.5,
              child: Image.asset("assets/icons/icon.png")),
          Positioned(
              bottom: mq.height * .15,
              width: mq.width,
              child: Text(
                "MADE IN INDIA WITH ❤️",
                style:
                    TextStyle(fontSize: 16, color: bColor, letterSpacing: .5),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
