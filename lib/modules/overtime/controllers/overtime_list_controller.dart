import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/id_request.dart';
import 'package:sales/models/response/lembur/list_lembur.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OvertimeListController extends GetxController {
  final ApiRepository apiRepository;
  OvertimeListController({required this.apiRepository});

  var listLembur = <DataLembur>[].obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString userId = "".obs;
  RxString token = "".obs;

  RxInt page = 1.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onLoading() async {
    page.value = page.value + 1;

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getLembur(page.value);
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();
    // getCnC();
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    getLembur(page.value);
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    token.value = prefs.getString('token') ?? "";
    userId.value = prefs.getString('userId') ?? "";
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getLembur(page) async {
    final res = await apiRepository.listLembur(
        page: page, data: IdRequest(id: userId.value, token: token.value));
    listLembur.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listLembur.clear();
    page.value = 1;
    getLembur(page.value);
    refreshController.refreshCompleted();
  }

  void goToDetailPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_OVERTIME, arguments: id);
  }

  void goToAddPages() {
    Get.toNamed(Routes.ADD_OVERTIME);
  }
}
