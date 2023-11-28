import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat_app/api/apis.dart';
import 'package:we_chat_app/main.dart';
import 'package:we_chat_app/models/chatUser.dart';
import 'package:we_chat_app/screens/profile_screen.dart';
import 'package:we_chat_app/utils/colors.dart';
import 'package:we_chat_app/widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  final List<ChatUser> _searchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //for hiding keyboard when a tap is detected on screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        //if search is on & back button pressed then close search
        // or else close current screen on back button click
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(CupertinoIcons.home),
            title: _isSearching
                ? TextField(
                    autofocus: true,
                    onChanged: (value) {
                      // search logic
                      _searchList.clear();
                      for (var i in list) {
                        if (i.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            i.email
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                          _searchList.add(i);
                        }
                        setState(() {
                          _searchList;
                        });
                      }
                    },
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Here",
                    ),
                  )
                : Text(
                    "We Chat",
                  ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
                icon: Icon(_isSearching
                    ? CupertinoIcons.clear_circled_solid
                    : Icons.search),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          user: APIs.me,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.more_vert))
            ],
          ),
          body: StreamBuilder(
              stream: APIs.getAllUsers(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  //if data is loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  //if data is loaded
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data!.docs;
                    list =
                        data.map((e) => ChatUser.fromJson(e.data())).toList();

                    if (list.isNotEmpty) {
                      return ListView.builder(
                          padding: EdgeInsets.only(top: mq.height * .02),
                          physics: BouncingScrollPhysics(),
                          itemCount:
                              _isSearching ? _searchList.length : list.length,
                          itemBuilder: (context, index) {
                            return ChatUserCard(
                              user: _isSearching
                                  ? _searchList[index]
                                  : list[index],
                            );
                          });
                    } else {
                      return Center(
                          child: Text(
                        "No connection found",
                        style: TextStyle(fontSize: 20),
                      ));
                    }
                }
              }),
          //floating button to add new user
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              backgroundColor: themeColor,
              onPressed: () async {
                await APIs.auth.signOut();
                await GoogleSignIn().signOut();
              },
              child: Icon(Icons.add_comment_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
