import 'dart:async';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sales/models/request/id_request.dart';
import 'package:sales/models/request/rate/submit_rate_request.dart';
import 'package:sales/models/request/store/update_qty_request.dart';
import 'package:sales/models/request/update_fcm_profile_request.dart';
import 'package:sales/models/request/update_photo_profile_request.dart';
import 'package:sales/models/request/user_id_request.dart';
import 'package:sales/models/response/benefit/benefit_dashboard_response.dart';
import 'package:sales/models/response/rate/show_rate_review_response.dart';
import 'dart:io' as Io;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sales/api/api.dart';
import 'package:sales/models/response/reliver/list_reliver_response.dart';
import 'package:sales/models/response/store/list_store.dart';
import 'package:sales/models/response/user/users_response.dart';
import 'package:sales/modules/home/base_controller.dart';
import 'package:sales/modules/home/home.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:sales/shared/shared.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends BaseController {
  final ApiRepository apiRepository;
  HomeController({required this.apiRepository});

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  late LatLng myLocation = LatLng(0, 0);

  var currentTab = MainTabs.home.obs;
  var users = Rxn<UsersResponse>();
  var user = Rxn<Datum>();
  var benefitDashboard = Rxn<DataBenefitDashboard>();
  List<Marker> markers = <Marker>[];
  Set<Circle> circles = <Circle>{};
  var listEvent = <EventList>[].obs;

  late MainTab mainTab;
  late DiscoverTab discoverTab;
  late MeTab meTab;
  DateTime? selectedDate;
  RxString month =
      DateFormat("MMMM yyyy", "id_ID").format(DateTime.now()).toString().obs;
  RxString previousMonth = DateFormat("MMMM yyyy", "id_ID")
      .format(DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day))
      .toString()
      .obs;
  String monthInt = DateFormat("MM", "id_ID").format(DateTime.now()).toString();
  String previousMonthInt = DateFormat("MM", "id_ID")
      .format(DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day))
      .toString();
  RxString dateNow =
      DateFormat("dd MMMM yyyy", "id_ID").format(DateTime.now()).toString().obs;

  RxString name = "".obs;
  RxString idPegawai = "".obs;
  RxString userId = "".obs;
  RxString profilePhoto = "".obs;
  RxString username = "".obs;
  RxString token = "".obs;
  RxString tipe = "".obs;
  RxBool showRateDialog = false.obs;
  RxBool isConnectedToInternet = true.obs;
  RxBool isConnectedToInternetWidget = false.obs;

  ScrollController scrollController = ScrollController();

  var showRate = ShowReviewRateData().obs;

  var imageFileList = <XFile>[].obs;

  set _imageFile(XFile? value) {
    imageFileList.addAll((value == null ? null : <XFile>[value])!);
  }

  dynamic pickImageError;
  RxString? retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  late BuildContext context;
  final box = GetStorage();

  double position = 0;

  var listStore = <DataStore>[].obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;

  RxInt page = 1.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void goToKunjunganPages() {
    Get.toNamed(
      Routes.RESULT_KUNJUNGAN,
    );
  }

  void onLoading() async {
    // page.value = page.value + 1;

    // // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // getStore(page.value);
    // refreshController.loadComplete();
  }

  @override
  void onInit() async {
    super.onInit();
    // getReviewRate();
    mainTab = MainTab();
    loadUsers();
    discoverTab = DiscoverTab();
    meTab = MeTab();
    determinePosition();
    getDataEvent(1);
    getDataBenefit();
    getStore(page.value);
    // FirebaseMessaging messaging = FirebaseMessaging.instance;

    // messaging.getToken().then((value) {
    //   print("token FCM Home ${value}");
    //   submitToken(value);
    // });
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   _handleCheckConnectivity(result);
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data.containsKey('type')) {
        if (message.data['type'] == 'izin') {
          Get.toNamed(Routes.LEAVE);
        } else if (message.data['type'] == 'cuti') {
          Get.toNamed(Routes.BENEFIT);
        } else if (message.data['type'] == 'overtime') {
          Get.toNamed(Routes.PROSPEK);
        } else if (message.data['type'] == 'task') {
          Get.toNamed(Routes.HOME);
          // getCurrentIndex(MainTabs.inbox);
          // if (groupId.value == '3' ||
          //     groupId.value == '4' ||
          //     groupId.value == '2') {
          //   switchTab(1);
          // } else {
          //   switchTab(2);
          // }
          // return 1;
        } else {
          Get.toNamed(Routes.HOME);
        }
      }
    });
  }

  void callDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
          context: context,
          builder: (BuildContext context) => new RatingDialog(
                initialRating: 1.0,
                title: CommonWidget.minHeadText(
                  text: 'Berikan Review Anda',
                  align: TextAlign.center,
                ),
                message:
                    CommonWidget.subtitleText(text: showRate.value.note ?? ''),
                // your app's logo?
                image: Container(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: MediaQuery.of(context).size.height * .1,
                    // width: MediaQuery.of(context).size.width * .1,
                    fit: BoxFit.fill,
                  ),
                ),
                submitButtonText: 'Submit',
                commentHint: 'Masukkan komentar',
                onCancelled: () => print('cancelled'),
                onSubmitted: (response) {
                  submitReview(
                      rate: response.rating.round(), note: response.comment);
                  print(
                      'rating: ${response.rating}, comment: ${response.comment}');
                },
              ));
    });
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    name.value = prefs.getString('name') ?? "";
    idPegawai.value = prefs.getString('idPegawai') ?? "";
    userId.value = prefs.getString('userId') ?? "";
    profilePhoto.value = prefs.getString('profilePhoto') ?? "";
    username.value = prefs.getString('username') ?? "";
    token.value = prefs.getString('token') ?? "";
    userId.value = prefs.getString('userId') ?? "";
    tipe.value = prefs.getString('tipe') ?? "";
  }

  void signout() async {
    EasyLoading.show(status: 'loading..');
    await Future.delayed(Duration(milliseconds: 3000));
    var storage = Get.find<SharedPreferences>();
    try {
      if (storage.getString(StorageConstants.token) != null) {
        //   final res = await apiRepository.logout(LogoutRequest(
        //     username: storage.getString('simId'),
        //   ));
        //   if (res?.message == "Logout Success") {
        //     storage.clear();

        //     // NavigatorHelper.popLastScreens(popCount: 1);
        //     goToLoginPages();
        //     EasyLoading.dismiss();
        //   } else {
        //     Get.snackbar(
        //       "Error",
        //       "Logout Failed",
        //       icon: Icon(Icons.person, color: Colors.white),
        //       snackPosition: SnackPosition.TOP,
        //       backgroundColor: Colors.red,
        //       borderRadius: 20,
        //       margin: EdgeInsets.all(15),
        //       colorText: Colors.white,
        //       duration: Duration(seconds: 4),
        //       isDismissible: true,
        //       //dismissDirection: SnackDismissDirection.HORIZONTAL,
        //       forwardAnimationCurve: Curves.easeOutBack,
        //     );
        //     EasyLoading.dismiss();
        //   }
        storage.clear();
        // NavigatorHelper.popLastScreens(popCount: 1);
        goToLoginPages();
        EasyLoading.dismiss();
      } else {
        storage.clear();
        // NavigatorHelper.popLastScreens(popCount: 1);
        goToLoginPages();
        EasyLoading.dismiss();
      }
    } catch (e) {
      storage.clear();
      // NavigatorHelper.popLastScreens(popCount: 1);
      goToLoginPages();
      EasyLoading.dismiss();
    }
  }

  Future<void> onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    imageFileList.clear();
    if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final List<XFile>? pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );

          imageFileList.addAll(pickedFileList!);
        } catch (e) {
          pickImageError = e;
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );

          _imageFile = pickedFile;
        } catch (e) {
          pickImageError = e;
        }
      });
    }
  }

  Future<void> _displayPickImageDialog(BuildContext context, onPick) async {
    return onPick(200.0, 200.0, 50);
  }

  void switchTab(index) {
    if (tipe.value == '1') {
      var tab = _getCurrentTab(index);
      currentTab.value = tab;
    } else {
      var tab = _getCurrentTabTipe2(index);
      currentTab.value = tab;
    }
  }

  int getCurrentIndex(MainTabs tab) {
    if (tipe.value == "1") {
      switch (tab) {
        case MainTabs.home:
          return 0;
        case MainTabs.discover:
          return 1;
        case MainTabs.me:
          return 2;
        default:
          return 0;
      }
    } else {
      switch (tab) {
        case MainTabs.home:
          return 0;
        case MainTabs.me:
          return 1;
        default:
          return 0;
      }
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.home;
      case 1:
        return MainTabs.discover;
      case 2:
        return MainTabs.me;
      default:
        return MainTabs.home;
    }
  }

  MainTabs _getCurrentTabTipe2(int index) {
    switch (index) {
      case 0:
        return MainTabs.home;
      case 1:
        return MainTabs.me;
      default:
        return MainTabs.home;
    }
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "Error",
        "Location services are disabled.",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        isDismissible: true,
        //dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
      );

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Error",
          "Location permissions are denied",
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          //dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        print("Location permissions are denied");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Error",
        "Location permissions are permanently denied, we cannot request permissions.",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        isDismissible: true,
        //dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(
          "Location permissions are permanently denied, we cannot request permissions.");
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    myLocation = LatLng(position.latitude, position.longitude);
    markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: 'My Location')));

    final prefs = Get.find<SharedPreferences>();
    if (prefs.getString('token') != null) {
      prefs.setDouble(StorageConstants.initLatitude, position.latitude);
      prefs.setDouble(StorageConstants.initLongitude, position.longitude);
    }

    EasyLoading.dismiss();
  }

  void submitToken(token) async {
    final res = await apiRepository
        .updateFcmProfile(UpdateFcmProfileRequest(fcmToken: token));
    if (res!.error == false) {
      print('Token updated');
    } else {
      print('Token update failed');
    }
  }

  void getReviewRate() async {
    final res = await apiRepository.getRate();
    if (res!.error == false) {
      showRate.value = res.data ?? ShowReviewRateData();
      showRateDialog.value = true;
      callDialog();
      print('need review');
    } else {
      print('Token update failed');
    }
  }

  void submitReview({int rate = 0, String note = ''}) async {
    final res =
        await apiRepository.submitRate(SubmitRate(rate: rate, note: note));
    if (res!.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      // Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
    }
  }

  void submitPhotoProfile() async {
    List<String> _afterBase64 = [];
    EasyLoading.show(status: 'loading..');
    for (var itemBefore in imageFileList) {
      var mimeType = lookupMimeType(itemBefore.path);
      var bytesBefore = await Io.File(itemBefore.path).readAsBytes();
      String img64 = 'data:' +
          mimeType.toString() +
          ';base64,' +
          base64Encode(bytesBefore);
      _afterBase64.add(img64);
    }

    final res = await apiRepository.updatePhotoProfile(
        UpdatePhotoProfileRequest(base64Photo: _afterBase64.first));
    if (res!.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      final prefs = Get.find<SharedPreferences>();
      prefs.setString(
          StorageConstants.profilePhoto, res.data?.profilePhotoPath ?? "");
      profilePhoto.value = res.data?.profilePhotoPath ?? "";
      onRefresh();
      EasyLoading.dismiss();
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
      EasyLoading.dismiss();
    }
  }

  void goToLoginPages() {
    Get.offAllNamed(Routes.SPLASH);
  }

  void goToLeavePages() {
    Get.toNamed(Routes.LEAVE);
  }

  void goToStorePages() {
    Get.toNamed(Routes.STORE);
  }

  void closeWidget() {
    isConnectedToInternetWidget.value = false;
  }

  void goToLemburPages(String month, String type, String status,
      {bool needBack = true}) {
    if (needBack) {
      Get.back();
    }
    Get.toNamed(Routes.PROSPEK,
        arguments: {'month': month, 'type': type, 'status': status});
  }

  void goToBenefitPages() {
    Get.toNamed(Routes.BENEFIT);
  }

  void goToInputPages() {
    Get.toNamed(Routes.INPUT);
  }

  void goToProspekDialogPages() {
    Get.bottomSheet(
        Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    CommonWidget.rowHeight(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: CommonWidget.minHeadText(text: 'Detail Prospek'),
                      ),
                    ),
                    CommonWidget.rowHeight(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () =>
                              goToLemburPages(previousMonthInt, "old", ''),
                          child: _monthMenu(
                              monthText: 'Bulan Lalu'.toUpperCase(),
                              day:
                                  '${benefitDashboard.value?.jumlahBulanLalu ?? '0'}',
                              month: previousMonth.value),
                        ),
                        InkWell(
                          onTap: () => goToLemburPages(monthInt, "now", ''),
                          child: _monthMenu(
                              monthText: 'Bulan Ini'.toUpperCase(),
                              day:
                                  '${benefitDashboard.value?.jumlahBulanIni ?? '0'}',
                              month: month.value),
                        ),
                      ],
                    ),
                    CommonWidget.rowHeight(),
                    _statusTaskBar(),
                  ],
                ),
              ),
            ],
          ),
        ),
        elevation: 20.0,
        enableDrag: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        )));
  }

  Widget _monthMenu({monthText, day, month}) {
    final sw = SizeConfig().screenWidth;
    return Container(
        width: sw / 2.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 2.0, color: ColorConstants.borderColor),
          // boxShadow: [
          //   BoxShadow(
          //     color: CommonWidget.setOpacity(Colors.black, 0.3),
          //     blurRadius: 20.0,
          //     spreadRadius: 4.0,
          //     offset: Offset(
          //       -10.0,
          //       10.0,
          //     ),
          //   ),
          // ],
        ),
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              CommonWidget.bodyText(text: monthText),
              CommonWidget.rowHeight(),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CommonWidget.headText(text: day, color: Colors.white),
                ),
              ),
              CommonWidget.rowHeight(height: 8.0),
              CommonWidget.bodyText(text: month),
              CommonWidget.rowHeight(),
            ])));
  }

  Widget _statusTaskBar() {
    return InkWell(
      onTap: () => goToLemburPages(monthInt, "now", '3'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 2.0, color: ColorConstants.borderColor),
          // boxShadow: [
          //   BoxShadow(
          //     color: CommonWidget.setOpacity(Colors.black, 0.3),
          //     blurRadius: 20.0,
          //     spreadRadius: 4.0,
          //     offset: Offset(
          //       -10.0,
          //       10.0,
          //     ),
          //   ),
          // ],
        ),
        height: SizeConfig().screenHeight / 9,
        width: SizeConfig().screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidget.rowHeight(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: CommonWidget.bodyText(text: 'Data Booking'.toUpperCase()),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: ListTile(
                leading: Container(
                  decoration: new BoxDecoration(
                    color: ColorConstants.mainColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.library_books_rounded,
                      color: Colors.white,
                      size: SizeConfig().screenWidth * .06,
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    CommonWidget.headText(
                        text: "${benefitDashboard.value?.jumlahBoking ?? 0} ",
                        color: ColorConstants.mainColor),
                    CommonWidget.subtitleText(
                        text: "Dari bulan kemarin",
                        color: ColorConstants.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToRecapPages() {
    Get.toNamed(Routes.RECAP);
  }

  void goToEventPages() {
    Get.toNamed(Routes.EVENT);
  }

  void goToNotificationPages() {
    Get.toNamed(Routes.NOTIFICATION);
  }

  void dialogConfirmation() {
    if (isConnectedToInternet.value) {
      if (box.read('barang') != null) {
        Get.defaultDialog(
            title: "SIMPAN PRODUCT",
            content: CommonWidget.subtitleText(
                text: "Simpan data product yang belum/gagal tersimpan?",
                textAlign: TextAlign.center),
            textConfirm: 'OK',
            textCancel: 'CANCLE',
            onConfirm: () {
              Get.back();
              submitBarang();
              // Get.toNamed(Routes.STORE);
            },
            onCancel: () {
              Get.back();
            });
      } else {
        Get.defaultDialog(
            title: "PRODUK KOSONG",
            content: CommonWidget.subtitleText(
                text:
                    "Semua product sudah tersimpan, tidak ada data yang belum/gagal dikirim",
                textAlign: TextAlign.center),
            textConfirm: 'OK',
            onConfirm: () {
              Get.back();
            });
      }
    } else {
      Get.defaultDialog(
          title: "INTERNET TERPUTUS",
          content: CommonWidget.subtitleText(
              text:
                  "Koneksi anda masih belum terhubung, silahkan periksa kembali",
              textAlign: TextAlign.center),
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          });
    }
  }

  Future<void> submitBarang() async {
    print(box.read('barang'));
    QtyUpdateRequest qty = box.read('barang');
    final res = await apiRepository.decreaseQtyItems(
      qty,
    );

    if (res!.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      EasyLoading.dismiss();
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
      EasyLoading.dismiss();
    }
    // print(box.read('barang4'));
  }

  void goToKuisionerPages() {
    Get.toNamed(Routes.KUISIONER);
  }

  void goToTaskListPages() {
    Get.toNamed(Routes.HOME);
    // getCurrentIndex(MainTabs.inbox);
    // if (groupId.value == '3' || groupId.value == '4' || groupId.value == '2') {
    //   switchTab(1);
    // } else {
    //   switchTab(2);
    // }
  }

  void goToDetailEventPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_EVENT, arguments: id);
  }

  void getDataEvent(page) async {
    final res = await apiRepository.listEvent(page: page);
    listEvent.addAll(res?.data ?? []);
  }

  void getDataBenefit() async {
    final res = await apiRepository
        .listBenefitDashboard(IdRequest(id: userId.value, token: token.value));
    benefitDashboard.value = res?.data!.first;
  }

  void getStore(page) async {
    final res = await apiRepository.listStore(
        page: page, data: UserIdRequest(id: userId.value));
    listStore.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listStore.clear();
    page.value = 1;
    getStore(page.value);
    loadUsers();
    refreshController.refreshCompleted();
  }

  void goToDetailPages({String id = "", String storeName = ''}) {
    Get.toNamed(Routes.DETAIL_STORE,
        arguments: {'id': id, 'storeName': storeName});
  }

  void goToAddPages() {
    Get.toNamed(Routes.ADD_LEAVE);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
