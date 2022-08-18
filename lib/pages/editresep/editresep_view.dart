import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/model/resep.dart';
import 'package:mau_masak/pages/addresep/addresep_controller.dart';
import 'package:mau_masak/pages/editresep/editresep_controller.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:mau_masak/utils/widget/input_label.dart';

class EditResepView extends StatefulWidget {
  const EditResepView({Key? key}) : super(key: key);

  @override
  State<EditResepView> createState() => _EditResepViewState();
}

class _EditResepViewState extends State<EditResepView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditResepController>(
      init: EditResepController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.black,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Edit Resep",
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ),
          body: SafeArea(
            child: controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: FormBuilder(
                      key: controller.formKeyAddResep,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Column(
                          children: [
                            controller.images == null
                                ? Column(
                                    children: [
                                      Image.network(
                                        controller.dataresep['foto_resep'],
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            controller.pickImages();
                                          },
                                          child: const Text("Ganti"))
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Image.file(
                                        controller.images!,
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            controller.deleteImage();
                                          },
                                          child: const Text("Delete"))
                                    ],
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputLabel(
                              label: 'Judul Resep',
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                color: Colors.white,
                                child: FormBuilderTextField(
                                  name: 'judul_resep',
                                  initialValue: controller
                                      .dataresep['nama_resep']
                                      .toString(),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Form Tidak Boleh Kosong";
                                    }
                                    return null;
                                  },
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                      top: 5,
                                      left: 10,
                                    ),
                                    hintText: "Tulis Judul Resep",
                                    hintStyle: const TextStyle(fontSize: 14),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide:
                                          const BorderSide(color: primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide:
                                          const BorderSide(color: primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputLabel(
                              label: 'Deskripsi',
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                color: Colors.white,
                                child: FormBuilderTextField(
                                  name: "deskripsi",
                                  initialValue: controller
                                      .dataresep['deskripsi']
                                      .toString(),
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
                                    hintText:
                                        "Tulis Deskripsi mengenai resep yang akan dibuat",
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputLabel(
                                child: FormBuilderTextField(
                                  name: 'waktu',
                                  initialValue:
                                      controller.dataresep['waktu'].toString(),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Form Tidak Boleh Kosong";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Lama Waktu Pengerjaan",
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    contentPadding:
                                        EdgeInsets.only(top: 5, left: 10),
                                  ),
                                ),
                                label: "Waktu Pengerjaan"),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                            const SizedBox(height: 10),
                            InputLabel(
                              label: 'Bahan',
                              child: Column(
                                children: [
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              bahanInput(
                                                  index,
                                                  controller,
                                                  controller.dataresep['bahan']
                                                          [index]
                                                      .toString())
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(),
                                        itemCount: controller.inputBahan),
                                  ),
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              bahanInputTambah(
                                                  index, controller)
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(),
                                        itemCount: controller.inputBahantambah),
                                  ),
                                  GFButton(
                                    onPressed: () {
                                      controller.addInputBahan();
                                    },
                                    text: "Bahan",
                                    textColor: Colors.grey,
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    type: GFButtonType.solid,
                                    blockButton: true,
                                    shape: GFButtonShape.pills,
                                    size: GFSize.LARGE,
                                    color: const Color.fromARGB(
                                        255, 255, 254, 254),
                                    buttonBoxShadow: true,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              thickness: 2,
                            ),
                            const SizedBox(height: 10),
                            InputLabel(
                              label: 'Langkah-langkah',
                              child: Column(
                                children: [
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              langkahInput(index, controller)
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(),
                                        itemCount: controller.inputLangkah),
                                  ),
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              langkahInputTambah(
                                                  index, controller)
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(),
                                        itemCount:
                                            controller.inputLangkahtambah),
                                  ),
                                  GFButton(
                                    onPressed: () {
                                      controller.addInputLangkah();
                                    },
                                    text: "Langkah",
                                    textColor: Colors.grey,
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    type: GFButtonType.solid,
                                    blockButton: true,
                                    shape: GFButtonShape.pills,
                                    size: GFSize.LARGE,
                                    color: const Color.fromARGB(
                                        255, 255, 254, 254),
                                    buttonBoxShadow: true,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              thickness: 2,
                            ),
                            const SizedBox(height: 50),
                            GFButton(
                              onPressed: () {
                                if (controller.formKeyAddResep.currentState!
                                    .saveAndValidate()) {
                                  String judulResep = controller.formKeyAddResep
                                      .currentState?.value['judul_resep'];
                                  String deskripsi = controller.formKeyAddResep
                                      .currentState?.value['deskripsi'];
                                  String waktu = controller.formKeyAddResep
                                      .currentState?.value['waktu'];
                                  print(controller.bahan);
                                  controller.editPost(
                                      deskripsi,
                                      judulResep,
                                      int.parse(waktu),
                                      (controller.dataresep['created_at']
                                              as Timestamp)
                                          .toDate(),
                                      controller.dataresep['likes'],
                                      controller.dataresep['dislikes']);
                                }
                              },
                              text: "Edit",
                              shape: GFButtonShape.pills,
                              fullWidthButton: true,
                              color: primaryColor,
                              size: GFSize.LARGE,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget bahanInput(
      int index, EditResepController controller, String initialValue) {
    TextEditingController bahan = TextEditingController();
    bahan.text = controller.dataresep['bahan'][index];
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: FormBuilderTextField(
              name: 'bahan ${controller.inputBahan.toString()}',
              onSaved: (value) {
                controller.bahan.add(
                    controller.dataresep['bahan'].contains(value)
                        ? controller.dataresep['bahan'][index]
                        : value);
              },
              controller: bahan,
              validator: (value) {
                if (value == null) {
                  return "Form Tidak Boleh Kosong";
                }
                return null;
              },
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  top: 5,
                  left: 10,
                ),
                hintText: "Tulis Bahan",
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: primaryColor),
                ),
              ),
            ),
          ),
          Visibility(
            visible: index >= 1,
            child: SizedBox(
              width: 30,
              child: IconButton(
                onPressed: () {
                  controller.removeInputBahan();
                },
                icon: const Icon(Icons.remove_circle),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bahanInputTambah(int index, EditResepController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: FormBuilderTextField(
              name: 'bahanTambah ${controller.inputBahan.toString()}',
              onSaved: (value) {
                controller.bahan.add(value ?? "");
              },
              validator: (value) {
                if (value == null) {
                  return "Form Tidak Boleh Kosong";
                }
                return null;
              },
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  top: 5,
                  left: 10,
                ),
                hintText: "Tulis Bahan",
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: primaryColor),
                ),
              ),
            ),
          ),
          Visibility(
            visible: index >= 0,
            child: SizedBox(
              width: 30,
              child: IconButton(
                onPressed: () {
                  controller.removeInputBahantambah();
                },
                icon: const Icon(Icons.remove_circle),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget langkahInput(int index, EditResepController controller) {
    TextEditingController langkah = TextEditingController();
    langkah.text = controller.dataresep['step'][index];
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: FormBuilderTextField(
              name: 'langkah ${controller.inputLangkah.toString()}',
              onSaved: (value) {
                controller.langkah.add(controller.dataresep['step'][index]);
              },
              controller: langkah,
              validator: (value) {
                if (value == null) {
                  return "Form Tidak Boleh Kosong";
                }
                return null;
              },
              autocorrect: false,
              textAlignVertical: TextAlignVertical.top,
              enableSuggestions: false,
              maxLines: 200,
              minLines: 1,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 6, bottom: 40, top: 5),
                hintText: "Tulis Langka-Langkah",
                hintStyle: const TextStyle(fontSize: 14),
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
          Visibility(
            visible: index >= 1,
            child: SizedBox(
              width: 30,
              child: IconButton(
                onPressed: () {
                  controller.removeInputLangkah();
                },
                icon: const Icon(Icons.remove_circle),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget langkahInputTambah(int index, EditResepController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: FormBuilderTextField(
              name: 'langkahtambah ${controller.inputLangkah.toString()}',
              onSaved: (value) {
                controller.langkah.add(value ?? "");
              },
              validator: (value) {
                if (value == null) {
                  return "Form Tidak Boleh Kosong";
                }
                return null;
              },
              autocorrect: false,
              textAlignVertical: TextAlignVertical.top,
              enableSuggestions: false,
              maxLines: 200,
              minLines: 1,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 6, bottom: 40, top: 5),
                hintText: "Tulis Langka-Langkah",
                hintStyle: const TextStyle(fontSize: 14),
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
          Visibility(
            visible: index >= 0,
            child: SizedBox(
              width: 30,
              child: IconButton(
                onPressed: () {
                  controller.removeInputLangkah();
                },
                icon: const Icon(Icons.remove_circle),
              ),
            ),
          )
        ],
      ),
    );
  }
}
