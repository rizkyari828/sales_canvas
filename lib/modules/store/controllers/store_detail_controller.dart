import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/attendance/attendance_wrapper.dart';
import 'package:sales/models/request/attendance/submit_attendance.dart';
import 'package:sales/models/request/attendance/validate_attenance.dart';
import 'package:sales/models/response/izin/show_izin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/constants/storage.dart';
import 'package:sales/shared/services/face_recognition/face_recognition_controller.dart';
import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/utils/size_config.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';

class StoreDetailController extends FaceRecognitionController {
  StoreDetailController({required ApiRepository apiRepository})
      : super(apiRepository: apiRepository);

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
  RxString userId = "".obs;
  RxString token = "".obs;
  RxString storeName = "".obs;

  late LatLng myLocation = LatLng(0, 0);
  var markers = <Marker>[].obs;
  var circles = Set<Circle>().obs;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  RxString locationDetail = "".obs;
  RxString locationStore = "".obs;

  RxBool isAbsent = false.obs;
  RxBool isAbsentOut = false.obs;
  RxBool canAbsent = false.obs;
  RxString absentTime = '00:00'.obs;
  RxString absentTimeOut = '00:00'.obs;
  RxBool isShowMaps = true.obs;

  RxString? retrieveDataError;

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
    userId.value = prefs.getString('userId') ?? "";
    token.value = prefs.getString('token') ?? "";
  }

  @override
  void onInit() {
    super.onInit();
    determinePosition();
    validateAttandance();
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    storeName.value = argm['storeName'];
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {
    isAbsent.value = false;
    absentTime.value = '--:--';
    isShowMaps.value = true;
    isAbsentOut.value = false;
    absentTimeOut.value = '--:--';
    determinePosition();
    validateAttandance();
    loadUsers();
  }

  void validateAttandance() async {
    try {
      final res = await apiRepository.validateAttendance(
          AttendanceValidateRequest(
              idToko: argm['id'].toString(),
              latitude: myLocation.latitude.toString(),
              longitude: myLocation.longitude.toString(),
              id: userId.value.toString(),
              token: token.value.toString()));
      print(res);

      LatLng _myOffice = LatLng(
          res?.data?.first.latitude ?? 0.0, res?.data?.first.longitude ?? 0.0);

      circles.add(Circle(
        circleId: CircleId('A1'),
        center: _myOffice,
        radius: 150,
        fillColor: CommonWidget.setOpacity(Colors.blueAccent, 0.9),
        strokeWidth: 3,
        strokeColor: CommonWidget.setOpacity(Colors.blueAccent, 0.9),
      ));

      if (res?.data?.first.flag == "1") {
        canAbsent.value = true;
        if (res?.data?.first.absenIn != '') {
          absentTime.value = res?.data?.first.absenIn.toString() ?? '';
        }
        if (res?.data?.first.absenOut != '') {
          absentTimeOut.value = res?.data?.first.absenOut.toString() ?? '';
        }
      } else {
        canAbsent.value = false;
      }
      EasyLoading.dismiss();
    } catch (e) {
      canAbsent.value = false;
      EasyLoading.dismiss();
    }
  }

  void goToAddPages() {
    Get.toNamed(
      Routes.ADD_STORE,
      arguments: argm['id'].toString(),
    );
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
                          onImageButtonPressed(ImageSource.gallery,
                              context: Get.context);
                        },
                        child: DottedBorder(
                          options: RectDottedBorderOptions(
                            color: Colors.grey,
                            dashPattern: [8, 4],
                            strokeWidth: 1,
                          ),
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
                          // type == 'Clock In' ? submitIn() : submitOut();
                          submit(type);
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

  void submitOld(String type) async {
    final file = faceCameraCapture?.value;
    if (file == null || !(await file.exists())) {
      EasyLoading.showError('Foto belum tersedia');
      return;
    }

    final base64Image = base64Encode(await file.readAsBytes());
    final filename = file.path.split('/').last;

    final wrapper = AttendanceSubmitRequestWrapper(
      idToko: argm['id'].toString(),
      latitude: myLocation.latitude.toString(),
      longitude: myLocation.longitude.toString(),
      idUser: userId.value,
      token: token.value,
      photoBase64: base64Image,
      filename: filename,
    );

    if (isConnectedToInternet.value) {
      final storage = GetStorage();
      await storage.write('pendingAttendance', wrapper.toJson());
      EasyLoading.showInfo('Tidak ada internet. Data disimpan sementara.');
      return;
    }

    final response = await _submitAttendance(wrapper);

    if (response) {
      if (type == 'Clock In') {
        EasyLoading.showSuccess('Berhasil Clock In');
      } else {
        EasyLoading.showSuccess('Berhasil Clock Out');
      }

      isAbsent.value = true;
      absentTime.value = dateNow.value;
      isShowMaps.value = false;
      faceCameraCapture?.value = File('');
      Get.back();

      await _submitPendingAttendance();
    } else {
      if (type == 'Clock In') {
        EasyLoading.showError('Gagal Clock In');
      } else {
        EasyLoading.showError('Gagal Clock Out');
      }

      faceCameraCapture?.value = File('');
    }
  }

  void submit(String type) async {
    final file = faceCameraCapture?.value;
    if (file == null || !file.existsSync()) {
      EasyLoading.showError('Foto belum tersedia');
      return;
    }

    final photoBytes = await file.readAsBytes();
    final photoBase64 = base64Encode(photoBytes);

    final wrapper = AttendanceSubmitRequestWrapper(
      idToko: argm['id'].toString(),
      latitude: myLocation.latitude.toString(),
      longitude: myLocation.longitude.toString(),
      idUser: userId.value,
      token: token.value,
      photoBase64: photoBase64,
      filename: file.path.split('/').last,
    );

    if (isConnectedToInternetWidget.value == false) {
      final success = await _submitAttendance(wrapper);
      if (success) {
        if (type == 'Clock In') {
          EasyLoading.showSuccess('Berhasil Clock In');
        } else {
          EasyLoading.showSuccess('Berhasil Clock Out');
        }
        isAbsent.value = true;
        absentTime.value = dateNow.value;
        isShowMaps.value = false;
        faceCameraCapture?.value = File('');
        Get.back();
      } else {
        if (type == 'Clock In') {
          EasyLoading.showError('Gagal Clock In');
        } else {
          EasyLoading.showError('Gagal Clock Out');
        }
        faceCameraCapture?.value = File('');
      }
    } else {
      _savePendingAttendance(wrapper);
      EasyLoading.showInfo('Tidak ada koneksi. Data disimpan sementara.');
      faceCameraCapture?.value = File('');
    }
  }

  void _savePendingAttendance(AttendanceSubmitRequestWrapper wrapper) {
    final storage = GetStorage();

    final existingData = storage.read<List<dynamic>>('pendingAttendances');
    final List<Map<String, dynamic>> updatedList = existingData != null
        ? List<Map<String, dynamic>>.from(existingData)
        : [];

    updatedList.add(wrapper.toJson());
    storage.write('pendingAttendances', updatedList);
  }

  // Future<void> saveAttendanceToLocal(
  //     AttendanceSubmitRequestWrapper data) async {
  //   final storage = GetStorage();
  //   final existingData = storage.read<List>('pendingAttendance') ?? [];

  //   final updatedList = List<Map<String, dynamic>>.from(existingData)
  //     ..add(data.toJson());

  //   await storage.write('pendingAttendance', updatedList);
  // }

  Future<bool> _submitAttendance(AttendanceSubmitRequestWrapper wrapper) async {
    try {
      final request = AttendanceSubmitRequest(
        idToko: wrapper.idToko,
        latitude: wrapper.latitude,
        longitude: wrapper.longitude,
        idUser: wrapper.idUser,
        token: wrapper.token,
        photo: MultipartFile(
          base64Decode(wrapper.photoBase64),
          filename: wrapper.filename,
        ),
      );

      final res = await apiRepository.submitAttendanceStore(request);
      return res?.message == "sukses";
    } catch (e) {
      print("Error saat submit: $e");
      return false;
    }
  }

  Future<void> _submitPendingAttendance() async {
    final storage = GetStorage();
    final data = storage.read('pendingAttendance');

    if (data != null) {
      final wrapper = AttendanceSubmitRequestWrapper.fromJson(data);
      final success = await _submitAttendance(wrapper);

      if (success) {
        await storage.remove('pendingAttendance');
        EasyLoading.showSuccess("Data tertunda berhasil dikirim");
      } else {
        EasyLoading.showInfo("Data tertunda belum berhasil dikirim");
      }
    }
  }

  // void submitIn() async {
  //   final file = faceCameraCapture?.value;
  //   if (file != null) {
  //     final res = await apiRepository.submitAttendanceStore(
  //       AttendanceSubmitRequest(
  //         idToko: argm['id'].toString(),
  //         latitude: myLocation.latitude.toString(),
  //         longitude: myLocation.longitude.toString(),
  //         idUser: userId.value,
  //         token: token.value,
  //         // photo: MultipartFile(await imageFileList.first.readAsBytes(),
  //         //     filename: imageFileList.first.name),
  //         photo: MultipartFile(
  //           await file.readAsBytes(),
  //           filename: file.path.split('/').last,
  //         ),
  //       ),
  //     );
  //     if (res!.message == "sukses") {
  //       EasyLoading.showSuccess('Berhasil Clock In');
  //       isAbsent.value = true;
  //       absentTime.value = dateNow.value;
  //       isShowMaps.value = false;
  //       faceCameraCapture?.value = File('');
  //       Get.back();
  //     } else {
  //       faceCameraCapture?.value = File('');
  //       EasyLoading.showError('Gagal Clock In');
  //     }
  //   } else {
  //     EasyLoading.showError('Foto belum tersedia');
  //   }
  // }

  // void submitOut() async {
  //   // attendanceSheetBar();
  //   final res = await apiRepository.submitAttendanceOutStore(
  //     AttendanceSubmitRequest(
  //       idToko: argm['id'].toString(),
  //       latitude: myLocation.latitude.toString(),
  //       longitude: myLocation.longitude.toString(),
  //       idUser: userId.value,
  //       token: token.value,
  //       photo: MultipartFile(
  //         await imageFileList.first.readAsBytes(),
  //         filename: imageFileList.first.name,
  //       ),
  //     ),
  //   );
  //   print(res);
  //   if (res!.message == "sukses") {
  //     EasyLoading.showSuccess('Berhasil Clock Out');
  //     isAbsentOut.value = true;
  //     absentTimeOut.value = dateNow.value;
  //     isShowMaps.value = false;
  //     faceCameraCapture?.value = File('');
  //     Get.back();
  //   } else {
  //     faceCameraCapture?.value = File('');
  //     EasyLoading.showError('Gagal Clock Out');
  //   }
  // }

  Future<void> onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    // imageFileList.clear();
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

    final prefs = Get.find<SharedPreferences>();
    if (prefs.getString('token') != null) {
      prefs.setDouble(StorageConstants.initLatitude, position.latitude);
      prefs.setDouble(StorageConstants.initLongitude, position.longitude);
    }

    EasyLoading.dismiss();
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
}
