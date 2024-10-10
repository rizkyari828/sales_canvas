import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:sales/modules/benefit/controllers/benefit_controller.dart';
import 'package:sales/shared/constants/constants.dart';
import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BenefitView extends GetView<BenefitController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          iconTheme: IconThemeData(color: ColorConstants.black),
          title: Obx(() => controller.isSearch.value
              ? Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: ColorConstants.backgroundTextField,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    onSubmitted: (value) {
                      controller.getBenefit(1);
                    },
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      letterSpacing: 0.15,
                      fontFamily: 'Poppins',
                    ),
                    controller: controller.searchNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          controller.onSearch(false);
                          // controller.searchNameController.clear();
                        },
                      ),
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        letterSpacing: 0.15,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )
              : Text(
                  'Benefit',
                  style: TextStyle(
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                )),
          backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
          elevation: 0.0,
          actions: [
            Obx(() => controller.isSearch.value == false
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.onSearch(true);
                        },
                        tooltip: 'Search',
                        icon: Icon(Icons.search_rounded, size: 20),
                      ),
                      IconButton(
                        onPressed: () {
                          showMonthPicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year - 1, 5),
                            lastDate: DateTime(DateTime.now().year + 1, 9),
                            initialDate:
                                controller.selectedDate ?? DateTime.now(),
                          ).then((date) {
                            if (date != null) {
                              controller.selectedDate = date;
                              controller.month.value =
                                  DateFormat("MMMM yyyy", "id_ID")
                                      .format(date)
                                      .toString();
                              controller.listBenefit.clear();
                              controller.getBenefit(1);
                            }
                          });
                        },
                        tooltip: 'Pilih Bulan',
                        icon: Icon(Icons.calendar_month_rounded, size: 20),
                      ),
                    ],
                  )
                : Container())
          ],
        ),
        body: Obx(() => _getItems(controller)));
  }

  SmartRefresher _getItems(BenefitController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listBenefit.length,
        itemBuilder: (context, i) => Column(
          children: [
            i == 0
                ? Obx(() => Column(
                      children: [
                        SizedBox(height: 10.0),
                        CommonWidget.minHeadText(
                          text: controller.month.value,
                          color: ColorConstants.black,
                        ),
                      ],
                    ))
                : Container(),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                // controller.goToDetailCutiPages(id: '1');
              },
              child: CustomExpandedCardView(
                firstParagraf: controller.listBenefit[i].noTrans ?? '',
                secondParagrafLabel: "Name",
                secondParagrafValue: controller.listBenefit[i].name.toString(),
                thirdParagrafLabel: "Pengajuan",
                thirdParagrafValue:
                    '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.listBenefit[i].dateBoking ?? DateTime.now())}',
                // forthParagraf:
                //     '${DateFormat("d MMMM yyyy", "id_ID").format(controller.listBenefit[i].dateStart ?? DateTime.now())} - ${DateFormat("d MMMM yyyy", "id_ID").format(controller.listBenefit[i].dateEnd ?? DateTime.now())}',
                // approval:
                //     controller.listBenefit[i].statusLabel == 'Waiting for approval'
                //         ? 'Waiting'
                //         : controller.listBenefit[i].statusLabel ?? '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
