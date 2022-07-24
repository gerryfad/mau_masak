import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String username;
  String? profilePhoto;
  String email;
  List? followers;
  List? following;
  String? tokenNotif;

  User(
      {required this.uid,
      required this.username,
      required this.email,
      this.followers,
      this.following,
      this.profilePhoto,
      this.tokenNotif});

  Map<String, dynamic> toJson() => {
        "name": username,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
        "followers": followers,
        "following": following,
        "tokenNotif": tokenNotif
      };

  static User fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      username: snapshot['name'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      tokenNotif: snapshot['tokenNotif'],
    );
  }
}
