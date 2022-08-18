import 'package:get/get.dart';
import 'package:mau_masak/binding/addresep_binding.dart';
import 'package:mau_masak/binding/dashboard_binding.dart';
import 'package:mau_masak/pages/activity/activity_view.dart';
import 'package:mau_masak/pages/addresep/addresep_view.dart';
import 'package:mau_masak/pages/admin/admin_view.dart';
import 'package:mau_masak/pages/admin/dataresep/dataresep_view.dart';
import 'package:mau_masak/pages/admin/dataresep/detailresepadmin_view.dart';
import 'package:mau_masak/pages/admin/pengguna/datausers_view.dart';
import 'package:mau_masak/pages/admin/reportkomentar/detaillapkomentar_view.dart';
import 'package:mau_masak/pages/admin/reportkomentar/laporankomentar_view.dart';
import 'package:mau_masak/pages/admin/reportpostingan/detaillappostingan_view.dart';
import 'package:mau_masak/pages/admin/reportpostingan/laporanpostingan_view.dart';
import 'package:mau_masak/pages/comment/comment_view.dart';
import 'package:mau_masak/pages/dashboard/dashboard_view.dart';
import 'package:mau_masak/pages/detailresep/detail_view.dart';
import 'package:mau_masak/pages/editresep/editresep_view.dart';
import 'package:mau_masak/pages/login/login_view.dart';
import 'package:mau_masak/pages/onboard/onboard_view.dart';
import 'package:mau_masak/pages/profile/editProfile/editprofile_view.dart';
import 'package:mau_masak/pages/profile/userprofile_view.dart';
import 'package:mau_masak/pages/report/report_view.dart';
import 'package:mau_masak/pages/resetpassword/reset_view.dart';
import 'package:mau_masak/pages/signup/signup_view.dart';
import 'page_names.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: PageName.onboard,
      page: () => const OnboardView(),
    ),
    GetPage(
      name: PageName.login,
      page: () => const LoginView(),
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
    GetPage(
      name: PageName.userprofile,
      page: () => const UserProfileView(),
    ),
    GetPage(
      name: PageName.activity,
      page: () => const ActivityView(),
    ),
    GetPage(
      name: PageName.resetpassword,
      page: () => const ResetPasswordView(),
    ),
    GetPage(
      name: PageName.admin,
      page: () => const AdminView(),
    ),
    GetPage(
      name: PageName.laporankomentar,
      page: () => const LaporanKomentarView(),
    ),
    GetPage(
      name: PageName.laporpengguna,
      page: () => const ReportView(),
    ),
    GetPage(
      name: PageName.laporanpostingan,
      page: () => const LaporanPostinganView(),
    ),
    GetPage(
      name: PageName.detaillaporankomentar,
      page: () => const DetailLaporanKomentarView(),
    ),
    GetPage(
      name: PageName.detaillaporanpostingan,
      page: () => const DetailLaporanPostinganView(),
    ),
    GetPage(
      name: PageName.listusers,
      page: () => const DataUsersView(),
    ),
    GetPage(
      name: PageName.listreseps,
      page: () => const DataResepView(),
    ),
    GetPage(
      name: PageName.detailresepadmin,
      page: () => const DetailResepAdminView(),
    ),
    GetPage(
      name: PageName.editresep,
      page: () => const EditResepView(),
    ),
  ];
}
