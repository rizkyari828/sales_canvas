import 'package:sales/modules/store/controllers/store_list_controller.dart';
import 'package:sales/shared/constants/constants.dart';
import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sales/shared/widgets/custom_appbar.dart';

class StoreView extends GetView<StoreListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            CustomAppBar.appBar('List Store', controller.qualityNetwork.value),
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
                id: controller.listStore[i].tokoId.toString(),
                storeName: controller.listStore[i].namaToko ?? '');
          },
          child: Column(
            children: [
              i == 0
                  ? Column(
                      children: [hasilCard(), pendingTask()],
                    )
                  : SizedBox(),
              customStockExpandedCard(
                name: controller.listStore[i].namaToko ?? '',
                photo: controller.listStore[i].pathToko ?? '',
                type: '',
                address: controller.listStore[i].alamatToko ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget hasilCard() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10, top: 10),
      child: InkWell(
          onTap: () => controller.goToKunjunganPages(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10.0),
              // boxShadow: [
              //   BoxShadow(
              //     color: CommonWidget.setOpacity(Colors.black, 0.3),
              //     blurRadius: 20.0,
              //     spreadRadius: 4.0,
              //     offset: Offset(
              //       -10.0,
              //       10.0,
              //     ),
              //   ),
              // ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.summarize,
                        color: Colors.green,
                        size: SizeConfig().screenWidth * .05,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  CommonWidget.minHeadText(
                      text: ' Hasil Kunjungan', color: Colors.white),
                ],
              ),
            ),
          )),
    );
  }

  Widget pendingTask() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10, top: 10),
      child: InkWell(
          onTap: () => controller.goToKunjunganPages(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 2.0, color: ColorConstants.borderColor),
              // boxShadow: [
              //   BoxShadow(
              //     color: CommonWidget.setOpacity(Colors.black, 0.3),
              //     blurRadius: 20.0,
              //     spreadRadius: 4.0,
              //     offset: Offset(
              //       -10.0,
              //       10.0,
              //     ),
              //   ),
              // ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.hourglass_empty,
                        color: Colors.white,
                        size: SizeConfig().screenWidth * .05,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  CommonWidget.subtitleText(
                      text: ' Kunjungan', color: Colors.black),
                  CommonWidget.minHeadText(text: ' 0/6', color: Colors.black),
                ],
              ),
            ),
          )),
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
        border: Border.all(width: 2.0, color: ColorConstants.borderColor),
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
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.red,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.store_rounded,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.minHeadText(text: name),
                            // CommonWidget.subtitleText(text: type),
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
