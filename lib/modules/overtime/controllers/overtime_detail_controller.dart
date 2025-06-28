import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  var detail = ShowDataLembur().obs;
  String date = "";
  DateTime selectedDate = DateTime.now();
  final noRequestController = TextEditingController();
  final noteController = TextEditingController();
  final noteApprovalController = TextEditingController();
  final qtyController = TextEditingController();
  final dateController = TextEditingController();
  final dateCnCController = TextEditingController();
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString statusApproval = "".obs;

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
    final res =
        await apiRepository.showLembur(ShowLemburRequest(id: argm.toString()));
    print(res!.data!);
    detail.value = res.data!.first;
    statusApproval.value = detail.value.statusLembur ?? '';
  }

  void approval({
    action = "reject",
  }) async {
    String id_action = '0';
    if (action == 'reject') {
      id_action = '0';
    } else {
      id_action = '1';
    }
    final res =
        await apiRepository.updateApprovalLembur(UpdateApprovalLemburRequest(
      id: detail.value.idLembur.toString(),
      action: id_action,
      noteApproval: noteApprovalController.text,
    ));
    if (res?.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      getDetailLembur();
      loadUsers();
    } else {
      EasyLoading.showError('Gagal disimpan');
    }
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2028),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
  }
}
