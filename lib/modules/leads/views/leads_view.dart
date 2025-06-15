import 'package:sales/modules/leads/controllers/leads_list_controller.dart';
import 'package:sales/shared/constants/constants.dart';
import 'package:sales/shared/widgets/approval.dart';
import 'package:sales/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LeadsView extends GetView<LeadsListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: ColorConstants.black //change your color here
                  ),
          centerTitle: false,
          title: Text(
            'List Leads',
            style: TextStyle(
              color: ColorConstants.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
          elevation: 0.0,
          actions: [
            Obx(() => ApprovalFlow.addButtonApproval(
                controller: controller, onPressed: controller.goToAddPages))
          ],
        ),
        body: Obx(() => _getItems(controller)));
  }

  SmartRefresher _getItems(LeadsListController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.list.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            controller.goToDetailPages(id: controller.list[i].id.toString());
          },
          child: CustomExpandedCardView(
            name:
                '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.list[i].cDate ?? DateTime.now())}',
            firstParagraf: controller.list[i].kodeIjin ?? '',
            secondParagrafLabel: "Mulai",
            secondParagrafValue:
                '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.list[i].dateIn ?? DateTime.now())}',
            thirdParagrafLabel: "Selesai",
            thirdParagrafValue:
                '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.list[i].dateOut ?? DateTime.now())}',
            forthParagraf: controller.list[i].keterangan ?? '',
          ),
        ),
      ),
    );
  }
}
