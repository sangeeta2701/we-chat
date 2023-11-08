import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat_app/api/apis.dart';
import 'package:we_chat_app/helper/dialogs.dart';
import 'package:we_chat_app/models/chatUser.dart';
import 'package:we_chat_app/screens/auth/login_scteen.dart';
import 'package:we_chat_app/utils/colors.dart';
import 'package:we_chat_app/widgets/sizedBox.dart';

import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});
  final ChatUser user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Screen",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05, vertical: 20),
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * .1),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: mq.height * 0.2,
                  height: mq.height * 0.2,
                  imageUrl: widget.user.image,
                  errorWidget: (context, url, error) => CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: MaterialButton(
                  color: wColor,
                  elevation: 1,
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Icon(
                    Icons.edit,
                    color: themeColor,
                  ),
                ),
              )
            ],
          ),
          height20,
          Text(
            widget.user.email,
            style: TextStyle(color: bColor.withOpacity(0.4), fontSize: 16),
          ),
          height30,
          TextFormField(
            initialValue: widget.user.name,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: Icon(
                Icons.person,
                color: themeColor,
              ),
              label: Text("Name"),
            ),
          ),
          height16,
          TextFormField(
            initialValue: widget.user.about,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: Icon(
                Icons.info_outline,
                color: themeColor,
              ),
              label: Text("About"),
            ),
          ),
          height30,
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  minimumSize: Size(mq.width * .4, mq.height * .06)),
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                size: 20,
              ),
              label: Text(
                "UPDATE",
                style: TextStyle(fontSize: 16),
              ))
        ]),
      ),
      //floating button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: const Color.fromRGBO(255, 82, 82, 1),
          onPressed: () async {
            Dialogs.showProgressBar(context);

            await APIs.auth.signOut();
            await GoogleSignIn().signOut().then((value) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            });
          },
          icon: Icon(Icons.logout),
          label: Text("Logout"),
        ),
      ),
    );
  }
}