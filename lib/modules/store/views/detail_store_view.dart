import 'package:sales/modules/store/controllers/store_detail_controller.dart';
import 'package:sales/shared/services/face_recognition/face_recognition_wiget.dart';
import 'package:sales/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sales/shared/widgets/button.dart';

class StoreDetailView extends GetView<StoreDetailController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return Obx(() => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Stack(
          children: [
            Container(
              width: sw,
              height: sw * 0.16,
              color: Colors.white,
            ),
            Positioned(
              left: sw * 0.06,
              top: sw * 0.02,
              child: CustomButton(
                  buttonColor: Colors.white,
                  borderColor: ColorConstants.mainColor,
                  buttonTextColor: ColorConstants.mainColor,
                  // isDisabled: !controller.canAbsent.value ||
                  //         controller.isAbsentOut.value
                  isDisabled: controller.isAbsentOut.value ? true : false,
                  buttonText: controller.isAbsent.value
                      ? 'ABSEN KELUAR'
                      : 'ABSEN MASUK',
                  width: MediaQuery.of(context).size.width / 1.13,
                  onPressed: () => !controller.isAbsent.value
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FaceRecognitionWiget.faceCameraRecognizer(
                                      controller, 'Clock In')))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FaceRecognitionWiget.faceCameraRecognizer(
                                      controller, 'Clock Out')))),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(title: 'Detail Kunjungan'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 10.0),
                !controller.isShowMaps.value && controller.isAbsent.value
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
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: CommonWidget.setOpacity(
                                  //         Colors.black, 0.3),
                                  //     blurRadius: 20.0,
                                  //     spreadRadius: 4.0,
                                  //     offset: Offset(
                                  //       -10.0,
                                  //       10.0,
                                  //     ),
                                  //   ),
                                  // ],
                                ),
                                height: sw * .12,
                                width: sw * .5,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      markers:
                                          Set<Marker>.of(controller.markers),
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
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          border: Border.all(
                                              width: 2.0,
                                              color:
                                                  ColorConstants.borderColor),
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
                                                color: Colors.redAccent,
                                                size: 30),
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
                // SizedBox(height: 30.0),
                // _cardMenu(Icons.production_quantity_limits, "Product",
                //     controller.goToAddPages, Colors.white, Colors.teal),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        )));
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

  Widget _cardMenu(icon, title, onPressed, colorCircle, colorBackground) {
    return Container(
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(10.0),
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
      width: SizeConfig().screenWidth,
      height: SizeConfig().screenHeight * .10,
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: new BoxDecoration(
                    color: colorCircle,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: colorBackground,
                      size: SizeConfig().screenWidth * .06,
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig().screenHeight * .01),
                CommonWidget.minHeadText(
                    text: title,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
