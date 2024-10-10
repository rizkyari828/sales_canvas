import 'package:sales/modules/store/controllers/store_list_controller.dart';
import 'package:sales/shared/constants/constants.dart';
import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/utils/size_config.dart';
import 'package:sales/shared/widgets/approval.dart';
import 'package:sales/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoreView extends GetView<StoreListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: ColorConstants.black //change your color here
                  ),
          centerTitle: false,
          title: Text(
            'List Store',
            style: TextStyle(
              color: ColorConstants.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
          elevation: 0.0,
        ),
        body: Obx(() => _getItems(controller)));
  }

  SmartRefresher _getItems(StoreListController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listStore.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            controller.goToDetailPages(
                id: controller.listStore[i].id.toString());
          },
          child: customStockExpandedCard(
            name: controller.listStore[i].name ?? '',
            photo: controller.listStore[i].photo ?? '',
            type: controller.listStore[i].type ?? '',
            address: controller.listStore[i].address ?? '',
          ),
        ),
      ),
    );
  }

  Widget customStockExpandedCard({
    String photo = '',
    String name = '',
    String type = '',
    String address = '',
    VoidCallback? onPressed,
  }) {
    final sh = SizeConfig().screenHeight;
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      height: name == '' ? sh * .15 : sh * .16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 20.0,
            spreadRadius: 4.0,
            offset: Offset(
              -10.0,
              10.0,
            ),
          ),
        ],
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        photo == ''
                            ? Icon(
                                Icons.store_rounded,
                                color: Colors.redAccent,
                                size: 80,
                              )
                            : Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.black,
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new NetworkImage(
                                      photo,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.minHeadText(text: name),
                            CommonWidget.subtitleText(text: type),
                            Row(
                              children: [
                                CommonWidget.subtitleText(text: 'alamat : '),
                                CommonWidget.subtitleText(
                                    text: address,
                                    // fontWeight: FontWeight.bold,
                                    color: ColorConstants.mainColor),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
