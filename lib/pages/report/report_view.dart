// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/pages/report/report_controller.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:mau_masak/utils/widget/input_label.dart';

class ReportView extends StatelessWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Laporkan Pengguna",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: GetBuilder<ReportController>(
          init: ReportController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: FormBuilder(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputLabel(
                      label: 'Alasan Pelaporan',
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.white,
                        child: FormBuilderTextField(
                          name: "report",
                          autocorrect: false,
                          validator: (value) {
                            if (value == null) {
                              return "Form Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          textAlignVertical: TextAlignVertical.top,
                          enableSuggestions: false,
                          maxLines: 200,
                          minLines: 1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 6, bottom: 90, top: 5),
                            hintText: "Tulis Alasan Pelaporan",
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    GFButton(
                      onPressed: () {
                        if (controller.formKey.currentState!
                            .saveAndValidate()) {
                          String alasan =
                              controller.formKey.currentState!.value['report'];
                          if (controller.type == 'komentar') {
                            controller.postLaporanKomentar(alasan);
                          } else {
                            controller.postLaporanPostingan(alasan);
                          }
                        }
                      },
                      text: "Laporkan",
                      shape: GFButtonShape.pills,
                      fullWidthButton: true,
                      color: primaryColor,
                      size: GFSize.LARGE,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
