import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/id_request.dart';
import 'package:sales/models/response/izin/list_izin.dart';
import 'package:sales/models/response/store/list_store.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreListController extends GetxController {
  final ApiRepository apiRepository;
  StoreListController({required this.apiRepository});

  var listStore = <DataStore>[].obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString userId = "".obs;
  RxString token = "".obs;

  RxInt page = 1.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onLoading() async {
    page.value = page.value + 1;

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getStore(page.value);
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();
    listStore.add(DataStore(
        id: 3,
        name: 'Toko Rakyat',
        address: 'Jakarta Selatan',
        type: 'Kelontongan'));
    listStore.add(DataStore(
        id: 3,
        name: 'Toko Sejahtera',
        address: 'Jakarta Utara',
        type: 'Retail',
        photo:
            'https://media.istockphoto.com/id/1314210006/photo/grocery-store-shop-in-vintage-style-with-fruit-and-vegetables-crates-on-the-street.jpg?s=612x612&w=0&k=20&c=UFL3bRQkWH7dt6EMLswvM4u8-1sPQU9T5IFHXuBbClU='));
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    getStore(page.value);
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

  void getStore(page) async {
    // final res = await apiRepository.listIzin(
    //     page: page, data: IdRequest(id: userId.value, token: token.value));
    // listStore.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listStore.clear();
    page.value = 1;
    getStore(page.value);
    refreshController.refreshCompleted();
  }

  void goToDetailPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_STORE, arguments: id);
  }

  void goToAddPages() {
    Get.toNamed(Routes.ADD_LEAVE);
  }
}
