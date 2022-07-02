import 'package:get/get.dart';
import 'package:mau_masak/binding/addresep_binding.dart';
import 'package:mau_masak/binding/dashboard_binding.dart';
import 'package:mau_masak/pages/addresep/addresep_view.dart';
import 'package:mau_masak/pages/comment/comment_view.dart';
import 'package:mau_masak/pages/dashboard/dashboard_view.dart';
import 'package:mau_masak/pages/detailresep/detail_view.dart';
import 'package:mau_masak/pages/login/login_view.dart';
import 'package:mau_masak/pages/onboard/onboard_view.dart';
import 'package:mau_masak/pages/profile/editProfile/editprofile_view.dart';
import 'package:mau_masak/pages/signup/signup_view.dart';
import 'page_names.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: PageName.onboard,
      page: () => const OnboardView(),
      //binding: BMIBinding(),
    ),
    GetPage(
      name: PageName.login,
      page: () => const LoginView(),
      //binding: BMIBinding(),
    ),
    GetPage(
      name: PageName.signup,
      page: () => const SignupView(),
    ),
    GetPage(
      name: PageName.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: PageName.addresep,
      page: () => const AddresepView(),
      binding: AddresepBinding(),
    ),
    GetPage(
      name: PageName.detail,
      page: () => const DetailView(),
    ),
    GetPage(
      name: PageName.editprofile,
      page: () => const EditProfileView(),
    ),
    GetPage(
      name: PageName.comment,
      page: () => const CommentView(),
    ),
  ];
}
