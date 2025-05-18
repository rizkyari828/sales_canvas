import 'package:get/get.dart';
import 'package:sales/modules/benefit/bindings/benefit_binding.dart';
import 'package:sales/modules/benefit/views/benefit_add_view.dart';
import 'package:sales/modules/benefit/views/benefit_detail_view.dart';
import 'package:sales/modules/benefit/views/benefit_view.dart';
import 'package:sales/modules/input/bindings/input_binding.dart';
import 'package:sales/modules/input/views/add_input_view.dart';
import 'package:sales/modules/kuisioner/bindings/kuisioner_binding.dart';
import 'package:sales/modules/kuisioner/views/add_kuisioner_view.dart';
import 'package:sales/modules/leave/bindings/leave_binding.dart';
import 'package:sales/modules/leave/views/add_leave_view.dart';
import 'package:sales/modules/leave/views/detail_leave_view.dart';
import 'package:sales/modules/leave/views/leave_view.dart';
import 'package:sales/modules/prospek/bindings/prospek_binding.dart';
import 'package:sales/modules/prospek/views/add_prospek_view.dart';
import 'package:sales/modules/prospek/views/detail_prospek_view.dart';
import 'package:sales/modules/prospek/views/prospek_view.dart';
import 'package:sales/modules/store/bindings/store_binding.dart';
import 'package:sales/modules/store/views/add_store_view.dart';
import 'package:sales/modules/store/views/detail_store_view.dart';
import 'package:sales/modules/store/views/result_kunjungan.dart';
import 'package:sales/modules/store/views/store_view.dart';

import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/absensi/bindings/absensi_binding.dart';
import '../modules/absensi/views/absensi_view.dart';
import '../modules/auth/auth.dart';
import '../modules/home/attendance/attendance_binding.dart';
import '../modules/home/home.dart';
import '../modules/modules.dart';
import '../modules/recap/bindings/recap_binding.dart';
import '../modules/recap/views/recap_view.dart';
import '../modules/event/bindings/event_binding.dart';
import '../modules/event/views/event_detail_view.dart';
import '../modules/event/views/event_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    // GetPage(
    //   name: Routes.AUTH,
    //   page: () => AuthScreen(),
    //   binding: AuthBinding(),
    //   children: [
    //     GetPage(name: Routes.REGISTER, page: () => RegisterScreen()),
    //     GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    //   ],
    // ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LEAVE,
      page: () => LeaveView(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: Routes.ADD_LEAVE,
      page: () => AddLeaveView(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_LEAVE,
      page: () => LeaveDetailView(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: Routes.PROSPEK,
      page: () => ProspekView(),
      binding: LemburBinding(),
    ),
    GetPage(
      name: Routes.ADD_PROSPEK,
      page: () => ProspekAddView(),
      binding: LemburBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_PROSPEK,
      page: () => ProspekDetailView(),
      binding: LemburBinding(),
    ),
    GetPage(
      name: Routes.BENEFIT,
      page: () => BenefitView(),
      binding: BenefitBinding(),
    ),
    GetPage(
      name: Routes.ADD_CUTI,
      page: () => BenefitAddView(),
      binding: BenefitBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_CUTI,
      page: () => BenefitDetailView(),
      binding: BenefitBinding(),
    ),
    GetPage(
      name: Routes.ABSENSI,
      page: () => AbsensiView(),
      binding: AbsensiBinding(),
    ),
    GetPage(
      name: Routes.RECAP,
      page: () => RecapView(),
      binding: RecapBinding(),
    ),
    GetPage(
      name: Routes.DISCOVER_TAB,
      page: () => DiscoverTab(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: Routes.EVENT,
      page: () => EventView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_EVENT,
      page: () => ReliverDetailView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.INPUT,
      page: () => AddInputView(),
      binding: InputBinding(),
    ),
    GetPage(
      name: Routes.STORE,
      page: () => StoreView(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: Routes.ADD_STORE,
      page: () => AddStoreView(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_STORE,
      page: () => StoreDetailView(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: Routes.KUISIONER,
      page: () => AddKuisionerView(),
      binding: KusionerBinding(),
    ),
    GetPage(
      name: Routes.RESULT_KUNJUNGAN,
      page: () => ResultKunjunganView(),
      binding: StoreBinding(),
    ),
  ];
}
