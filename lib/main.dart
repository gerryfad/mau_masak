import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mau_masak/firebase_options.dart';
import 'package:mau_masak/pages/auth/auth_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/routes/page_routes.dart';
import 'package:mau_masak/services/local_push_notification.dart';
import 'package:mau_masak/theme/styles.dart';

Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final authController = Get.put(AuthController(), permanent: true);
  runApp(
    StreamBuilder<User?>(
        stream: authController.streamAuthStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Mau Masak",
              initialRoute:
                  snapshot.data != null ? PageName.dashboard : PageName.onboard,
              theme:
                  ThemeData(fontFamily: 'Roboto', primaryColor: primaryColor),
              getPages: PageRoutes.pages,
              builder: EasyLoading.init(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
  );
}
