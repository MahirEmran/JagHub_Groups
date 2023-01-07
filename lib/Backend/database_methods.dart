import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap, SetOptions(merge: true));
  }

  Future addUserJoinGroup(String userid) async {
    final docData = {
      "joinedGroups": getGroupJoinedArrayForUserListCreate(userid)
    };

    return await FirebaseFirestore.instance
        .collection("userJGroup")
        .doc(userid)
        .set(docData);
  }


  Future<dynamic> getGroupJoinedArrayForUserList(String userId) async {
    late List<dynamic> groupList;
    await FirebaseFirestore.instance
        .collection("userJGroup")
        .doc(userId)
        .get()
        .then((value) {
      groupList = value.data()?["joinedGroups"] ?? [];
    });
    return groupList;
  }
}

List<dynamic> getGroupJoinedArrayForUserListCreate(String userId) {
  late List<dynamic> groupList;
  FirebaseFirestore.instance
      .collection("userJGroup")
      .doc(userId)
      .get()
      .then((value) {
    groupList = value.data()?["joinedGroups"] ?? [];
    return groupList;
  });

  return [];
}
