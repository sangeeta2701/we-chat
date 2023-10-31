import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_app/models/chatUser.dart';
import 'package:we_chat_app/utils/colors.dart';

import '../main.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key,required this.user});
  final ChatUser user;

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.person),
          ),
          title: Text(
            widget.user.name,
            style: TextStyle(
                fontSize: 12, color: bColor, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            widget.user.about,
            maxLines: 1,
            style: TextStyle(
                fontSize: 10, color: gColor, fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            "12:00 PM",
            style: TextStyle(
                fontSize: 10, color: gColor, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
