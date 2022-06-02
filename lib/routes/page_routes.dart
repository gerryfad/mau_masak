import 'package:get/get.dart';
import 'package:mau_masak/binding/dashboard_binding.dart';
import 'package:mau_masak/pages/dashboard/dashboard_scren.dart';
import 'package:mau_masak/pages/login/login_view.dart';
import 'package:mau_masak/pages/onboard/onboard_view.dart';
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
      //binding: BMIBinding(),
    ),
    GetPage(
      name: PageName.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}
