import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/benefit_request.dart';
import 'package:sales/models/response/benefit/list_benefit.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BenefitController extends GetxController {
  final ApiRepository apiRepository;
  BenefitController({required this.apiRepository});

  var listBenefit = <ListBenefit>[].obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString userId = "".obs;
  final searchNameController = TextEditingController();
  RxInt page = 1.obs;
  DateTime? selectedDate;
  RxString month =
      DateFormat("MMMM yyyy", "id_ID").format(DateTime.now()).toString().obs;
  RxBool isSearch = false.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onLoading() async {
    page.value = page.value + 1;

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getBenefit(page.value);
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    getBenefit(page.value);
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    userId.value = prefs.getString('userId') ?? "";
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getBenefit(page) async {
    String _monthSubmit = DateFormat("MM", "id_ID")
        .format(selectedDate ?? DateTime.now())
        .toString();
    final res = await apiRepository.listBenefit(
        BenefitRequest(
            id: userId.value,
            month: _monthSubmit,
            search: searchNameController.text),
        page: page);
    listBenefit.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listBenefit.clear();
    page.value = 1;
    getBenefit(page.value);
    refreshController.refreshCompleted();
  }

  void goToDetailCutiPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_CUTI, arguments: id);
  }

  void goToAddCutiPages() {
    Get.toNamed(Routes.ADD_CUTI);
  }

  void onSearch(status) {
    isSearch.value = status;
  }
}
