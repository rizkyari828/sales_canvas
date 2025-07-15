import 'package:sales/modules/prospek_v2/controllers/prospek_add_controller.dart';
import 'package:sales/shared/shared.dart';
import 'package:sales/shared/widgets/approval.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProspekV2AddView extends GetView<ProspekV2AddController> {
  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(
            title: controller.isEdit.value ? 'Edit Propek' : 'Tambah Prospek'),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              stepsIcon(controller.detail.value.statusProspectValue),
              SizedBox(height: 20.0),
              if (controller.isEdit.value) ...[
                ApprovalFlow.statusApprovalProspect(controller.status),
                SizedBox(height: 20.0),
                CommonWidget.labelExpanded(label: 'ID Leads', value: ''),
                SizedBox(height: 10.0),
                CommonWidget.labelExpanded(
                    label: 'Nama Prospek',
                    value: controller.prospectNameController.text),
                SizedBox(height: 10.0),
                CommonWidget.labelExpanded(
                    label: 'Produk yang Diminati',
                    value: controller.productNameController.text),
                SizedBox(height: 10.0),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!controller.isEdit.value) ...[
                    SizedBox(height: 10.0),
                    InputInputField(
                      keyboardType: TextInputType.text,
                      controller: controller.prospectNameController,
                      labelText: "Nama Prospek",
                    ),
                    SizedBox(height: 10.0),
                    InputInputField(
                      keyboardType: TextInputType.text,
                      controller: controller.productNameController,
                      labelText: "Produk yang Diminati",
                    ),
                    SizedBox(height: 10.0),
                  ],
                  InputInputField(
                    keyboardType: TextInputType.text,
                    controller: controller.totalTransaction,
                    labelText: "Estimasi Nilai Transaksi",
                  ),
                  SizedBox(height: 20.0),
                  CustomDropDownSearch(
                    listItem: controller.listStatusProspect.map((item) {
                      return item.nama;
                    }).toList(),
                    labelText: "Status Prospek",
                    selectedItem: controller.statusProspectValue.value,
                    onChanged: (value) async {
                      controller.statusProspectValue.value = value;
                      for (var f in controller.listStatusProspect) {
                        if (f.nama == value) {
                          controller.idStatusProspect.value = f.id ?? 0;
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  InputInputField(
                    isSuffixIcon: true,
                    suffixIcon: Icon(Icons.calendar_today_rounded),
                    controller: controller.dateCalled,
                    labelText: "Tanggal Dihubungi",
                    isRequired: true,
                    showError: controller.showInputError.value,
                    onSuffixPressed: () {
                      controller.selectDate(context, controller.dateCalled);
                    },
                  ),
                  SizedBox(height: 20.0),
                  CustomDropDownSearch(
                    listItem: controller.listMediaCommuncation.map((item) {
                      return item.nama;
                    }).toList(),
                    labelText: "Media Komunikasi",
                    selectedItem: controller.mediaCommunicationValue.value,
                    onChanged: (value) async {
                      controller.mediaCommunicationValue.value = value;
                      for (var f in controller.listMediaCommuncation) {
                        if (f.nama == value) {
                          controller.idMediaCommunication.value = f.id ?? 0;
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  InputInputField(
                    isSuffixIcon: true,
                    suffixIcon: Icon(Icons.calendar_today_rounded),
                    controller: controller.dateFu,
                    labelText: "Tanggal Follow Up",
                    isRequired: true,
                    showError: controller.showInputError.value,
                    onSuffixPressed: () {
                      controller.selectDate(context, controller.dateFu);
                    },
                  ),
                  SizedBox(height: 10.0),
                  CommonWidget.bodyText(text: "Catatan Komunikasi"),
                  SizedBox(height: 10.0),
                  TextAreaField(
                    controller: controller.noteCommunication,
                  ),
                  SizedBox(height: 20.0),
                  CustomDropDownSearch(
                    listItem: controller.listSourceOfOrder.map((item) {
                      return item.nama;
                    }).toList(),
                    selectedItem: controller.sourceOrderValue.value,
                    labelText: "Status Order",
                    onChanged: (value) async {
                      controller.sourceOrderValue.value = value;
                      for (var f in controller.listSourceOfOrder) {
                        if (f.nama == value) {
                          controller.idSource.value = f.id ?? 0;
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  CommonWidget.bodyText(text: "Alasan Tidak Order"),
                  SizedBox(height: 10.0),
                  TextAreaField(
                    controller: controller.reasonNotOrder,
                  ),
                  SizedBox(height: 10.0),
                  InputInputField(
                    isSuffixIcon: true,
                    suffixIcon: Icon(Icons.calendar_today_rounded),
                    controller: controller.dateLastUpdate,
                    labelText: "Tanggal Update Terakhir",
                    isRequired: true,
                    showError: controller.showInputError.value,
                    onSuffixPressed: () {
                      controller.selectDate(context, controller.dateLastUpdate);
                    },
                  ),
                  SizedBox(height: 100.0),
                ],
              ),
            ],
          ),
        )),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: sw * .08),
          child: CustomButton(
            buttonText: 'SIMPAN',
            width: MediaQuery.of(context).size.width,
            onPressed: () {
              controller.submitProspek();
            },
          ),
        ),
      ),
    );
  }

  Widget divLine() {
    final sw = SizeConfig().screenWidth;
    return Padding(
        padding: EdgeInsets.only(left: sw * .01, right: sw * .01),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
              color: Colors.grey),
          width: sw * .09,
          height: sw * .02,
        ));
  }

  Widget stepsIcon(status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        step(
          status == '1' ? true : false,
          'Prospek',
          Icons.handshake_rounded,
        ),
        divLine(),
        step(
          status == '2' ? true : false,
          'Order',
          Icons.playlist_add_circle,
        ),
        divLine(),
        Divider(color: Colors.black),
        step(status == '3' ? true : false, 'Booking',
            Icons.playlist_add_check_circle)
      ],
    );
  }

  Widget step(bool active, String status, IconData icon) {
    final sw = SizeConfig().screenWidth;
    return Container(
      height: active ? sw * .23 : sw * .21,
      width: active ? sw * .23 : sw * .21,
      decoration: BoxDecoration(
        color: active ? ColorConstants.mainColor : Colors.grey,
        shape: BoxShape.circle,
        border: Border.all(width: 2.0, color: ColorConstants.borderColor),
        // boxShadow: [
        //   active
        //       ? BoxShadow(
        //           color: CommonWidget.setOpacity(Colors.black, 0.3),
        //           blurRadius: 20.0,
        //           spreadRadius: 4.0,
        //           offset: Offset(
        //             -10.0,
        //             10.0,
        //           ),
        //         )
        //       : BoxShadow(
        //           color: CommonWidget.setOpacity(Colors.grey, 0.0),
        //         ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: ColorConstants.white,
              size: active ? 35 : 33,
            ),
            CommonWidget.captionText(
              text: status,
              color: ColorConstants.white,
            ),
          ],
        ),
      ),
    );
  }
}
