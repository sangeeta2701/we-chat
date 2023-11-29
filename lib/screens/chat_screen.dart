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
        body: Column(
          children: [
            _chatInput(),
          ],
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

  Widget _chatInput() {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: mq.height*.01,horizontal: mq.width*.025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                        onPressed: () {
                        },
                        icon: Icon(
                          Icons.emoji_emotions,
                          color: themeColor,
                          size: 25,
                        )),
                        Expanded(child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Type something...",
                            hintStyle: TextStyle(color: themeColor),
                            border: InputBorder.none
                          ),
                        )),
                  //gallery button
                  IconButton(
                        onPressed: () {
                        },
                        icon: Icon(
                          Icons.image,
                          color: themeColor,
                          size: 25,
                        )),
                  //camera button
                  IconButton(
                        onPressed: () {
                        },
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          color: themeColor,
                          size: 25,
                        )),
                        width4,
                ],
              ),
            ),
          ),
          //Send message button
          MaterialButton(onPressed: (){},
          shape: CircleBorder(),
          color: Colors.green,
          minWidth: 0,
          padding: EdgeInsets.only(top: 10,bottom: 10,right: 5,left: 10),
          child: Icon(Icons.send,color: wColor,size: 28,),)
        ],
      ),
    );
  }
}
