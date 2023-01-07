import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Backend/group.dart';
import 'group_widget.dart';

class GroupListBuilder extends StatefulWidget {
  const GroupListBuilder({Key? key}) : super(key: key);

  @override
  State<GroupListBuilder> createState() => _GroupListBuilderState();
}

class _GroupListBuilderState extends State<GroupListBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: groupsListView(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as ListView;
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future<ListView> groupsListView() async {
    final children = <Widget>[];
    QuerySnapshot groupList =
        await FirebaseFirestore.instance.collection('groups').get();
    for (QueryDocumentSnapshot group in groupList.docs) {
      children.add(
        GroupWidget(
          group: Group(
            name: group.get('name') as String,
            description: group.get('description') as String,
            imageURL: group.get('imageURL') as String,
            userList: [],
          ),
        ),
      );
      children.add(
        const SizedBox(
          height: 7,
        ),
      );
    }
    return ListView(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0), children: children);
  }
}
