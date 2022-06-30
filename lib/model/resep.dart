class Resep {
  String? username;
  List? likes;
  String? avatar;
  String? postId;
  DateTime? createdAt;
  String? namaResep;
  String? fotoResep;
  String? deskripsi;
  int? waktu;
  List<String>? bahan;
  List<String>? step;
  String? uid;

  Resep({
    this.avatar,
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

  factory Resep.fromJson(Map<String, dynamic> json) => Resep(
        avatar: json["avatar"],
        username: json["username"],
        likes: json["likes"],
        uid: json["uid"],
        postId: json["postId"],
        createdAt: json["created_at"],
        namaResep: json["nama_resep"],
        fotoResep: json["foto_resep"],
        deskripsi: json["deskripsi"],
        waktu: json["waktu"],
        bahan: json["bahan"],
        step: json["step"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "likes": likes,
        "avatar": avatar,
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
