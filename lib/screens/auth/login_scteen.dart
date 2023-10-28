import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat_app/utils/colors.dart';

import '../../helper/dialogs.dart';
import '../../main.dart';
import '../home_screen.dart';

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

  _handleGoogleBtnClick() {
    //for showing progress indicator
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) {
      //for hiding progress indicator
       Navigator.pop(context);
      if (user != null) {
        print("User: ${user.user}");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup("google.com");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
//create new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
//once signin retun user credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      debugPrint("_signInWithGoogle: $e");
      Dialogs.showSnackbar(context, "Something went wrong,check internet");
      return null;
    }
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
                    _handleGoogleBtnClick();
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
