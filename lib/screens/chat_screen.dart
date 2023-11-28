import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_app/models/chatUser.dart';
import 'package:we_chat_app/utils/colors.dart';
import 'package:we_chat_app/widgets/sizedBox.dart';

import '../main.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user});
  final ChatUser user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: bColor,
              )),
          //user profile picture
          ClipRRect(
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
          width10,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: TextStyle(
                    fontSize: 16,
                    color: bColor.withOpacity(
                      0.4,
                    ),
                    fontWeight: FontWeight.w500),
              ),
              height4,
              Text(
                "Lat seen not available",
                style: TextStyle(
                  fontSize: 13,
                  color: gColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
