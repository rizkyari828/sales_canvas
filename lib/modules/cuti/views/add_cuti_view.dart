import 'package:intl/intl.dart';
import 'package:sales/modules/cuti/controllers/cuti_controller.dart';
import 'package:sales/modules/overtime/controllers/overtime_controller.dart';
import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/utils/utils.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:sales/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCutiView extends GetView<CutiController> {
  const AddCutiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(title: 'Tambah Cuti'),
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
                    InputInputField(
                      isSuffixIcon: true,
                      suffixIcon: Icon(Icons.calendar_today_rounded),
                      controller: controller.startDateController,
                      labelText: "Tanggal Mulai",
                      onSuffixPressed: () {
                        controller.selectDateStart(
                            context, controller.startDateController);
                      },
                    ),
                    InputInputField(
                      isSuffixIcon: true,
                      suffixIcon: Icon(Icons.calendar_today_rounded),
                      controller: controller.endDateController,
                      labelText: "Tanggal Selesai",
                      onSuffixPressed: () {
                        controller.selectDateStart(
                            context, controller.endDateController);
                      },
                    ),
                    controller.validationDate.value != ""
                        ? CommonWidget.captionText(
                            text: controller.validationDate.value,
                            color: Colors.red)
                        : SizedBox(height: 0),
                    SizedBox(height: 10.0),
                    CommonWidget.bodyText(text: "Keperluan"),
                    SizedBox(height: 10.0),
                    TextAreaField(controller: controller.noteController),
                    // Card(
                    //     elevation: 0.1,
                    //     color: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15.0),
                    //         side: BorderSide(
                    //             color: ColorConstants.mainColor, width: 1)),
                    //     child: Padding(
                    //       padding: EdgeInsets.all(8.0),
                    //       child: TextField(
                    //         controller: controller.noteController,
                    //         maxLines: 8,
                    //         decoration: InputDecoration.collapsed(
                    //             hintText: "Enter your text here"),
                    //       ),
                    //     )),
                    SizedBox(height: 30.0),
                    // CommonWidget.bodyText(text: "Upload Dokumen*"),
                    // SizedBox(height: 10.0),
                    // // Padding(
                    // //   padding: const EdgeInsets.only(top: 16.0),
                    // //   child: FloatingActionButton(
                    // //     onPressed: () {
                    // //       controller.onImageButtonPressed(
                    // //         ImageSource.gallery,
                    // //         context: context,
                    // //         isMultiImage: true,
                    // //       );
                    // //     },
                    // //     heroTag: 'image1',
                    // //     tooltip: 'Pick Multiple Image from gallery',
                    // //     child: const Icon(Icons.photo_library),
                    // //   ),
                    // // ),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Obx(() =>
                    //       CustomImagePicker.previewGridImages(controller)),
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     controller.onImageButtonPressed(ImageSource.camera,
                    //         context: context);
                    //   },
                    //   child: DottedBorder(
                    //     radius: Radius.circular(100.0),
                    //     color: Colors.grey,
                    //     dashPattern: [8, 4],
                    //     strokeWidth: 1,
                    //     child: Container(
                    //       height: 50,
                    //       width: sw,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Icon(
                    //             Icons.camera_alt,
                    //             color: Colors.grey,
                    //             size: 30,
                    //           ),
                    //           SizedBox(width: 10.0),
                    //           CommonWidget.bodyText(
                    //               text: "Ambil Photo", color: Colors.grey),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 10.0),
                    // CommonWidget.captionText(
                    //     text: "Lampiran yang diizinkan PDF, PNG, JPG, JPEG"),
                    // SizedBox(height: 30.0),
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
