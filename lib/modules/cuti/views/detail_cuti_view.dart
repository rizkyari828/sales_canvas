import 'package:sales/modules/cuti/controllers/cuti_detail_controller.dart';
import 'package:sales/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/shared/widgets/approval.dart';

class CutiDetailView extends GetView<CutiDetailController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(title: 'Detail Cuti'),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Obx(
            () => controller.detail.value.idLembur == null
                ? CircularProgressIndicator(
                    backgroundColor: ColorConstants.mainColor,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.labelExpanded(
                          label: 'Jam Mulai',
                          value: controller.detail.value.jamIn.toString()),
                      SizedBox(height: 10.0),
                      CommonWidget.labelExpanded(
                          label: 'Jam Selesai',
                          value: controller.detail.value.jamOut.toString()),
                      SizedBox(height: 20.0),
                      CommonWidget.bodyText(text: "Keterangan"),
                      SizedBox(height: 10.0),
                      // CommonWidget.bodyText(
                      //     text: controller.detail.value.keterangan ?? ''),
                      // SizedBox(height: 20.0),
                      SizedBox(height: 50.0),
                      Obx(() =>
                          ApprovalFlow.buttonApproval(controller, "1", "1")),
                    ],
                  ),
          ),
        )));
  }
}
