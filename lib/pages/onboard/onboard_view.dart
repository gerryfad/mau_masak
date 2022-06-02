import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:getwidget/getwidget.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: Get.width * 0.9,
                  child: Image.asset(
                    "assets/images/onboard1.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Selamat Datang",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    color: textColor,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Ayo Bergabung Dan Pelajari Semua ",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: textSecondaryColor),
              ),
              const Text(
                "Resep Dari Seluruh Dunia",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: textSecondaryColor),
              ),
              SizedBox(
                height: Get.height * 0.2,
              ),
              GFButton(
                onPressed: () {
                  Get.toNamed(PageName.login);
                },
                text: "Mulai",
                shape: GFButtonShape.pills,
                fullWidthButton: true,
                color: primaryColor,
                size: GFSize.LARGE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
