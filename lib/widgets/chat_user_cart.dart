import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_app/utils/colors.dart';

import '../main.dart';



class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width*.04,vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation: 2,
      child: InkWell(
        onTap: (){},
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.person),
          ),
          title: Text("Demo User",style: TextStyle(fontSize: 12,color: bColor,fontWeight: FontWeight.w500),),
          subtitle: Text("Last user message",maxLines: 1,style: TextStyle(fontSize: 10,color: gColor,fontWeight: FontWeight.w300),),
          trailing: Text("12:00 PM",style: TextStyle(fontSize: 10,color: gColor,fontWeight: FontWeight.w400),),
        ),
      ),
    );
  }
}