import 'package:intl/intl.dart';
import 'package:sales/modules/store/controllers/store_controller.dart';
import 'package:sales/shared/constants/constants.dart';
import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddStoreView extends GetView<StoreController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Pastikan UI update terjadi setelah build selesai
    });
    double scaleWidth = MediaQuery.of(context).size.width / 360;
    return Obx(() => Scaffold(
        floatingActionButton: controller.isConnectedToInternetWidget.value
            ? Padding(
                padding: EdgeInsets.only(left: scaleWidth * 30),
                child: controller.internetConnection(),
              )
            : SizedBox(),
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: ColorConstants.black //change your color here
                  ),
          centerTitle: false,
          title: Text(
            'List Product',
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
        body: _getItems(controller)));
  }

  SmartRefresher _getItems(StoreController controller) {
    final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: '');

    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        child: ListView.builder(
          itemCount: controller.listProduct.length,
          itemBuilder: (context, i) => customStockExpandedCard(
              name: controller.listProduct[i].namaBarang ?? '',
              type: '',
              price: currencyFormatter.format(0).toString(),
              stock: controller.listProduct[i].qtyNow?.toInt() ?? 0,
              photo: '',
              // onPressedAdd: () => controller.addStock(i),
              // onPressedRemove: () => controller.subtractStock(i),
              inputDataSheet: () => controller.inputDataSheet(
                  context,
                  controller.listProduct[i].idBarang.toString(),
                  controller.listProduct[i].namaBarang.toString())),

          // name: controller.listProduct[i].name ?? '',
          // type: controller.listProduct[i].type ?? '',
          // price: currencyFormatter
          //     .format(controller.listProduct[i].price)
          //     .toString(),
          // stock: controller.listProduct[i].stock,
          // photo: controller.listProduct[i].photo ?? '',
          // onPressedAdd: () => controller.addStock(i),
          // onPressedRemove: () => controller.subtractStock(i),
          // inputDataSheet: () => controller.inputDataSheet()),
        ));
  }

  Widget customStockExpandedCard(
      {String name = '',
      String type = '',
      String price = '',
      String photo = '',
      required int stock,
      VoidCallback? onPressedAdd,
      VoidCallback? onPressedRemove,
      VoidCallback? inputDataSheet}) {
    final sh = SizeConfig().screenHeight;
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      height: name == '' ? sh * .13 : sh * .14,
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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  photo == ''
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: ColorConstants.mainColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.shopping_bag,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        )
                      : Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    width: 10,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        name == ''
                            ? SizedBox(height: 0)
                            : Row(
                                children: [
                                  stock != 0
                                      ? Icon(
                                          Icons.timelapse,
                                          color: Colors.orange,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.check_circle_rounded,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CommonWidget.minHeadText(
                                      text: name,
                                      // fontWeight: FontWeight.bold,
                                      color: ColorConstants.mainColor),
                                ],
                              ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // CommonWidget.subtitleText(text: type),
                        Row(
                          children: [
                            CommonWidget.subtitleText(text: 'Rp. '),
                            CommonWidget.minHeadText(
                                text: price,
                                // fontWeight: FontWeight.bold,
                                color: Colors.deepOrange),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget.subtitleText(text: 'Stok'),
                  CommonWidget.bigText(
                      text: stock.toString(), color: ColorConstants.mainColor),
                  InkWell(
                    child: Card(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.remove_circle,
                              color: Colors.white,
                              size: 15,
                            ),
                            CommonWidget.captionText(
                                text: ' Ubah', color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    onTap: inputDataSheet,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     InkWell(
                  //       child: Icon(
                  //         Icons.remove_circle_rounded,
                  //         color: Colors.red,
                  //         size: 25,
                  //       ),
                  //       onTap: onPressedRemove,
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     InkWell(
                  //       child: Container(
                  //         child: Icon(Icons.add_circle_rounded,
                  //             color: Colors.green, size: 25),
                  //       ),
                  //       onTap: onPressedAdd,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
