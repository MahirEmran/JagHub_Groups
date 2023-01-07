/* Note: This file will need to be edited such that all instances of UserLocal are accurately replaced with Mahir's local User object. */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Backend/database_methods.dart';
import '../Backend/group.dart';
import '../Backend/shared_preference_helper.dart';

class ViewAllMembersInGroupPage extends StatelessWidget {
  final Group group;
  const ViewAllMembersInGroupPage({Key? key, required this.group})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<UserLocal>>(
        stream: readUsersFirebase(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final list = snapshot.data!;
          final children = <Widget>[];

          SharedPreferenceHelper().getUserId().then(
            (value) async {
              for (var index = 0; index < list.length; index++) {
                List<dynamic> listgrouplst = await DatabaseMethods()
                    .getGroupJoinedArrayForUserList(list[index].id);

                if (listgrouplst.contains(group.id)) {
                  children.add(ChatRoomListTileUser(
                      list[index].name, list[index].imageURL)); //ChatTile
                }
              }
            },
          );

          return ListView(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              children: children);
        },
      ),
    );
  }
}

Stream<List<UserLocal>> readUsersFirebase() => FirebaseFirestore.instance
    .collection('users2')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => UserLocal.fromJson(doc.data())).toList());

class UserLocal {
  String id;
  String name;
  String imageURL;

  UserLocal({
    this.id = '',
    required this.name,
    required this.imageURL,
  });

  Map<String, dynamic> toJson() =>
      {'userIdKey': id, 'name': name, 'imgUrl': imageURL};

  static UserLocal fromJson(Map<String, dynamic> json) => UserLocal(
        id: json['userIdKey'],
        name: json['name'],
        imageURL: json['imgUrl'],
      );
}

class ChatRoomListTileUser extends StatefulWidget {
  final String myUsername, imageUrl;
  const ChatRoomListTileUser(this.myUsername, this.imageUrl, {super.key});

  @override
  ChatRoomListTileUserState createState() => ChatRoomListTileUserState();
}

class ChatRoomListTileUserState extends State<ChatRoomListTileUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              widget.imageUrl,
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.myUsername,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GroupMembersPages extends StatefulWidget {
  final Group group;
  const GroupMembersPages({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupMembersPages> createState() => _GroupMembersPagesState();
}

class _GroupMembersPagesState extends State<GroupMembersPages> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // A ScrollView that creates custom scroll effects using slivers.
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            // This title is visible in both collapsed and expanded states.
            // When the "middle" parameter is omitted, the widget provided
            // in the "largeTitle" parameter is used instead in the coll3 q3apsed state.
            largeTitle: Text('Participants'),
            trailing: Icon(CupertinoIcons.person_circle_fill),
            backgroundColor: Color(0xFFF5F5FA),
          ),
          GroupMembersPageBody(
            group: widget.group,
          ),
        ],
      ),
    );
  }
}

class GroupMembersPageBody extends StatefulWidget {
  final Group group;

  const GroupMembersPageBody({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupMembersPageBody> createState() => _GroupMembersPageBodyState();
}

class _GroupMembersPageBodyState extends State<GroupMembersPageBody> {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Scaffold(
        body: ViewAllMembersInGroupPage(
          group: widget.group,
        ),
      ),
    );
  }
}
