import 'package:sales/api/api_repository.dart';
import 'package:sales/models/response/Lead/list_lead_respone.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadsDetailController extends GetxController {
  final ApiRepository apiRepository;
  LeadsDetailController({required this.apiRepository});

  final argm = Get.arguments;
  var detail = DataLead().obs;
  String date = "";
  DateTime selectedDate = DateTime.now();
  RxString groupName = "".obs;
  RxString groupId = "".obs;

  RxList<Foto> imageFileList = (List<Foto>.of([])).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    detail.value = argm['data_lead'];
    // getDetailIzin();
    imageFileList.addAll(detail.value.foto ?? []);
    loadUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }
}
