import 'package:cloud_firestore/cloud_firestore.dart';

class Resep {
  String? username;
  List? likes;
  String? profilePhoto;
  String? postId;
  DateTime? createdAt;
  String? namaResep;
  String? fotoResep;
  String? deskripsi;
  int? waktu;
  List<dynamic>? bahan;
  List<dynamic>? step;
  String? uid;

  Resep({
    this.profilePhoto,
    this.username,
    this.likes,
    this.uid,
    this.postId,
    this.createdAt,
    this.namaResep,
    this.fotoResep,
    this.deskripsi,
    this.waktu,
    this.bahan,
    this.step,
  });

  factory Resep.fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Resep(
      profilePhoto: snapshot["profile_photo"],
      username: snapshot["username"] ?? "",
      likes: snapshot["likes"],
      uid: snapshot["uid"],
      postId: snapshot["postId"],
      createdAt: snapshot["created_at"].toDate(),
      namaResep: snapshot["nama_resep"],
      fotoResep: snapshot["foto_resep"],
      deskripsi: snapshot["deskripsi"],
      waktu: snapshot["waktu"],
      bahan: snapshot["bahan"],
      step: snapshot["step"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "likes": likes,
        "profile_photo": profilePhoto,
        "postId": postId,
        "created_at": createdAt,
        "bahan": bahan,
        "nama_resep": namaResep,
        "foto_resep": fotoResep,
        "deskripsi": deskripsi,
        "waktu": waktu,
        "step": step,
      };
}
