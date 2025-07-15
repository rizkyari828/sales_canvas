import 'package:intl/intl.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/overtime/get_list.dart';
import 'package:sales/models/response/prospek/list.dart';
import 'package:sales/models/response/prospek/master_status_response.dart';
import 'package:sales/models/response/prospek_v2/list_prospek_v2_response.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProspekV2Controller extends GetxController {
  final ApiRepository apiRepository;
  ProspekV2Controller({required this.apiRepository});

  var listProspek = <ListProspekV2>[].obs;
  final argm = Get.arguments;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString userId = "".obs;
  RxString token = "".obs;
  RxString status = "".obs;
  DateTime? selectedDate;
  RxString monthV =
      DateFormat("MMMM yyyy", "id_ID").format(DateTime.now()).toString().obs;
  RxString monthSubmit =
      DateFormat("MM", "id_ID").format(DateTime.now()).toString().obs;
  RxInt page = 1.obs;
  RxString type = "".obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxString monthLabel = "".obs;
  var masterStatus = <MasterStatus>[].obs;
  var listStatusOrder = <MasterStatus>[].obs;

  

  void onLoading() async {
    page.value = page.value + 1;
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getProspek(page.value);
    getMasterStatusProspek();
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
    getMasterStatusProspek();
    type.value = argm['type'].toString();
    status.value = argm['status'].toString();

    getProspek(page.value);
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

  void getProspek(page) async {
    String _month = DateFormat("MM", "id_ID")
        .format(selectedDate ?? DateTime.now())
        .toString();

    if (selectedDate != null) {
      _month = _month;
    } else {
      if (argm['month'].toString() == '') {
        _month = DateFormat("MM", "id_ID")
            .format(selectedDate ?? DateTime.now())
            .toString();
      } else {
        _month = argm['month'].toString();
      }
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDateS = formatter.format(now);
    var dateString = _month + ', ' + formattedDateS;
    DateFormat format = new DateFormat("MM, yyyy");
    var formattedDate = format.parse(dateString);
    monthLabel.value =
        DateFormat("MMMM yyyy", "id_ID").format(formattedDate).toString();

    final res = await apiRepository.listProspekV2(
        GetListRequest(
            id: userId.value,
            token: token.value,
            month: _month,
            status: status.value,
            type: type.value),
        page: page);
    listProspek.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listProspek.clear();
    page.value = 1;
    getProspek(page.value);
    refreshController.refreshCompleted();
  }

  void getMasterStatusProspek() async {
    // final res = await apiRepository.getMasterStatus();
    // masterStatus.value = res!.data!;
    // listStatusOrder.add(MasterStatus(id: 0, namaCat: "All"));
    // listStatusOrder.addAll(res.data!);
  }

  void goToDetailPages({String id = ""}) {
    Get.toNamed(Routes.ADD_PROSPEK_V2, arguments: id);
  }

  void goToAddPages() {
    Get.toNamed(Routes.ADD_PROSPEK_V2);
  }
}
