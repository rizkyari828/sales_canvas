import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/detail_request_leave.dart';
import 'package:sales/models/request/izin/update_approval_request.dart';
import 'package:sales/models/response/izin/show_izin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/constants/storage.dart';
import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/utils/size_config.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';

class StoreDetailController extends GetxController {
  final ApiRepository apiRepository;
  StoreDetailController({required this.apiRepository});

  final argm = Get.arguments;
  var detail = DataIzin().obs;
  String date = "";
  DateTime selectedDate = DateTime.now();
  final noRequestController = TextEditingController();
  final noteController = TextEditingController();
  final noteApprovalController = TextEditingController();
  final qtyController = TextEditingController();
  final dateController = TextEditingController();
  final dateCnCController = TextEditingController();
  RxString dateCnC = "".obs;
  RxString dateGoods = "".obs;
  RxString nameItem = "".obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString name = "".obs;

  late LatLng myLocation = LatLng(0, 0);
  var markers = <Marker>[].obs;
  var circles = Set<Circle>().obs;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  RxString locationDetail = "".obs;
  RxString locationStore = "".obs;

  RxBool isAbsent = false.obs;
  RxBool isAbsentOut = false.obs;
  RxString absentTime = '00:00'.obs;
  RxString absentTimeOut = '00:00'.obs;
  RxBool isShowMaps = true.obs;

  RxString dateNow = DateFormat("dd MMMM yyyy HH:mm:ss", "id_ID")
      .format(DateTime.now())
      .toString()
      .obs;

  final ImagePicker _picker = ImagePicker();

  var imageFileList = <XFile>[].obs;
  dynamic pickImageError;

  set _imageFile(XFile? value) {
    imageFileList.addAll((value == null ? null : <XFile>[value])!);
  }

  void showMaps() {
    isShowMaps.value = true;
  }

  void hideMaps() {
    isShowMaps.value = false;
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    name.value = prefs.getString('name') ?? "";
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }

  @override
  void onInit() {
    super.onInit();
    determinePosition();
  }

