import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Group {
  String id;
  String name;
  String description;
  String imageURL;
  List<User> userList;

  Group({
    this.id = '',
    required this.name,
    required this.description,
    required this.imageURL,
    required this.userList,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'imageURL': imageURL,
        'userList': userList,
      };

  static Group fromJson(Map<String, dynamic> json) => Group(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageURL: json['imageURL'],
        userList: json['userList'],
      );

  static Future createGroup(
      {required String name,
      required String imageURL,
      required String description}) async {
    final docUser = FirebaseFirestore.instance.collection("groups").doc();

    final groupInstance = Group(
      id: docUser.id,
      name: name,
      description: description,
      imageURL: imageURL,
      userList: [FirebaseAuth.instance.currentUser as User],
    );
    final json = groupInstance.toJson();

    await docUser.set(json);
  }
}
