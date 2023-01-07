import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'group_list_builder.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Groups'),
            trailing: Icon(CupertinoIcons.person_circle_fill),
            backgroundColor: Color(0xFFF5F5FA),
          ),
          GroupsPageBody(),
        ],
      ),
    );
  }
}

class GroupsPageBody extends StatefulWidget {
  const GroupsPageBody({Key? key}) : super(key: key);

  @override
  State<GroupsPageBody> createState() => _GroupsPageBodyState();
}

class _GroupsPageBodyState extends State<GroupsPageBody> {
  String name = "";
  late TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Container())); // Replaces join group page

          if (name == ('')) {
            const Text(
              'Name field cannot be empty',
            );
          }
        },
        tooltip: 'New Group',
        focusColor: Colors.black,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          color: Colors.white,
          child: const GroupListBuilder()),

      /* Column(
          children: <Widget>[

              
              SizedBox(height: 20,),
              //GroupWidget(
              //   groupname: "North Creek FBLA 22-23",
              //   image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2W64r_TE-L_KAUNbhElSBrIrdVJmjlpMkwwi_AKXANCodkEgsQtfj7Zd2zAkWDJEoAoE&usqp=CAU",
              // ),
              

              // GroupWidget(
              //   groupname: "North Creek TSA 22-23",
              //   image_url: "https://upload.wikimedia.org/wikipedia/en/thumb/9/96/Technology_Student_Association_Emblem.svg/1200px-Technology_Student_Association_Emblem.svg.png",
              // ),

              GroupListBuilder(), 

              Expanded(child: CourseList(courses)),
            ]), */
    ));
  }
}
