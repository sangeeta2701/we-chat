import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
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
  final _formKey = GlobalKey<FormState>();
  String? _image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile Screen",
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mq.width * .05, vertical: 20),
              child: Column(children: [
                Stack(
                  children: [
                    _image != null
                        ?
                        //local image
                        ClipRRect(
                            borderRadius: BorderRadius.circular(mq.height * .1),
                            child: Image.file(
                              File(_image!),
                              fit: BoxFit.cover,
                              width: mq.height * 0.2,
                              height: mq.height * 0.2,
                            ),
                          )
                        :
                        //image from server
                        ClipRRect(
                            borderRadius: BorderRadius.circular(mq.height * .1),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: mq.height * 0.2,
                              height: mq.height * 0.2,
                              imageUrl: widget.user.image,
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
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
                        onPressed: () {
                          _showBottomSheet();
                        },
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
                  style:
                      TextStyle(color: bColor.withOpacity(0.4), fontSize: 16),
                ),
                height30,
                TextFormField(
                  initialValue: widget.user.name,
                  onSaved: (val) => APIs.me.name = val ?? "",
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : "Required Field",
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
                  onSaved: (val) => APIs.me.about = val ?? "",
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : "Required Field",
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(
                              context, "Profile Updated Successfully!!");
                        });
                        // log("inside validator");
                      }
                    },
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
          ),
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
      ),
    );
  }

  //bottom sheet for picking a profile picture for user
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
            children: [
              Text(
                "Pick Your Profile Picture",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              height8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: wColor,
                          shape: CircleBorder(),
                          fixedSize: Size(mq.width * .25, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        //pick an image from gallery
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          print("image path: ${image.path}");
                          setState(() {
                            _image = image.path;
                          });
                        }
                        //for hiding bottom sheet
                        Navigator.pop(context);
                      },
                      child: Image.asset("assets/images/img2.png")),
                  //pick from camera
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: wColor,
                          shape: CircleBorder(),
                          fixedSize: Size(mq.width * .25, mq.height * .15)),
                      onPressed: ()async {
                         final ImagePicker picker = ImagePicker();
                        //pick an image from gallery
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          print("image path: ${image.path}");
                          setState(() {
                            _image = image.path;
                          });
                        }
                        //for hiding bottom sheet
                        Navigator.pop(context);
                      },
                      child: Image.asset("assets/images/img3.png"))
                ],
              ),
            ],
          );
        });
  }
}
