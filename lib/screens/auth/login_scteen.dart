import 'package:flutter/material.dart';
import 'package:we_chat_app/utils/colors.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
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
          Positioned(
          top: mq.height * .15,
          left: mq.width*0.25,
          width: mq.width*0.5,
          child: Image.asset("assets/icons/icon.png")),
           Positioned(
          bottom: mq.height * .15,
          left: mq.width*0.05,
          width: mq.width*0.9,
          height: mq.height*.05,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: bColor.withOpacity(0.8),
              shape: StadiumBorder(),
              elevation: 1,
            ),
            onPressed: (){}, icon: Image.asset("assets/images/img1.png",height: mq.height*0.03,), 
            label: RichText(text: TextSpan(
              style: TextStyle(
                color: wColor,
                fontSize: 18,
              ),
              children: [
              TextSpan(text: "Sign In with "),
              TextSpan(text: "Google",style: TextStyle(
                fontWeight: FontWeight.w700
              ),),
            ]))))],
      ),
    );
  }
}
