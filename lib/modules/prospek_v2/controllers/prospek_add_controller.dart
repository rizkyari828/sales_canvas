import 'package:intl/intl.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/prospek_v2/submit_request_prospek_v2.dart';
import 'package:sales/models/response/master_data_2_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sales/models/response/prospek_v2/detail_prospek_v2_response.dart';
import 'package:sales/modules/home/base_controller.dart';

class ProspekV2AddController extends BaseController {
  ProspekV2AddController({required ApiRepository apiRepository})
      : super(apiRepository: apiRepository);

  String date = "";
  DateTime selectedDate = DateTime.now();
  final noteController = TextEditingController();

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
  RxString minatProductId = "".obs;
  RxString minatProduct = "".obs;
  var listMinatProduct = <MasterData2>[].obs;

  RxBool showInputError = false.obs;
  final prospectNameController = TextEditingController();
  final productNameController = TextEditingController();
  final dateLastUpdate = TextEditingController();
  final dateCalled = TextEditingController();
  final dateFu = TextEditingController();
  final noteCommunication = TextEditingController();
  final reasonNotOrder = TextEditingController();
  final totalTransaction = TextEditingController();
  var masterData = <MasterData2>[].obs;
  var listSourceOfOrder = <MasterData2>[].obs;
  var listMediaCommuncation = <MasterData2>[].obs;
  var listStatusProspect = <MasterData2>[].obs;

  final argm = Get.arguments;
  var detail = ProspekDetailV2().obs;

  RxBool optionalText = false.obs;
  RxString optionalTextValue = ''.obs;

  RxBool isEdit = false.obs;
  RxString statusBar = "Prospek".obs;

  @override
  void onInit() {
    super.onInit();
    getMasterData();
  }

  @override
  void onReady() {
    super.onReady();

    if (argm != null) {
      getDetailProspek();
    }

    if (detail.value.statusProspectValue == 'Order') {
      statusBar.value = 'Order';
    }
  }

  void getDetailProspek() async {
    // final res = await apiRepository.showProspekV2(
    //     argm.toString(), GetListRequest(id: '0', token: ''));
    // detail.value = res?.data!.first ?? ProspekDetailV2();
    detail.value = argm['data_lead'];

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
    idSource.value = detail.value.idStatusOrder ?? 0;

    statusProspectValue.value = detail.value.statusProspectValue ?? '';
    mediaCommunicationValue.value = detail.value.mediaCommunicationValue ?? '';
    sourceOrderValue.value = detail.value.sourceOrderValue ?? '';

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

  void submitProspek() async {
    final req = SubmitProspekV2Request(
      userId: userId.value,
      prospectName: prospectNameController.text,
      productName: productNameController.text,
      totalTransaction: totalTransaction.text,
      idStatusProspect: idStatusProspect.value.toString(),
      dateCalled: dateCalled.text,
      idMediaCommunication: idMediaCommunication.value.toString(),
      dateFu: dateFu.text,
      noteCommunication: noteCommunication.text,
      statusOrder: idSource.value.toString(),
      reasonNotOrder: reasonNotOrder.text,
    );

    final res = await apiRepository.submitProspectV2(req);

    if (res?.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
    }
  }

  void getMasterData() async {
    masterData.clear();
    final resListLeadSource = await apiRepository.getMasterData2('Sumber Lead');
    masterData.value = resListLeadSource!.data!;
    for (var element in masterData) {
      listMinatProduct.add(element);
    }

    masterData.clear();
    final resListLeadCategory =
        await apiRepository.getMasterData2('Kategori Lead');
    masterData.value = resListLeadCategory!.data!;
    for (var element in masterData) {
      listStatusProspect.add(element);
    }

    masterData.clear();
    final resListStatusLead = await apiRepository.getMasterData2('Status Lead');
    masterData.value = resListStatusLead!.data!;
    for (var element in masterData) {
      listMediaCommuncation.add(element);
    }

    masterData.clear();
    final resListMinatProduct =
        await apiRepository.getMasterData2('Status Lead');
    masterData.value = resListMinatProduct!.data!;
    for (var element in masterData) {
      listSourceOfOrder.add(element);
    }
  }

  void changeStatus(value) {
    if (value == 'Dll') {
      optionalText.value = true;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
