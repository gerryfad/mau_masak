import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:mau_masak/utils/widget/custom_input.dart';

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
        child: SingleChildScrollView(
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
              const CustomInput(
                label: "Email",
                obsecureText: false,
                prefixicon: Icon(Icons.email_outlined, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomInput(
                label: "Password",
                obsecureText: true,
                prefixicon: Icon(Icons.lock, color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
                text: "Facebook",
                icon: const Icon(
                  Icons.facebook,
                  color: Colors.white,
                ),
                type: GFButtonType.solid,
                blockButton: true,
                shape: GFButtonShape.pills,
                size: GFSize.LARGE,
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
      )),
    );
  }
}
