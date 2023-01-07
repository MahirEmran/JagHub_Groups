import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Backend/group.dart';
import 'view_all_members_group.dart';

class GroupLandingPage extends StatefulWidget {
  final Group group;

  const GroupLandingPage({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupLandingPage> createState() => _GroupLandingPageState();
}

class _GroupLandingPageState extends State<GroupLandingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(widget.group.name, textAlign: TextAlign.center),
            trailing: const Icon(CupertinoIcons.person_circle_fill),
            backgroundColor: const Color(0xFFF5F5FA),
          ),
          SliverFillRemaining(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.group.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 73, 73, 73),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 157, 223, 85),
                                borderRadius: BorderRadius.circular(18)),
                            child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '   2022-23   ',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                      ]),

                      const SizedBox(
                        height: 15,
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 370,
                            child: Card(
                                color: const Color.fromARGB(245, 255, 255, 255),
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Image.network(
                                            widget.group.imageURL,
                                            height: 200,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ],
                                      ),
                                    ]))),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      SizedBox(
                          width: 360,
                          height: 50,
                          child: CupertinoButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroupMembersPages(
                                            group: widget.group)));
                              },
                              color: Colors.blue,
                              child: const Text('Group Members',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),

                      const SizedBox(
                        height: 20,
                      ),

                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '  Events',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )),

                      Container(), // Needs to be replaced with group events page section.
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
