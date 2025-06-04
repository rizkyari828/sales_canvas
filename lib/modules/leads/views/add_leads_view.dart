import 'package:intl/intl.dart';
import 'package:sales/modules/leads/controllers/leads_controller.dart';
import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/utils/utils.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:sales/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLeadsView extends GetView<LeadsController> {
  const AddLeadsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(title: 'Tambah Leads'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.labelExpanded(
                        label: 'Tanggal Pengajuan',
                        value: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                            .format(DateTime.now())
                            .toString()),
                    SizedBox(height: 10.0),
                    CommonWidget.labelExpanded(
                        label: 'Lokasi',
                        value: controller.locationDetail.value),
                    SizedBox(height: 10.0),
                    InputInputField(
                      keyboardType: TextInputType.text,
                      controller: TextEditingController(),
                      labelText: "Nama Toko",
                    ),
                    CommonWidget.bodyText(text: "Alamat"),
                    SizedBox(height: 10.0),
                    Card(
                        elevation: 0.1,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                                color: ColorConstants.mainColor, width: 1)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller.noteController,
                            maxLines: 8,
                            decoration: InputDecoration.collapsed(
                                hintText: "Enter your text here"),
                          ),
                        )),
                    SizedBox(height: 10.0),
                    CommonWidget.bodyText(text: "Deskipsi"),
                    SizedBox(height: 10.0),
                    Card(
                        elevation: 0.1,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                                color: ColorConstants.mainColor, width: 1)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller.noteController,
                            maxLines: 8,
                            decoration: InputDecoration.collapsed(
                                hintText: "Enter your text here"),
                          ),
                        )),
                    SizedBox(height: 30.0),
                    CustomButton(
                      buttonText: 'SIMPAN',
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        controller.submit();
                      },
                    ),
                  ],
                )),
          ),
        ));
  }
}
