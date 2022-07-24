import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class FiremessagingController {
  static Future<void> activityPost(String avatar, String username,
      String owneruid, String type, String postId) async {
    try {
      String activityId = const Uuid().v1();
      FirebaseFirestore.instance
          .collection('activity')
          .doc(owneruid)
          .collection('activityItems')
          .doc(activityId)
          .set({
        'type': type,
        'profilePhoto': avatar,
        'username': username,
        'uid': owneruid,
        'postId': postId,
        'created_at': DateTime.now()
      });
    } catch (error) {
      Get.snackbar(
        'Terjadi Kesalahan',
        error.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static void sendNotification(String title, String body, String token) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAA_ymcRZY:APA91bH9SJ7q8RwRxkPzxM-cB_PRuc5r8m9wZVL2G1fOMXwcncnZenl3tT1IlDMTvxzde5Klqs8E_bU5T7nIfFpcH2rKEtqxt8hBGUNRtb4xyJUPFm9X79wR6fISa4bYR_IxjsoGeXB8'
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{
                  'title': title,
                  'body': body,
                },
                'priority': 'high',
                'data': data,
                'to': token
              }));

      if (response.statusCode == 200) {
        print("Notifikasi Berhasil dikirim");
      } else {
        print("Error");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
