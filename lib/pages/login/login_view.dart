import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/pages/auth/auth_controller.dart';
import 'package:mau_masak/pages/login/login_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:mau_masak/utils/widget/form_custom.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(30),
        //   margin: ,
        child: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: FormBuilder(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                        height: 10,
                      ),
                      const Text(
                        "Silahkan Login Menggunakan Akun Anda",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: textSecondaryColor),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FormBuilderTextField(
                        name: 'email',
                        validator: (value) {
                          if (value != null &&
                              !EmailValidator.validate(value)) {
                            return 'Masukkan Email Yang Valid';
                          } else if (value == null) {
                            return "Form Tidak Boleh Kosong";
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
                          } else if (value == null) {
                            return "Form Tidak Boleh Kosong";
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(PageName.resetpassword);
                          },
                          child: const Text(
                            "Lupa Password ?",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GFButton(
                        onPressed: () async {
                          if (controller.formKey.currentState!
                              .saveAndValidate()) {
                            var email =
                                controller.formKey.currentState!.value['email'];
                            var password = controller
                                .formKey.currentState!.value['password'];

                            AuthController.instance.loginUser(email, password);
                          }
                        },
                        text: "Login",
                        shape: GFButtonShape.pills,
                        fullWidthButton: true,
                        color: primaryColor,
                        size: GFSize.LARGE,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Tidak Memiliki Akun ?",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: textSecondaryColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GFButton(
                        onPressed: () async {
                          Get.toNamed(PageName.signup);
                        },
                        text: "Daftar",
                        shape: GFButtonShape.pills,
                        fullWidthButton: true,
                        color: primaryColor,
                        size: GFSize.LARGE,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            }),
      )),
    );
  }
}