  @override
  void onReady() {
    super.onReady();
    getDetailIzin();
    loadUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToAddPages() {
    Get.toNamed(Routes.ADD_STORE);
  }

  void attendanceSheetBar(String type) {
    imageFileList.clear();
    final sw = SizeConfig().screenWidth;
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
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
                          child: CommonWidget.minHeadText(
                              text: 'Unggah Foto Anda'),
                        ),
                      ),
                      CommonWidget.rowHeight(),
                      Obx(() => Container(
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            height: sw * .4,
                            width: sw * .4,
                            child: imageFileList.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        20), // Image border
                                    child: Image.file(
                                        File(imageFileList.first.path)),
                                  )
                                : Center(
                                    child: CommonWidget.bodyText(
                                        text: "Anda belum memilih foto",
                                        color: Colors.grey),
                                  ),
                          )),
                      CommonWidget.rowHeight(),
                      InkWell(
                        onTap: () {
                          onImageButtonPressed(ImageSource.camera,
                              context: Get.context);
                        },
                        child: DottedBorder(
                          radius: Radius.circular(100.0),
                          color: Colors.grey,
                          dashPattern: [8, 4],
                          strokeWidth: 1,
                          child: Container(
                            height: 50,
                            width: sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                SizedBox(width: 10.0),
                                CommonWidget.bodyText(
                                    text: "Ambil Photo", color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      ),
                      CommonWidget.rowHeight(),
                      CustomButton(
                        buttonColor: ColorConstants.mainColor,
                        buttonText: 'SIMPAN',
                        width: sw,
                        onPressed: () {
                          type == 'Clock In' ? submitIn() : submitOut();
                          // submitPhoto();
                          // controller.approval(action: 'approve');
                        },
                      ),
                    ],
                  )),
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
    // });
  }

  Widget previewImages() {
    if (imageFileList.isNotEmpty) {
      return Semantics(
        label: 'image_picker_example_picked_image',
        child: kIsWeb
            ? Image.network(imageFileList.first.path)
            : Image.file(File(imageFileList.first.path)),
      );
    } else if (pickImageError != null) {
      return CommonWidget.bodyText(text: "Loading", color: Colors.grey);
    } else {
      return CommonWidget.bodyText(
          text: "Anda belum memilih foto", color: Colors.grey);
    }
  }

  void submitIn() async {
    isAbsent.value = true;
    absentTime.value = dateNow.value;
    isShowMaps.value = false;
    Get.back();
    // final res = await apiRepository.submitAttendance(
    //   AttendanceSubmitRequest(
    //     latitude: myLocation.latitude.toString(),
    //     longitude: myLocation.longitude.toString(),
    //     idUser: userId.value,
    //     token: token.value,
    //     photo: MultipartFile(await imageFileList.first.readAsBytes(),
    //         filename: imageFileList.first.name),
    //   ),
    // );
    // if (res!.message == "berhasil absen masuk") {
    //   EasyLoading.showSuccess('Berhasil Clock In');
    //   var now = new DateTime.now();
    //   timeIn.value = DateFormat("HH:mm:ss").format(now);
    //   Get.back();
    // } else {
    //   EasyLoading.showError('Gagal Clock In');
    // }
  }

  void submitOut() async {
    isAbsentOut.value = true;
    absentTimeOut.value = dateNow.value;
    isShowMaps.value = false;
    Get.back();
    // attendanceSheetBar();
    // final res = await apiRepository.submitAttendanceOut(
    //   AttendanceSubmitRequest(
    //     latitude: myLocation.latitude.toString(),
    //     longitude: myLocation.longitude.toString(),
    //     idUser: userId.value,
    //     token: token.value,
    //     photo: MultipartFile(await imageFileList.first.readAsBytes(),
    //         filename: imageFileList.first.name),
    //   ),
    // );
    // print(res);
    // if (res!.message == "berhasil absen keluar") {
    //   EasyLoading.showSuccess('Berhasil Clock Out');
    //   var now = new DateTime.now();
    //   timeOut.value = DateFormat("HH:mm:ss").format(now);
    //   Get.back();
    // } else {
    //   EasyLoading.showError('Gagal Clock Out');
    // }
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

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    locationDetail.value =
        "${placemarks[2].street}, ${placemarks[2].subLocality}, ${placemarks[2].locality}, ${placemarks[2].administrativeArea}";
    // print(placemarks);
    // markers.add(Marker(
    //     markerId: MarkerId('SomeId'),
    //     position: LatLng(position.latitude, position.longitude),
    //     infoWindow: InfoWindow(title: 'The title of the marker')));

    final prefs = Get.find<SharedPreferences>();
    if (prefs.getString('token') != null) {
      prefs.setDouble(StorageConstants.initLatitude, position.latitude);
      prefs.setDouble(StorageConstants.initLongitude, position.longitude);
    }

    EasyLoading.dismiss();
  }

  Future<void> onRefresh() async {
    getDetailIzin();
    // getItemCnC();
    loadUsers();
  }

  void getDetailIzin() async {
    final res =
        await apiRepository.showIzin(ShowLeaveRequest(id: argm.toString()));
    print(res!.data!);
    detail.value = res.data!.first;
  }

  void approval({
    action = "reject",
  }) async {
    final res = await apiRepository.updateApprovalIzin(
        detail.value.id.toString(),
        UpdateApprovalIzinRequest(
          action: action,
          noteApproval: noteApprovalController.text,
        ));
    // if (res!.error == false) {
    //   EasyLoading.showSuccess('Berhasil disimpan');
    //   getDetailIzin();
    //   loadUsers();
    // } else {
    //   EasyLoading.showError('Gagal disimpan');
    // }
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    dateCnC.value = selectedDate.toString();
  }

  void dateSubmit() {
    dateCnC.value = dateCnCController.text;
  }

  void updateGoods({name}) {
    // goods.removeWhere((e) => e.id == id);
    // goods[goods.indexWhere((element) => element.name == name)] = singleGoods;
  }

  void deleteGoods({name}) {}
}
