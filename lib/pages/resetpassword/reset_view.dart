import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/pages/resetpassword/reset_controller.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:mau_masak/utils/widget/form_custom.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: GetBuilder<ResetPasswordController>(
          init: ResetPasswordController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: Get.width * 0.4,
                      child: Image.asset(
                        "assets/images/lupapassword.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 24,
                        color: textColor,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Silahkan Masukkan Email",
                    style: TextStyle(fontSize: 14, color: textSecondaryColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value != null && !EmailValidator.validate(value)) {
                        return 'Masukkan Email Yang Valid';
                      } else {
                        return null;
                      }
                    },
                    controller: controller.email,
                    autocorrect: false,
                    decoration: FormInputCustom.inputDecor(
                        labelTextStr: "Email",
                        hintTextStr: "Masukkan email anda",
                        prefixicon:
                            const Icon(Icons.email, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GFButton(
                    onPressed: () {
                      controller.resetPassword(controller.email.value.text);
                    },
                    text: "Reset Password",
                    shape: GFButtonShape.pills,
                    fullWidthButton: true,
                    color: primaryColor,
                    size: GFSize.LARGE,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
