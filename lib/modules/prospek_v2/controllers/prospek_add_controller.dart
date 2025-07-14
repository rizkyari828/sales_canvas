import 'package:intl/intl.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/overtime/submit_request_overtime.dart';
import 'package:sales/models/response/prospek/master_data_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProspekV2AddController extends GetxController {
  final ApiRepository apiRepository;
  ProspekV2AddController({required this.apiRepository});

  String date = "";
  DateTime selectedDate = DateTime.now();
  final noteController = TextEditingController();
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString userId = "".obs;
  RxString token = "".obs;
  RxInt idUser = 0.obs;
  RxInt idSource = 0.obs;
  RxInt idStatusProspect = 0.obs;
  RxInt idMediaCommunication = 0.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  RxBool showInputError = false.obs;
  final nickname = TextEditingController();
  final dateLastUpdate = TextEditingController();
  final dateCalled = TextEditingController();
  final dateFu = TextEditingController();
  final noteCommunication = TextEditingController();
  final reasonNotOrder = TextEditingController();
  final totalTransaction = TextEditingController();
  var masterData = <MasterData>[].obs;
  var listSourceOfOrder = <MasterData>[].obs;
  var listMediaCommuncation = <MasterData>[].obs;
  var listStatusProspect = <MasterData>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    loadMaster();
  }

  selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2028),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    controller.text =
        DateFormat("yyyy-MM-dd", "id_ID").format(selectedDate).toString();
  }

  Future<void> selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        // Untuk memastikan tampilan 24 jam di beberapa device
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // Format ke 24 jam: HH:mm
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      controller.text = '$hour:$minute';
    }
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    token.value = prefs.getString('token') ?? "";
    userId.value = prefs.getString('userId') ?? "";
    latitude.value = prefs.getDouble('initLatitude') ?? 0.0;
    longitude.value = prefs.getDouble('initLongitude') ?? 0.0;
  }

  void submitProspek() async {
    final res = await apiRepository.submitOvertime(
      SubmitOvertimeRequest(
          userId: int.parse(userId.value),
          name: nickname.text,
          sourceId: idSource.value,
          token: token.value,
          latitude: latitude.value.toString(),
          longitude: longitude.value.toString(),
          note: noteController.text),
    );

    if (res?.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
    }
  }

  void loadMaster() {
    getMasterDataProspek();
  }

  void getMasterDataProspek() async {
    final res = await apiRepository.getMasterData();
    masterData.value = res!.data!;
    for (var element in masterData) {
      if (element.flag == "1") {
        listSourceOfOrder.add(element);
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
