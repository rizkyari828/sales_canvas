import 'package:sales/modules/kuisioner/controllers/kuisioner_controller.dart';
import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/utils/custom_pop_scope.dart';
import 'package:sales/shared/utils/utils.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:sales/shared/widgets/custom_appbar.dart';
import 'package:sales/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/routes/app_pages.dart';

class AddKuisionerView extends GetView<KusionerController> {
  const AddKuisionerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.HOME);
        return false;
      },
      child: Obx(() => _buildWidget(context)),
    );
  }

  Widget _buildWidget(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return Scaffold(
        appBar: CustomAppBarWithNetwork(
          title: 'Input Kuisioner',
          networkStatus: controller.qualityNetwork,
        ),
        floatingActionButton: controller.isConnectedToInternetWidget.value
            ? Padding(
                padding: EdgeInsets.only(left: sw * 08),
                child: controller.internetConnection(),
              )
            : Padding(
                padding: EdgeInsets.only(left: sw * .08),
                child: CustomButton(
                  buttonText: controller.percentage.value >= 1.0
                      ? 'SIMPAN'
                      : 'SELANJUTNYA',
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if (controller.percentage.value >= 1.0) {
                      controller.submit(isLast: true);
                    } else {
                      controller.submit(isLast: false);
                    }
                  },
                ),
              ),
        body: _getItems(controller));
  }

  Widget _getItems(KusionerController controller) {
    final sh = SizeConfig().screenHeight;
    return Column(
      children: [
        Container(
          height: sh * .750,
          child: ListView.builder(
              itemCount: controller.listKuisioner.length,
              itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 20),
                    child: Column(
                      children: [
                        i == 0
                            ? Column(
                                children: [
                                  SizedBox(height: 20.0),
                                  CommonWidget.progressLiniar(
                                      controller.currentProgress.value,
                                      controller.allProgress.value,
                                      controller.percentage.value,
                                      context),
                                ],
                              )
                            : SizedBox(),
                        controller.listKuisioner[i].idKategori == 2
                            ? soalEssay(
                                controller.currentProgress.value + i + 1,
                                controller.listKuisioner[i].soal ?? '',
                                controller.listKuisioner[i].idSoal ?? 0,
                                controller.listKuisioner[i].idKategori ?? 0,
                                controller,
                                initialValue: controller.answers[controller
                                            .listKuisioner[i].idSoal
                                            ?.toString() ??
                                        ""] ??
                                    "",
                              )
                            : SingleChoice(
                                no: controller.currentProgress.value + i + 1,
                                question:
                                    controller.listKuisioner[i].soal ?? '',
                                idSoal: controller.listKuisioner[i].idSoal ?? 0,
                                idKategori:
                                    controller.listKuisioner[i].idKategori ?? 0,
                                options: [
                                  controller.listKuisioner[i].pilihan1 ?? '',
                                  controller.listKuisioner[i].pilihan2 ?? '',
                                  controller.listKuisioner[i].pilihan3 ?? '',
                                  controller.listKuisioner[i].pilihan4 ?? '',
                                ],
                              ),
                      ],
                    ),
                  )),
        ),
      ],
    );
  }
}

Widget soalEssay(int no, String question, int idSoal, int idKategori,
    KusionerController controller,
    {String initialValue = ""}) {
  final sh = SizeConfig().screenHeight;
  final idSoalStr = idSoal.toString();
  if (!controller.essayControllers.containsKey(idSoalStr)) {
    controller.essayControllers[idSoalStr] = TextEditingController(
      text: controller.answers[idSoalStr] ?? "",
    );
  }
  final textController = controller.essayControllers[idSoalStr]!;
  return Container(
    height: sh * .30,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(width: 2.0, color: ColorConstants.borderColor),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.bodyMultilineText(text: "${no}. $question"),
          SizedBox(height: 10.0),
          TextAreaField(
            controller: textController,
            onChanged: (val) {
              controller.setAnswer(
                idSoalStr,
                idKategori.toString(),
                val,
              );
            },
          ),
        ],
      ),
    ),
  );
}

class SingleChoice extends GetView<KusionerController> {
  final int no;
  final String question;
  final int idSoal;
  final int idKategori;
  final List<String> options;

  const SingleChoice({
    Key? key,
    required this.no,
    required this.question,
    required this.idSoal,
    required this.idKategori,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final sh = SizeConfig().screenHeight;
    return Container(
      height: sh * .36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 2.0, color: ColorConstants.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.bodyMultilineText(text: "${no}. $question"),
            const SizedBox(height: 10),
            Obx(() {
              return Column(
                children: options.map((option) {
                  return RadioListTile<String>(
                      title: CommonWidget.bodyText(text: option),
                      value: option,
                      groupValue: controller.answers[idSoal.toString()],
                      onChanged: (value) {
                        if (value != null) {
                          controller.setAnswer(
                            idSoal.toString(),
                            idKategori.toString(),
                            value,
                          );
                        }
                      });
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
