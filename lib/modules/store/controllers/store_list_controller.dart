import 'package:get_storage/get_storage.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/user_id_request.dart';
import 'package:sales/models/response/dashboard/dashboard_kunjungan_response.dart';
import 'package:sales/models/response/store/list_store.dart';
import 'package:sales/modules/home/base_controller.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreListController extends BaseController {
  StoreListController({required ApiRepository apiRepository})
      : super(apiRepository: apiRepository);

  final listKunjungan = <DataStore>[].obs;
  final listNonKunjungan = <DataStore>[].obs;

  final RxString groupName = "".obs;
  final RxString groupId = "".obs;
  final RxString userId = "".obs;
  final RxString token = "".obs;

  final RxString typePage = ''.obs; // 'kunjungan' | 'non kunjungan'
  final RxInt page = 1.obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  var detailDashboard = DashbooardKunjunganData().obs;

  // === Cache key helpers ===
  static const String _cachePrefixKunjungan = 'cached_items_kunjungan_page_';
  static const String _cachePrefixNonKunjungan =
      'cached_items_non_kunjungan_page_';

  String _cacheKey(int page, String type) => type == 'kunjungan'
      ? '$_cachePrefixKunjungan$page'
      : '$_cachePrefixNonKunjungan$page';

  final storage = GetStorage();

  // === Navigation ===
  void goToKunjunganPages() {
    Get.toNamed(Routes.RESULT_KUNJUNGAN);
  }

  void goToDetailPages({
    String id = "",
    String type = '',
    String storeName = '',
    String statusKunjungan = '',
  }) {
    Get.toNamed(Routes.DETAIL_STORE, arguments: {
      'id': id,
      'type': type,
      'storeName': storeName,
      'status_kunjungan': statusKunjungan,
    });
  }

  Future<void> goToAddPages() async {
    final result = await Get.toNamed(Routes.ADD_STORE);
    if (result == true) {
      if (typePage.value == 'kunjungan') {
        listKunjungan.clear();
      } else {
        listNonKunjungan.clear();
      }
      page.value = 1;
      getStore(page.value);
    }
  }

  // === Lifecycle ===
  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['type'] is String) {
      typePage.value = args['type'];
    }
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers().then((_) {
      getStore(page.value); // sekarang typePage sudah terisi
    });
  }

  Future<void> loadUsers() async {
    final prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    token.value = prefs.getString('token') ?? "";
    userId.value = prefs.getString('userId') ?? "";
  }

  @override
  void onClose() {
    super.onClose();
  }

  // === Paging ===
  Future<void> onLoading() async {
    page.value = page.value + 1;
    await Future.delayed(const Duration(milliseconds: 300));
    getStore(page.value);
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    page.value = 1;

    final type = typePage.value;
    if (type == 'kunjungan') {
      listKunjungan.clear();
    } else {
      listNonKunjungan.clear();
    }

    if (isConnectedToInternetWidget.value == false) {
      clearCachedPages(
        prefix: type == 'kunjungan'
            ? _cachePrefixKunjungan
            : _cachePrefixNonKunjungan,
      );
    }

    getStore(page.value);
    refreshController.refreshCompleted();
  }

  void clearCachedPages({required String prefix}) {
    // pastikan Iterable-nya sudah bertipe String
    final Iterable<String> stringKeys = storage.getKeys().whereType<String>();

    final List<String> pageKeys =
        stringKeys.where((k) => k.startsWith(prefix)).toList();

    for (final key in pageKeys) {
      storage.remove(key);
    }
  }

  // === Data ===
  void getStore(int page) async {
    final type = typePage.value; // 'kunjungan' atau 'non kunjungan'
    try {
      // KIRIM type ke API agar response beda sesuai tipe
      final res = await apiRepository.listStore(
        page: page,
        data: UserIdRequest(id: userId.value, type: type),
      );

      final hasData = res != null && res.data != null && res.data!.isNotEmpty;

      if (hasData) {
        // Simpan cache per tipe
        final jsonList = res!.data!.map((e) => e.toJson()).toList();
        storage.write(_cacheKey(page, type), jsonList);

        // Tambahkan ke list yang benar
        if (type == 'kunjungan') {
          listKunjungan.addAll(res.data!);
        } else {
          listNonKunjungan.addAll(res.data!);
        }
      } else {
        _loadFromCache(page, type);
      }
    } catch (_) {
      _loadFromCache(page, type);
    }
  }

  void _loadFromCache(int page, String type) {
    final cachedData = storage.read(_cacheKey(page, type));
    if (cachedData == null) return;

    final items = List<DataStore>.from(
      (cachedData as List).map((e) => DataStore.fromJson(e)),
    );

    if (type == 'kunjungan') {
      listKunjungan.addAll(items);
    } else {
      listNonKunjungan.addAll(items);
    }
  }

  Future<void> getDataDashboard() async {
    final res = await apiRepository.getDashboardKunjungan(userId.value);
    if (res?.data != null && res!.data!.isNotEmpty) {
      detailDashboard.value = res.data!.first;
    }
  }
}
