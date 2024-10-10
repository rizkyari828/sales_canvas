import 'package:sales/modules/home/attendance/attendance_controller.dart';
import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/utils/size_config.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class DiscoverTab extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return new Scaffold(
        body: Obx(() => GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: controller.myLocation, zoom: 18.0),
              mapType: MapType.terrain,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: Set<Marker>.of(controller.markers),
              circles: controller.circles,
            )),
        floatingActionButton: Container(
            margin: EdgeInsets.only(left: sw * .08),
            height: sh * .25,
            width: sw,
            // color: Colors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Card(
              elevation: 0.1,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side:
                      BorderSide(color: ColorConstants.borderColor, width: 1)),
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Obx(
                  () => SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 25),
                            CommonWidget.bodyText(
                              text: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                  .format(DateTime.now()),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.refresh_rounded),
                                    iconSize: 25,
                                    color: Colors.grey,
                                    onPressed: () {
                                      controller.onRefresh();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     SizedBox(width: 25),
                        //     Icon(Icons.alarm_rounded,
                        //         size: 20, color: ColorConstants.mainColor),
                        //     SizedBox(width: 5),
                        //     CommonWidget.captionText(
                        //       text:
                        //           "Durasi Bekerja, " + controller.duration.value,
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.only(
                              top: sw * .01, right: sw * .06, left: sw * .06),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  CommonWidget.subtitleText(
                                    text: "Datang",
                                  ),
                                  SizedBox(height: 8),
                                  controller.timeIn.value == "--:--"
                                      ? TimerBuilder.periodic(
                                          Duration(seconds: 1),
                                          builder: (context) {
                                          return CustomButton(
                                              isDisabled:
                                                  controller.isClockIn.value ==
                                                          true
                                                      ? false
                                                      : true,
                                              borderColor:
                                                  ColorConstants.mainColor,
                                              buttonColor: Colors.white,
                                              buttonTextColor:
                                                  ColorConstants.mainColor,
                                              // height: sh * .04,
                                              buttonText: DateFormat(
                                                      "HH:mm:ss", "id_ID")
                                                  .format(DateTime.now()),
                                              width: sw * .3,
                                              onPressed: () =>
                                                  controller.attendanceSheetBar(
                                                      'Clock In'));
                                        })
                                      : CommonWidget.bodyText(
                                          text: controller.timeIn.value,
                                          color: ColorConstants.mainColor,
                                        ),
                                ],
                              ),
                              SizedBox(width: sw * .04),
                              Column(
                                children: [
                                  CommonWidget.subtitleText(
                                    text: "Pulang",
                                  ),
                                  SizedBox(height: 8),
                                  controller.timeOut.value == "--:--"
                                      ? TimerBuilder.periodic(
                                          Duration(seconds: 1),
                                          builder: (context) {
                                          return CustomButton(
                                              isDisabled:
                                                  controller.isClockIn.value ==
                                                          true
                                                      ? false
                                                      : true,
                                              borderColor:
                                                  ColorConstants.mainColor,
                                              buttonColor: Colors.white,
                                              buttonTextColor:
                                                  ColorConstants.mainColor,
                                              // height: sh * .04,
                                              buttonText: DateFormat(
                                                      "HH:mm:ss", "id_ID")
                                                  .format(DateTime.now()),
                                              width: sw * .3,
                                              onPressed: () =>
                                                  controller.attendanceSheetBar(
                                                      'Clock Out'));
                                        })
                                      : CommonWidget.bodyText(
                                          text: controller.timeOut.value,
                                          color: ColorConstants.mainColor,
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Obx(() => Padding(
                        //       padding: const EdgeInsets.only(
                        //           top: 15.0, left: 25.0, bottom: 10.0, right: 25),
                        //       child: GestureDetector(
                        //           onHorizontalDragUpdate: (event) async {
                        //             if (event.primaryDelta! > 10) {
                        //               controller.incTansXVal();
                        //             }
                        //           },
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               _slider(),
                        //               controller.myWidth.value == 0.0
                        //                   ? Expanded(
                        //                       child: Center(
                        //                         child: CommonWidget.subtitleText(
                        //                           text: "Geser untuk absen masuk",
                        //                         ),
                        //                       ),
                        //                     )
                        //                   : SizedBox(),
                        //             ],
                        //           )),
                        //     )),
                        // SizedBox(height: sw * .1),
                        Padding(
                          padding: EdgeInsets.only(
                              top: sw * .04,
                              right: sw * .06,
                              left: sw * .06,
                              bottom: sw * .04),
                          child: CustomButton(
                              borderColor: ColorConstants.mainColor,
                              buttonColor: Colors.white,
                              buttonTextColor: ColorConstants.mainColor,
                              // height: sh * .06,
                              buttonText: 'RIWAYAT KEDATANGAN',
                              width: sw,
                              onPressed: controller.goToRecapPages),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
