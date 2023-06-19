import 'package:sales/modules/benefit/controllers/benefit_detail_controller.dart';
import 'package:sales/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BenefitDetailView extends GetView<BenefitDetailController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonWidget.appBar(title: 'Detail Benefit'),
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.labelExpanded(
                    label: 'Tanggal Transaksi',
                    value: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                        .format(controller.detail.value.dateRequest ??
                            DateTime.now())
                        .toString()),
                SizedBox(height: 10.0),
                CommonWidget.labelExpanded(
                    label: 'ID Transaksi', value: "10/110/1101/2020"),
                SizedBox(height: 10.0),
                CommonWidget.labelExpanded(label: 'Client', value: "Adira"),
                SizedBox(height: 10.0),
                CommonWidget.labelExpanded(
                    label: 'Cabang Client', value: 'Bogor'),
                SizedBox(height: 10.0),
                CommonWidget.labelExpanded(
                    label: 'Nama Pengaju', value: 'Bambang'),
                SizedBox(height: 10.0),
                CommonWidget.labelExpanded(
                    label: 'Nominal', value: 'Rp. 5.000.000'),
                SizedBox(height: 10.0),
                CommonWidget.labelExpanded(
                    label: 'Insentif', value: 'Rp. 750.000'),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
