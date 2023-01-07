import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Frontend/groups_page.dart';
import 'database_methods.dart';
import 'shared_preference_helper.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User userDetails = result.user!;

    SharedPreferenceHelper().saveUserEmail(userDetails.email!);
    SharedPreferenceHelper().saveUserId(userDetails.uid);
    SharedPreferenceHelper()
        //.saveUserName(userDetails.email!.replaceAll("@gmail.com", ""));
        .saveUserName(userDetails.displayName!);
    SharedPreferenceHelper().saveDisplayName(userDetails.displayName!);
    SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL!);

    Map<String, dynamic> userInfoMap = {
      "email": userDetails.email,
      "username": userDetails.email!.replaceAll("@gmail.com", ""),
      "name": userDetails.displayName,
      "imgUrl": userDetails.photoURL,
      "userIdKey": userDetails.uid,
    };

    DatabaseMethods()
        .addUserInfoToDB(userDetails.uid, userInfoMap)
        .then((value) {
      DatabaseMethods().addUserJoinGroup(userDetails.uid);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const GroupsPage()));
    });
  }

  Future signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await auth.signOut();
  }
}
