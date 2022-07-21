import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mau_masak/firebase_options.dart';
import 'package:mau_masak/pages/auth/auth_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/routes/page_routes.dart';
import 'package:mau_masak/theme/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthController());
  });
  final authC = Get.put(AuthController());
  runApp(
    StreamBuilder<User?>(
        stream: authC.streamAuthStatus(),
        builder: (context, snapshot) {
          print(snapshot);
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
  );
}
