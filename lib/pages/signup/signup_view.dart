import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/pages/auth/auth_controller.dart';
import 'package:mau_masak/pages/signup/signup_controller.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:mau_masak/utils/widget/form_custom.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

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
      body: SafeArea(
        child: GetBuilder<SignupController>(
          init: SignupController(),
          builder: (controller) {
            return FormBuilder(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 100, horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Daftar",
                          style: TextStyle(
                              fontSize: 24,
                              color: textColor,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Silahkan Isi Data Anda",
                          style: TextStyle(
                              fontSize: 14, color: textSecondaryColor),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FormBuilderTextField(
                          name: 'username',
                          validator: (value) {
                            if (value != null && value.length < 6) {
                              return 'Masukkan Lebih Dari 6 Karakter';
                            } else {
                              return null;
                            }
                          },
                          decoration: FormInputCustom.inputDecor(
                              labelTextStr: "Username",
                              hintTextStr: "Masukkan Username Anda",
                              prefixicon:
                                  const Icon(Icons.person, color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormBuilderTextField(
                          name: 'email',
                          validator: (value) {
                            if (value != null &&
                                !EmailValidator.validate(value)) {
                              return 'Masukkan Email Yang Valid';
                            } else {
                              return null;
                            }
                          },
                          decoration: FormInputCustom.inputDecor(
                              labelTextStr: "Email",
                              hintTextStr: "Masukkan Email Anda",
                              prefixicon:
                                  const Icon(Icons.email, color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormBuilderTextField(
                          name: 'password',
                          obscureText: true,
                          validator: (value) {
                            if (value != null && value.length < 6) {
                              return 'Masukkan Lebih Dari 6 Karakter';
                            } else {
                              return null;
                            }
                          },
                          decoration: FormInputCustom.inputDecor(
                              labelTextStr: "Password",
                              hintTextStr: "Masukkan Password Anda",
                              prefixicon:
                                  const Icon(Icons.person, color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        GFButton(
                          onPressed: () {
                            controller.formKey.currentState!.saveAndValidate();
                            var name = controller
                                .formKey.currentState!.value['username'];
                            var email =
                                controller.formKey.currentState!.value['email'];
                            var password = controller
                                .formKey.currentState!.value['password'];

                            EasyLoading.show(status: 'Loading...');
                            AuthController.instance
                                .registerUser(name, email, password);
                          },
                          text: "Daftar",
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
