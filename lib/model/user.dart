class User {
  String uid;
  String username;
  String? profilePhoto;
  String email;
  List? followers;
  List? following;

  User(
      {required this.uid,
      required this.username,
      required this.email,
      this.followers,
      this.following,
      this.profilePhoto});

  Map<String, dynamic> toJson() => {
        "name": username,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
      };

  // static User fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return User(
  //     email: snapshot['email'],
  //     profilePhoto: snapshot['profilePhoto'],
  //     uid: snapshot['uid'],
  //     name: snapshot['name'],
  //   );
  // }
}
