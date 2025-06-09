import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales/modules/store/controllers/store_detail_controller.dart';
import 'package:sales/shared/services/face_recognition/face_recognition_wiget.dart';
import 'package:sales/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:sales/shared/widgets/custom_appbar.dart';
import 'package:sales/shared/widgets/image_picker.dart';

class StoreDetailView extends GetView<StoreDetailController> {
  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    double scaleWidth = MediaQuery.of(context).size.width / 360;
    return Obx(() => Scaffold(
        appBar: CustomAppBarWithNetwork(
          title: 'Detail Kunjungan',
          networkStatus: controller.qualityNetwork,
        ),
        floatingActionButton: controller.isConnectedToInternetWidget.value
            ? Padding(
                padding: EdgeInsets.only(left: scaleWidth * 30),
                child: controller.internetConnection(),
              )
            : SizedBox(),
        backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
        body: _buildView(context)));
  }

  Widget _buildView(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 10.0),
            !controller.isShowMaps.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () => controller.showMaps(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: sw * .12,
                            width: sw * .5,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 40,
                                        height: 40,
                                        color: Colors.transparent,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/icons/gm.png'))),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonWidget.subtitleText(
                                            text: 'Klik',
                                            color: ColorConstants.white,
                                            fontWeight: FontWeight.w500),
                                        CommonWidget.captionText(
                                            text: 'Untuk membuka Maps',
                                            color: Colors.white70),
                                      ],
                                    ),
                                  ]),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          CommonWidget.subtitleText(text: 'Hai, '),
                          CommonWidget.minHeadText(
                              text: controller.name.value,
                              color: ColorConstants.mainColor,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      textIcon(
                          Icon(Icons.login_rounded,
                              color: ColorConstants.mainColor),
                          'Anda sudah absen masuk di jam ',
                          controller.absentTime.value),
                      controller.isAbsentOut.value
                          ? textIcon(
                              Icon(Icons.logout_rounded,
                                  color: ColorConstants.mainColor),
                              'Anda sudah absen keluar di jam ',
                              controller.absentTimeOut.value)
                          : SizedBox(
                              height: 0,
                            ),
                      SizedBox(height: 20.0),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                          width: sw,
                          height: sw * .8,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target: controller.myLocation,
                                      zoom: 18.0),
                                  mapType: MapType.terrain,
                                  myLocationEnabled: true,
                                  myLocationButtonEnabled: true,
                                  markers: Set<Marker>.of(controller.markers),
                                  circles: controller.circles,
                                ),
                              ),
                              Positioned(
                                top: sw * .02,
                                left: sw * .02,
                                child: InkWell(
                                  onTap: () => controller.hideMaps(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                          width: 2.0,
                                          color: ColorConstants.borderColor),
                                    ),
                                    height: sw * .1,
                                    width: sw * .1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.close,
                                            color: Colors.redAccent, size: 30),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 30.0),
                    ],
                  ),
            CommonWidget.labelIconExpanded(
                color: Colors.green,
                text: controller.storeName.value,
                fontWeight2: FontWeight.w500,
                icon: Icon(
                  Icons.store,
                  size: 30,
                  color: Colors.green,
                )),
            CommonWidget.labelIconExpanded(
                text: controller.locationDetail.value,
                icon: Icon(
                  Icons.location_pin,
                  size: 30,
                  color: Colors.orangeAccent,
                ),
                isSubtitle: false),
            SizedBox(height: 20.0),
            CommonWidget.minSubtitleText(
                text: "Silahkan upload bukti Foto kunjungan anda"),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Obx(() => CustomImagePicker.previewGridImages(controller)),
            ),
            controller.imageFileList.length < 3
                ? InkWell(
                    onTap: () {
                      controller.onImageButtonPressed(ImageSource.camera,
                          context: context);
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
                                text: "Ambil Photos", color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),

            SizedBox(height: 10.0),
            CommonWidget.captionText(
                text: "Maksimal melampirkan 3 Foto", color: Colors.red),
            SizedBox(height: 20.0),
            CustomButton(
              buttonColor: Colors.white,
              borderColor: controller.isConnectedToInternetWidget.value
                  ? ColorConstants.backgroundTextField
                  : ColorConstants.mainColor,
              buttonTextColor: controller.isConnectedToInternetWidget.value
                  ? ColorConstants.black
                  : ColorConstants.mainColor,
              isDisabled: controller.imageFileList.length < 1,
              buttonText: controller.isConnectedToInternetWidget.value
                  ? 'SIMPAN SEMENTARA'
                  : 'SIMPAN KUNJUNGAN',
              width: MediaQuery.of(context).size.width / 1.13,
              onPressed: () => controller.submit('Kunjungan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget textIcon(Icon icon, String text, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.captionText(text: text),
            CommonWidget.subtitleText(
                text: value,
                color: ColorConstants.mainColor,
                fontWeight: FontWeight.w500),
          ],
        ),
      ],
    );
  }
}
