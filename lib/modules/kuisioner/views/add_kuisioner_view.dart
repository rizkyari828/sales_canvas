import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sales/modules/kuisioner/controllers/kuisioner_controller.dart';
import 'package:sales/shared/utils/utils.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:sales/shared/widgets/custom_appbar.dart';
import 'package:sales/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddKuisionerView extends GetView<KusionerController> {
  const AddKuisionerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return Obx(() => Scaffold(
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
                  buttonText: 'SIMPAN',
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    controller.submit();
                  },
                ),
              ),
        body: _getItems(controller)));
  }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: CommonWidget.appBar(title: 'Input Kuisioner'),
//         body: SingleChildScrollView(
//           child: Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CommonWidget.labelExpanded(
//                       label: 'Tanggal Kuisioner',
//                       value: DateFormat("EEEE, d MMMM yyyy", "id_ID")
//                           .format(DateTime.now())
//                           .toString()),
//                   SizedBox(height: 20.0),
//                   CommonWidget.bodyText(text: "Soal Essay"),
//                   SizedBox(height: 10.0),
//                   TextAreaField(
//                     controller: controller.answerController,
//                   ),
//                   SizedBox(height: 10),
//                   SingleChoice(
//                     question: 'Apa alasan utama Anda menggunakan produk kami?',
//                     options: [
//                       'Harga Terjangkau',
//                       'Kualitas Produk',
//                       'Rekomendasi Teman',
//                       'Layanan Pelanggan',
//                     ],
//                   ),
//                   SizedBox(height: 30.0),
//                   CustomButton(
//                     buttonText: 'SIMPAN',
//                     width: MediaQuery.of(context).size.width,
//                     onPressed: () {
//                       controller.submit();
//                     },
//                   ),
//                 ],
//               )),
//         ));
//   }
// }

  SmartRefresher _getItems(KusionerController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listKuisioner.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                i == 0
                    ? Column(
                        children: [
                          CommonWidget.labelExpanded(
                              label: 'Tanggal Kuisioner',
                              value: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                  .format(DateTime.now())
                                  .toString()),
                          SizedBox(height: 20.0),
                        ],
                      )
                    : SizedBox(),
                controller.listKuisioner[i].type == 'essay'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget.bodyText(
                              text: controller.listKuisioner[i].question ?? ''),
                          SizedBox(height: 10.0),
                          TextAreaField(
                            controller: controller.answerController,
                          ),
                          SizedBox(height: 10),
                        ],
                      )
                    : SingleChoice(
                        question: controller.listKuisioner[i].question ?? '',
                        options: [
                          controller.listKuisioner[i].optionA ?? '',
                          controller.listKuisioner[i].optionB ?? '',
                          controller.listKuisioner[i].optionC ?? '',
                          controller.listKuisioner[i].optionD ?? '',
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
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
                groupValue: controller.selectedAnswer.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.setAnswer(value);
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
