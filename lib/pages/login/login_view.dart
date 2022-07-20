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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
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
                            EasyLoading.show(status: 'loading...');
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
                        "Atau Login Dengan",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: textSecondaryColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GFButton(
                        onPressed: () {
                          AuthController.instance.signInWithGoogle();
                        },
                        text: "Sign In With Google",
                        textColor: const Color.fromARGB(255, 128, 127, 127),
                        icon: Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                            fit: BoxFit.cover),
                        type: GFButtonType.solid,
                        blockButton: true,
                        shape: GFButtonShape.pills,
                        size: GFSize.LARGE,
                        color: const Color.fromARGB(255, 255, 254, 254),
                        buttonBoxShadow: true,
                        elevation: 2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Tidak Memiliki Akun ?",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(PageName.signup);
                            },
                            child: const Text(
                              "Daftar",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      )),
    );
  }
}
