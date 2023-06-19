import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/id_request.dart';
import 'package:sales/models/response/recap_history.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecapController extends GetxController
    with StateMixin<List<RecapHistoryResponse>> {
  final ApiRepository apiRepository;
  RecapController({required this.apiRepository});
  DateTime? initialDate;
  // List<DataHistory> _historyData = [];
  var historyData = <DataHistory>[].obs;
  DateTime? selectedDate;
  RxString month =
      DateFormat("MMMM yyyy", "id_ID").format(DateTime.now()).toString().obs;
  RxString monthSubmit =
      DateFormat("MM", "id_ID").format(DateTime.now()).toString().obs;
  // RxList<DataHistory> historyData = (List<DataHistory>.of([])).obs;
  // get historyData => this._historyData;
  // List<TableRow> priceTableRows = [];
  RxString idUser = "".obs;
  RxString token = "".obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // getData();
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    getData();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    token.value = prefs.getString('token') ?? "";
    idUser.value = prefs.getString('userId') ?? "";
  }

  @override
  void onClose() {
    historyData.value = [];
  }

  void getData() async {
    historyData.clear();
    monthSubmit.value = DateFormat("MM", "id_ID")
        .format(selectedDate ?? DateTime.now())
        .toString();
    final res = await apiRepository.getRecapHistory(
        IdRequest(id: idUser.value, token: token.value, month: monthSubmit.value));
    print(res);
    for (var data in res!.data ?? []) {
      historyData.add(data);
    }
    print(historyData);
  }
}
