import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/pages/profile/profile_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                  onPressed: () {
                    Get.toNamed(PageName.editprofile);
                  },
                  icon: const Icon(
                    CupertinoIcons.settings,
                    color: Colors.black87,
                  )),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black87,
                    )),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(),
                  // profile photo
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(controller
                            .userData['profilePhoto'] ??
                        "https://images.pexels.com/photos/3990301/pexels-photo-3990301.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                  ),

                  // username
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "@${controller.userData['name']}",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: const [
                              Text(
                                '37',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Following',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            Text(
                              '8',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Followers',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: const [
                              Text(
                                '56',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '  Likes  ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // tombol follow
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: GFButton(
                          onPressed: () {},
                          text: "Follow",
                          shape: GFButtonShape.pills,
                          //fullWidthButton: true,
                          color: primaryColor,
                          size: GFSize.LARGE,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.resepData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image.network(
                              controller.resepData[index]['foto_resep'],
                              fit: BoxFit.cover,
                            ));
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
