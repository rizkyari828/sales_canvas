import 'package:sales/modules/leads/controllers/leads_detail_controller.dart';
import 'package:sales/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/shared/widgets/image_picker.dart';

class LeadsDetailView extends GetView<LeadsDetailController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(title: 'Detail Leads'),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Obx(
            () => controller.detail.value.nama == null
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: ColorConstants.mainColor,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.labelExpanded(
                          label: 'Sumber Leads',
                          value: controller.detail.value.sumberLeadsId
                                      .toString() !=
                                  ''
                              ? controller.detail.value.sumberLeadsValue
                                  .toString()
                              : controller.detail.value.sumberLeads2
                                  .toString()),
                      SizedBox(height: 10.0),
                      CommonWidget.labelExpanded(
                          label: 'Nama',
                          value: controller.detail.value.email.toString()),
                      SizedBox(height: 10.0),
                      CommonWidget.labelExpanded(
                          label: 'Email',
                          value: controller.detail.value.email.toString()),
                      SizedBox(height: 10.0),
                      CommonWidget.labelExpanded(
                          label: 'Telephone',
                          value: controller.detail.value.telphone.toString()),
                      // SizedBox(height: 10.0),
                      // CommonWidget.labelExpanded(
                      //     label: 'Alamat',
                      //     value: controller.detail.value.alamat.toString()),
                      SizedBox(height: 10.0),
                      // CommonWidget.labelExpanded(
                      //     label: 'Titik Kordinat',
                      //     value: controller.detail.value.nama),
                      //      SizedBox(height: 10.0),
                      // CommonWidget.labelExpanded(
                      //     label: 'Kategori Lead',
                      //     value: controller.detail.value.),
                      //      SizedBox(height: 10.0),
                      CommonWidget.labelExpanded(
                          label: 'Product Minat',
                          value:
                              controller.detail.value.productMinat.toString()),
                      SizedBox(height: 10.0),
                      // CommonWidget.labelExpanded(
                      //     label: 'Status Lead',
                      //     value: controller.detail.value.nama),
                      // SizedBox(height: 10.0),
                      // CommonWidget.labelExpanded(
                      //     label: 'Catatan',
                      //     value: controller.detail.value.catatan.toString()),
                      // SizedBox(height: 20.0),
                      CommonWidget.bodyText(text: "Alamat"),
                      SizedBox(height: 10.0),
                      CommonWidget.bodyText(
                          text: controller.detail.value.alamat ?? ''),
                      SizedBox(height: 10.0),
                      CommonWidget.bodyText(text: "Catatan"),
                      SizedBox(height: 10.0),
                      CommonWidget.bodyText(
                          text: controller.detail.value.catatan ?? ''),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Obx(() =>
                            CustomImagePicker.previewGridImages(controller)),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
          ),
        )));
  }
}
