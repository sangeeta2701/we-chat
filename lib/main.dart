import 'package:flutter/material.dart';
import 'package:we_chat_app/screens/home_screen.dart';
import 'package:we_chat_app/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "We Chat",
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: wColor,
          centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: bColor),
        titleTextStyle: TextStyle(color: bColor,fontSize: 18,fontWeight: FontWeight.normal),
        )
      ),
      home: HomeScreen(),
    );
  }
}

