import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_app/models/chatUser.dart';
import 'package:we_chat_app/screens/chat_screen.dart';
import 'package:we_chat_app/utils/colors.dart';

import '../main.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key, required this.user});
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
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreen(user: widget.user,),),);
        },
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .3),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: mq.height * 0.055,
              height: mq.height * 0.055,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) => CircleAvatar(
                child: Icon(CupertinoIcons.person),
              ),
            ),
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
          trailing: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: Colors.green.shade500,
                borderRadius: BorderRadius.circular(10)),
          ),
          // trailing: Text(
          //   "12:00 PM",
          //   style: TextStyle(
          //       fontSize: 10, color: gColor, fontWeight: FontWeight.w400),
          // ),
        ),
      ),
    );
  }
}
