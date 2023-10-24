import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_app/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: Text("We Chat",),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search),),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
      ),
      //floating button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(onPressed: (){},child: Icon(Icons.add_comment_rounded),),
      ),
    );
  }
}