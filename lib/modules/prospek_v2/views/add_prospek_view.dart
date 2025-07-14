import 'package:sales/modules/prospek_v2/controllers/prospek_add_controller.dart';
import 'package:sales/shared/shared.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProspekV2AddView extends GetView<ProspekV2AddController> {
  // final CnCController controller = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonWidget.appBar(title: 'Tambah Prospek'),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.labelExpanded(
                      label: 'Tanggal',
                      value: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                          .format(DateTime.now())
                          .toString()),
                  CommonWidget.labelExpanded(label: 'ID Leads', value: ''),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(label: 'Nama Prospek', value: ''),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Produk yang Diminati', value: ''),
                  SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      InputInputField(
                        keyboardType: TextInputType.text,
                        controller: controller.nickname,
                        labelText: "Nama Prospek",
                      ),
                      SizedBox(height: 10.0),
                      InputInputField(
                        keyboardType: TextInputType.text,
                        controller: controller.totalTransaction,
                        labelText: "Estimasi Nilai Transaksi",
                      ),
                      SizedBox(height: 10.0),
                      CustomDropDownSearch(
                        listItem: controller.listStatusProspect.map((item) {
                          return item.nama;
                        }).toList(),
                        labelText: "Status Prospek",
                        onChanged: (value) async {
                          // controller.nameItem.value = value;
                          for (var f in controller.listStatusProspect) {
                            if (f.nama == value) {
                              controller.idStatusProspect.value = f.id ?? 0;
                            }
                          }
                        },
                      ),
                      SizedBox(height: 10.0),
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
                      SizedBox(height: 10.0),
                      CustomDropDownSearch(
                        listItem: controller.listMediaCommuncation.map((item) {
                          return item.nama;
                        }).toList(),
                        labelText: "Media Komunikasi",
                        onChanged: (value) async {
                          // controller.nameItem.value = value;
                          for (var f in controller.listMediaCommuncation) {
                            if (f.nama == value) {
                              controller.idMediaCommunication.value = f.id ?? 0;
                            }
                          }
                        },
                      ),
                      SizedBox(height: 10.0),
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
                      SizedBox(height: 10.0),
                      CustomDropDownSearch(
                        listItem: controller.listSourceOfOrder.map((item) {
                          return item.nama;
                        }).toList(),
                        labelText: "Status Order",
                        onChanged: (value) async {
                          // controller.nameItem.value = value;
                          for (var f in controller.listSourceOfOrder) {
                            if (f.nama == value) {
                              controller.idSource.value = f.id ?? 0;
                            }
                          }
                        },
                      ),
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
                          controller.selectDate(
                              context, controller.dateLastUpdate);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            )),
      ),
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
    );
  }
}
