import 'package:sales/modules/kuisioner/controllers/kuisioner_controller.dart';
import 'package:sales/shared/utils/utils.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:sales/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddKuisionerView extends GetView<KusionerController> {
  const AddKuisionerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(title: 'Input Kuisioner'),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.labelExpanded(
                      label: 'Tanggal Kuisioner',
                      value: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                          .format(DateTime.now())
                          .toString()),
                  SizedBox(height: 10.0),
                  InputInputField(
                    keyboardType: TextInputType.text,
                    controller: controller.nipAdira,
                    labelText: "Nama",
                  ),
                  InputInputField(
                    keyboardType: TextInputType.text,
                    controller: controller.nipAdira,
                    labelText: "No Telepon",
                  ),
                  InputInputField(
                    keyboardType: TextInputType.text,
                    controller: controller.nipAdira,
                    labelText: "Alamat",
                  ),
                  InputInputField(
                    keyboardType: TextInputType.text,
                    controller: controller.nipAdira,
                    labelText: "Seberapa sering Anda menggunakan produk kami?",
                  ),
                  InputInputField(
                    keyboardType: TextInputType.text,
                    controller: controller.nipAdira,
                    labelText: "Seberapa mudah Anda menggunakan produk kami?",
                  ),
                  InputInputField(
                    keyboardType: TextInputType.text,
                    controller: controller.nipAdira,
                    labelText:
                        "Seberapa besar kemungkinan Anda merekomendasikan produk ini kepada orang lain?",
                  ),
                  CommonWidget.bodyText(text: "Keterangan"),
                  SizedBox(height: 10.0),
                  TextAreaField(
                    controller: controller.alasanEssay,
                  ),
                  Text(
                    'Apa alasan Anda menggunakan produk kami?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  MultipleChoice(
                    options: [
                      'Harga Terjangkau',
                      'Kualitas Produk',
                      'Rekomendasi Teman',
                      'Layanan Pelanggan',
                    ],
                  ),
                  SingleChoice(
                    question: 'Apa alasan utama Anda menggunakan produk kami?',
                    options: [
                      'Harga Terjangkau',
                      'Kualitas Produk',
                      'Rekomendasi Teman',
                      'Layanan Pelanggan',
                    ],
                  ),
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
        ));
  }
}

class MultipleChoice extends GetView<KusionerController> {
  final List<String> options;

  const MultipleChoice({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: options.map((option) {
          final isSelected = controller.selectedReasons.contains(option);
          return CheckboxListTile(
            title: Text(option),
            value: isSelected,
            onChanged: (_) => controller.toggleReason(option),
          );
        }).toList(),
      );
    });
  }
}

class SingleChoice extends GetView<KusionerController> {
  final String question;
  final List<String> options;

  const SingleChoice({
    Key? key,
    required this.question,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Obx(() {
          return Column(
            children: options.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: controller.selectedReason.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.setReason(value);
                  }
                },
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
