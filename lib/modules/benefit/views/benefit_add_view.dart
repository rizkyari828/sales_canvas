import 'package:sales/modules/benefit/controllers/benefit_add_controller.dart';
import 'package:sales/shared/shared.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BenefitAddView extends GetView<BenefitAddController> {
  // final CnCController controller = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(title: 'Tambah Cuti'),
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
                    CommonWidget.labelExpanded(
                        label: 'ID Transaksi',
                        value: controller.placement.value),
                    SizedBox(height: 20.0),
                    CommonWidget.labelExpanded(
                        label: 'Client', value: controller.placement.value),
                    SizedBox(height: 20.0),
                    CommonWidget.labelExpanded(
                        label: 'Cabang Client',
                        value: controller.placement.value),
                    SizedBox(height: 20.0),
                    CommonWidget.labelExpanded(
                        label: 'Nama Pengaju',
                        value: controller.placement.value),
                    SizedBox(height: 20.0),
                    CommonWidget.labelExpanded(
                        label: 'Nominal', value: controller.placement.value),
                    SizedBox(height: 20.0),
                    CommonWidget.labelExpanded(
                        label: 'Insentif', value: controller.placement.value),
                    SizedBox(height: 20.0),
                    // CustomDropDownSearch(
                    //   listItem: controller.listType.map((item) {
                    //     return item.name;
                    //   }).toList(),
                    //   labelText: "Type Cuti",
                    //   onChanged: (value) async {
                    //     // controller.nameItem.value = value;
                    //     for (var f in controller.listType) {
                    //       if (f.name == value) {
                    //         controller.nameItem.value = f.id.toString();
                    //       }
                    //     }
                    //   },
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height / 11,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    //     child: DropdownSearch<dynamic>(
                    //       dropdownSearchDecoration: InputDecoration(
                    //         enabledBorder: UnderlineInputBorder(
                    //           borderSide:
                    //               BorderSide(color: ColorConstants.mainColor),
                    //         ),
                    //         labelText: "Type Cuti",
                    //       ),
                    //       items: controller.listType.map((item) {
                    //         return item.name;
                    //       }).toList(),
                    //       maxHeight: 300,
                    //       onChanged: (value) async {
                    //         // controller.nameItem.value = value;
                    //         for (var f in controller.listType) {
                    //           if (f.name == value) {
                    //             controller.nameItem.value = f.id.toString();
                    //           }
                    //         }
                    //       },
                    //       showSearchBox: true,
                    //     ),
                    //   ),
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: InputInputField(
                    //         isSuffixIcon: true,
                    //         suffixIcon: Icon(Icons.calendar_today_rounded),
                    //         controller: controller.startDateController,
                    //         labelText: "Tanggal Mulai",
                    //         onSuffixPressed: () {
                    //           controller.selectDateStart(context);
                    //         },
                    //       ),
                    //     ),
                    //     SizedBox(width: 20.0),
                    //     Expanded(
                    //       child: InputInputField(
                    //         isSuffixIcon: true,
                    //         suffixIcon: Icon(Icons.calendar_today_rounded),
                    //         controller: controller.endDateController,
                    //         labelText: "Tanggal Selesai",
                    //         onSuffixPressed: () {
                    //           controller.selectDateEnd(context);
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // MaterialButton(
                    //   onPressed: () => controller.selectDate(context),
                    //   child: Text('Select date'),
                    // ),
                    // SizedBox(height: 20.0),
                    // CommonWidget.bodyText(text: "Keterangan"),
                    // SizedBox(height: 10.0),
                    // TextAreaField(
                    //   controller: controller.noteController,
                    // ),
                    SizedBox(height: 30.0),
                    CustomButton(
                      buttonText: 'SIMPAN',
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        controller.submit();
                      },
                    ),
                  ],
                ),
              )),
        ));
  }
}
