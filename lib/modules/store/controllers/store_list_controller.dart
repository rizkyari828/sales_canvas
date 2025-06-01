import 'package:get_storage/get_storage.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/user_id_request.dart';
import 'package:sales/models/response/store/list_store.dart';
import 'package:sales/modules/home/base_controller.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreListController extends BaseController {
  StoreListController({required ApiRepository apiRepository})
      : super(apiRepository: apiRepository);

  var listStore = <DataStore>[].obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString userId = "".obs;
  RxString token = "".obs;

  RxInt page = 1.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void goToKunjunganPages() {
    Get.toNamed(
      Routes.RESULT_KUNJUNGAN,
    );
  }

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

  final storage = GetStorage();

  void getStore(page) async {
    try {
      final res = await apiRepository.listStore(
          page: page, data: UserIdRequest(id: userId.value));

      if (res != null && res.data != null) {
        // Ubah objek DataStore ke JSON sebelum simpan
        final jsonList = res.data!.map((e) => e.toJson()).toList();
        storage.write('cached_items_page_$page', jsonList);

        listStore.addAll(res.data!);
      } else {
        _loadFromCache(page);
      }
    } catch (e) {
      // Gagal fetch, ambil dari cache
      _loadFromCache(page);
    }
  }

  void _loadFromCache(int page) {
    final cachedData = storage.read('cached_items_page_$page');

    if (cachedData != null) {
      listStore.addAll(List<DataStore>.from(
        (cachedData as List).map((e) => DataStore.fromJson(e)),
      ));
    }
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listStore.clear();
    page.value = 1;

    if (isConnectedToInternet.value == true) {
      clearCachedPages(prefix: 'cached_store_page_');
    }

    getStore(page.value);
    refreshController.refreshCompleted();
  }

  void clearCachedPages({String prefix = 'cached_store_page_'}) {
    final keys = storage.getKeys();
    final pageKeys = keys.where((k) => k.startsWith(prefix)).toList();

    for (final key in pageKeys) {
      storage.remove(key);
    }
  }

  void goToDetailPages({String id = "", String storeName = ''}) {
    Get.toNamed(Routes.DETAIL_STORE,
        arguments: {'id': id, 'storeName': storeName});
  }

  void goToAddPages() {
    Get.toNamed(Routes.ADD_LEAVE);
  }
}
