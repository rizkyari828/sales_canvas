// modules/leads/controllers/leads_list_controller.dart
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/user_id_request.dart';
import 'package:sales/models/response/Lead/list_lead_respone.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadsListController extends GetxController {
  final ApiRepository apiRepository;
  LeadsListController({required this.apiRepository});

  var list = <DataLead>[].obs;

  // existing
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString userId = "".obs;
  RxString token = "".obs;

  // pagination
  RxInt page = 1.obs;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  // NEW: tabs & current filter
  final tabs = const ['ALL', 'BARU', 'FOLLOW UP', 'PROSPEK'];
  final RxString currentFilter = 'ALL'.obs;

  // map label UI -> param API (silakan sesuaikan dengan backend)
  String? _mapFilterToApi(String label) {
    switch (label) {
      case 'BARU':
        return 'baru';
      case 'FOLLOW UP':
        return 'follow_up';
      case 'PROSPEK':
        return 'prospek';
      case 'ALL':
      default:
        return null; // tidak kirim 'type' jika ALL
    }
  }

  // dipanggil saat user klik tab
  void applyFilter(String label) {
    if (currentFilter.value == label) return;
    currentFilter.value = label;
    list.clear();
    page.value = 1;
    refreshController.resetNoData();
    getLeads(page.value);
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    getLeads(page.value);
  }

  Future<void> loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    token.value = prefs.getString('token') ?? "";
    userId.value = prefs.getString('userId') ?? "";
  }

  // include filter param
  Future<void> getLeads(int page) async {
    final typeParam = _mapFilterToApi(currentFilter.value);
    final res = await apiRepository.listLeads(
      data: UserIdRequest(
        id: userId.value,
        page: page.toString(),
        limit: '10',
        type: typeParam, // <<-- kirim hanya jika bukan ALL
      ),
    );
    list.addAll(res?.data ?? []);
  }

  void onLoading() async {
    page.value = page.value + 1;
    await Future.delayed(const Duration(milliseconds: 300));
    await getLeads(page.value);
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    list.clear();
    page.value = 1;
    await getLeads(page.value);
    refreshController.refreshCompleted();
  }

  void goToDetailPages({DataLead? dataLead}) {
    Get.toNamed(Routes.DETAIL_LEADS, arguments: {'data_lead': dataLead});
  }

  Future<void> goToAddPages() async {
    var result = await Get.toNamed(Routes.ADD_LEADS);
    if (result == true) {
      list.clear();
      page.value = 1;
      await getLeads(page.value);
    }
  }
}
