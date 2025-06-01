import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/kuisioner_request.dart';
import 'package:sales/models/request/user_id_request.dart';
import 'package:sales/models/response/izin/type_izin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales/models/response/kuisioner_response.dart';
import 'package:sales/modules/home/base_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KusionerController extends BaseController {
  KusionerController({required ApiRepository apiRepository})
      : super(apiRepository: apiRepository);

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final answerController = TextEditingController();

  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString placement = "".obs;
  RxString nameItem = "".obs;
  RxString idType = "".obs;
  RxString idUser = "".obs;
  RxString username = "".obs;
  RxString token = "".obs;

  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  RxInt page = 1.obs;

  RxString validationDate = "".obs;
  var listKuisioner = <ListKuisioner>[].obs;

  final selectedAnswer = ''.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void setAnswer(String value) {
    selectedAnswer.value = value;
  }

  void submit() {
    if (endDate.compareTo(startDate) >= 0) {
      submitData();
    } else {
      validationDate.value =
          'Tanggal selesai tidak bisa lebih besar dari tanggal mulai';
    }
  }

  void submitData() async {
    final res = await apiRepository.submitKuisioner(
      KuisionerRequest(
        idUser: username.value,
        idKuisioner: token.value,
        answer: answerController.text,
      ),
    );
    if (res?.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      EasyLoading.dismiss();
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
      EasyLoading.dismiss();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    getKuisioner(page);
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    placement.value = prefs.getString('placement') ?? "";
    token.value = prefs.getString('token') ?? "";
    idUser.value = prefs.getString('userId') ?? "";
    username.value = prefs.getString('username') ?? "";
  }

  selectDateStart(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    startDate = selectedDate;
    startDateController.text =
        DateFormat("yyyy-MM-dd", "id_ID").format(selectedDate).toString();
  }

  selectDateEnd(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    endDate = selectedDate;
    endDateController.text =
        DateFormat("yyyy-MM-dd", "id_ID").format(selectedDate).toString();
  }

  void getKuisioner(page) async {
    listKuisioner.add(
        ListKuisioner(id: 1, type: 'essay', question: 'Ini Untuk Soal Essay'));
    listKuisioner.add(ListKuisioner(
        id: 2,
        type: 'pg',
        question: 'Ini Untuk Soal Pilihan',
        optionA: 'Pilihan A',
        optionB: 'Pilihan B',
        optionC: 'Pilihan C',
        optionD: 'Pilihan D'));
    // final res = await apiRepository.listKuisioner(
    //     page: page, data: UserIdRequest(id: idUser.value));
    // listKuisioner.addAll(res?.data ?? []);
  }

  void onLoading() async {
    page.value = page.value + 1;

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getKuisioner(page.value);
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listKuisioner.clear();
    page.value = 1;
    getKuisioner(page.value);
    refreshController.refreshCompleted();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
