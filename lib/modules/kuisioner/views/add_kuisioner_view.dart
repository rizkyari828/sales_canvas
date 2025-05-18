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
