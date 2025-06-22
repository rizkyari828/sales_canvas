import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/lembur/detail_request_lembur.dart';
import 'package:sales/models/request/lembur/update_approval_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/models/response/lembur/show_lembur.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OvertimeDetailController extends GetxController {
  final ApiRepository apiRepository;
  OvertimeDetailController({required this.apiRepository});

  final argm = Get.arguments;
  var detail = DataLembur().obs;
  String date = "";
  DateTime selectedDate = DateTime.now();
  final noRequestController = TextEditingController();
  final noteController = TextEditingController();
  final noteApprovalController = TextEditingController();
  final qtyController = TextEditingController();
  final dateController = TextEditingController();
  final dateCnCController = TextEditingController();
  RxString dateCnC = "".obs;
  RxString dateGoods = "".obs;
  RxString nameItem = "".obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getDetailLembur();
    loadUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {
    getDetailLembur();
    // getItemCnC();
    loadUsers();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }

  void getDetailLembur() async {
    // final res =
    //     await apiRepository.showLembur(ShowLemburRequest(id: argm.toString()));
    // print(res!.data!);
    // detail.value = res.data!.first;
  }

  void approval({
    action = "reject",
  }) async {
    final res = await apiRepository.updateApprovalLembur(
        detail.value.id.toString(),
        UpdateApprovalLemburRequest(
          action: action,
          noteApproval: noteApprovalController.text,
        ));
    // if (res?.error == false) {
    //   EasyLoading.showSuccess('Berhasil disimpan');
    //   getDetailLembur();
    //   loadUsers();
    // } else {
    //   EasyLoading.showError('Gagal disimpan');
    // }
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2028),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    dateCnC.value = selectedDate.toString();
  }

  void dateSubmit() {
    dateCnC.value = dateCnCController.text;
  }

  void updateGoods({name}) {
    // goods.removeWhere((e) => e.id == id);
    // goods[goods.indexWhere((element) => element.name == name)] = singleGoods;
  }

  void deleteGoods({name}) {}
}
