import 'package:intl/intl.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/overtime/get_list.dart';
import 'package:sales/models/request/prospek_v2/submit_request_prospek_v2.dart';
import 'package:sales/models/response/prospek/master_data_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sales/models/response/prospek_v2/detail_prospek_v2_response.dart';
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
  RxString status = "".obs;
  RxString sourceOrderValue = "".obs;
  RxString statusProspectValue = "".obs;
  RxString mediaCommunicationValue = "".obs;
  RxBool isFilled = true.obs;
  RxBool disabled = false.obs;
  RxBool enabled = true.obs;

  RxBool showInputError = false.obs;
  final prospectNameController = TextEditingController();
  final productNameController = TextEditingController();
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

  final argm = Get.arguments;
  var detail = ProspekDetailV2().obs;

  RxBool isEdit = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    loadMaster();
    if (argm != null) {
      getDetailProspek();
    }
  }

  void getDetailProspek() async {
    final res = await apiRepository.showProspekV2(
        argm.toString(), GetListRequest(id: '0', token: ''));
    detail.value = res?.data!.first ?? ProspekDetailV2();

    // Set controller dan Rx variabel dari detail
    prospectNameController.text = detail.value.prospectName ?? '';
    productNameController.text = detail.value.productName ?? '';
    totalTransaction.text = detail.value.totalTransaction ?? '';
    dateCalled.text = detail.value.dateCalled ?? '';
    dateFu.text = detail.value.dateFu ?? '';
    noteCommunication.text = detail.value.noteCommunication ?? '';
    reasonNotOrder.text = detail.value.reasonNotOrder ?? '';
    dateLastUpdate.text = detail.value.dateLastUpdate ?? '';

    idStatusProspect.value = detail.value.idStatusProspect ?? 0;
    idMediaCommunication.value = detail.value.idMediaCommunication ?? 0;
    idSource.value = detail.value.idSource ?? 0;

    statusProspectValue.value = detail.value.statusProspectValue ?? '';
    mediaCommunicationValue.value = detail.value.mediaCommunicationValue ?? '';
    sourceOrderValue.value = detail.value.sourceOrderValue ?? '';

    // Jika ada status/logic lain
    status.value = detail.value.statusProspectValue ?? '';

    // Disable input jika status tertentu
    if (detail.value.statusProspectValue == "3" ||
        detail.value.statusProspectValue == "4" ||
        detail.value.statusProspectValue == "5") {
      disabled.value = true;
      enabled.value = false;
    }

    isEdit.value = true;
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
    final req = SubmitProspekV2Request(
      userId: int.tryParse(userId.value) ?? 0,
      prospectName: prospectNameController.text,
      productName: productNameController.text,
      totalTransaction: totalTransaction.text,
      idStatusProspect: idStatusProspect.value,
      dateCalled: dateCalled.text,
      idMediaCommunication: idMediaCommunication.value,
      dateFu: dateFu.text,
      noteCommunication: noteCommunication.text,
      idSource: idSource.value,
      reasonNotOrder: reasonNotOrder.text,
      dateLastUpdate: dateLastUpdate.text,
    );

    final res = await apiRepository.submitProspectV2(req);

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
