import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sales/api/api_repository.dart';
import 'package:sales/models/request/id_request.dart';
import 'package:sales/models/request/izin/submit_izin_request.dart';
import 'package:sales/models/response/izin/list_izin.dart';
import 'package:sales/models/response/izin/type_izin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sales/models/response/store/list_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreController extends GetxController {
  final ApiRepository apiRepository;
  StoreController({required this.apiRepository});
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
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final noteController = TextEditingController();

  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString placement = "".obs;
  RxString nameItem = "".obs;
  RxString idType = "".obs;
  RxString idUser = "".obs;
  RxString token = "".obs;

  String date = "";
  DateTime selectedDate = DateTime.now();
  RxString dateCnC = "".obs;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  RxString userId = "".obs;

  RxString validationDate = "".obs;
  var listType = <DataTypeIzin>[].obs;

  var listProduct = <DataProduct>[].obs;
  RxInt page = 1.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void getIzin(page) async {
    // final res = await apiRepository.listProduct(
    //     page: page, data: IdRequest(id: userId.value, token: token.value));
    // listProduct.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listProduct.clear();
    page.value = 1;
    getIzin(page.value);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    page.value = page.value + 1;

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getIzin(page.value);
    refreshController.loadComplete();
  }

  // Fungsi untuk menambah stok
  void addStock(int index) {
    listProduct[index].stock.value++;
    // update();
  }

  // Fungsi untuk mengurangi stok
  void subtractStock(int index) {
    if (listProduct[index].stock.value > 0) {
      listProduct[index].stock.value--;
      // update();
    }
  }

  Future<void> onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
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

  void submit() {
    if (endDate.compareTo(startDate) >= 0) {
      submitData();
    } else {
      validationDate.value =
          'Tanggal selesai tidak bisa lebih besar dari tanggal mulai';
    }
  }

  void submitData() async {
    final res = await apiRepository.submitIzin(
      SubmitIzinRequest(
          idUser: idUser.value,
          dateStart: startDateController.text,
          dateEnd: endDateController.text,
          note: noteController.text,
          leaveTypeId: idType.value,
          token: token.value),
    );
    if (res!.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      EasyLoading.dismiss();
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
      EasyLoading.dismiss();
    }
  }

  Future<void> _displayPickImageDialog(BuildContext context, onPick) async {
    return onPick(200.0, 200.0, 50);
  }

  @override
  void onInit() {
    super.onInit();
    listProduct.add(DataProduct(
      id: 3,
      name: 'IPhone 15 Pro Max',
      stock: 50,
      price: 20000000,
      type: 'Smart Phone',
    ));
    listProduct.add(DataProduct(
        id: 3,
        name: 'Samsung S24',
        stock: 0,
        price: 21000000,
        type: 'Smart Phone',
        photo:
            'https://cdsassets.apple.com/live/7WUAS350/images/iphone/fall-2023-iphone-colors-iphone-15-pro-max.png'));
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    getType();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    placement.value = prefs.getString('placement') ?? "";
    token.value = prefs.getString('token') ?? "";
    idUser.value = prefs.getString('userId') ?? "";
  }

  selectDateStart(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    startDate = selectedDate;
    startDateController.text =
        DateFormat("yyyy-MM-dd", "id_ID").format(selectedDate).toString();
  }

  selectDateEnd(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    endDate = selectedDate;
    endDateController.text =
        DateFormat("yyyy-MM-dd", "id_ID").format(selectedDate).toString();
  }

  void getType() async {
    final res = await apiRepository.typeIzin();
    listType.addAll(res?.data ?? []);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
