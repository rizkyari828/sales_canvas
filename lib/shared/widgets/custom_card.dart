import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/shared/shared.dart';

class CustomCardView extends StatelessWidget {
  final String code;
  final String date;
  final String tipe;
  final String approval;
  final String dateStartEnd;
  final bool updateDelete;
  final VoidCallback? onPressedEdit;
  final VoidCallback? onPressedDelete;

  CustomCardView({
    this.code = '',
    this.date = '',
    this.tipe = '',
    this.approval = '',
    this.dateStartEnd = '',
    this.updateDelete = false,
    this.onPressedEdit,
    this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        // BorderSide(color: ColorConstants.borderColor, width: 1)
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
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  code == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.subtitleText(
                          text: code, fontWeight: FontWeight.bold),
                  date == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.minSubtitleText(
                          text: date,
                        ),
                  tipe == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.minSubtitleText(text: tipe),
                  dateStartEnd == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.minSubtitleText(text: dateStartEnd),
                ],
              ),
            ),
            updateDelete
                ? Expanded(
                    child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.create,
                              color: Colors.orange,
                              size: 30,
                            ),
                            onPressed: onPressedEdit),
                        IconButton(
                            icon: Icon(
                              Icons.restore_from_trash_rounded,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: onPressedDelete),
                      ],
                    ),
                  ))
                : Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              (approval == "Approved" || approval == "Selesai")
                                  ? Icons.check_circle_outlined
                                  : (approval == "Waiting")
                                      ? Icons.access_time_outlined
                                      : Icons.close,
                              color: (approval == "Approved" ||
                                      approval == "Selesai")
                                  ? Colors.green
                                  : (approval == "Waiting" ||
                                          approval == "Created")
                                      ? Colors.orange
                                      : Colors.red,
                              size: 30,
                            ),
                            CommonWidget.captionText(
                              text: CommonWidget.convertStatus(approval),
                              color: (approval == "Approved" ||
                                      approval == "Selesai")
                                  ? Colors.green
                                  : (approval == "Waiting" ||
                                          approval == "Created")
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                          ],
                        )),
                  )
          ],
        ),
      ),
    );
  }
}

class CustomExpandedCardView extends StatelessWidget {
  final String name;
  final String firstParagraf;
  final String secondParagrafLabel;
  final String secondParagrafValue;
  final String thirdParagrafLabel;
  final String thirdParagrafValue;
  final String forthParagraf;
  final String approval;
  final bool updateDelete;
  final VoidCallback? onPressedEdit;
  final VoidCallback? onPressedDelete;

  CustomExpandedCardView({
    this.name = '',
    this.firstParagraf = '',
    this.secondParagrafLabel = '',
    this.secondParagrafValue = '',
    this.thirdParagrafLabel = '',
    this.thirdParagrafValue = '',
    this.approval = '',
    this.forthParagraf = '',
    this.updateDelete = false,
    this.onPressedEdit,
    this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  firstParagraf == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.subtitleText(
                          text: firstParagraf, fontWeight: FontWeight.bold),
                  name == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.minSubtitleText(text: name),
                  secondParagrafValue == ''
                      ? SizedBox(height: 0)
                      : Row(
                          children: [
                            Container(
                                width: sw * 0.2,
                                child: CommonWidget.minSubtitleText(
                                    text: secondParagrafLabel)),
                            CommonWidget.minSubtitleText(
                                text: ': ' + secondParagrafValue),
                          ],
                        ),
                  thirdParagrafValue == ''
                      ? SizedBox(height: 0)
                      : Row(
                          children: [
                            Container(
                                width: sw * 0.2,
                                child: CommonWidget.minSubtitleText(
                                    text: thirdParagrafLabel)),
                            CommonWidget.minSubtitleText(
                                text: ': ' + thirdParagrafValue),
                          ],
                        ),
                  forthParagraf == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.minSubtitleText(text: forthParagraf),
                ],
              ),
            ),
            approval != ''
                ? updateDelete
                    ? Expanded(
                        child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.create,
                                  color: Colors.orange,
                                  size: 30,
                                ),
                                onPressed: onPressedEdit),
                            IconButton(
                                icon: Icon(
                                  Icons.restore_from_trash_rounded,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: onPressedDelete),
                          ],
                        ),
                      ))
                    : Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  (approval == "3")
                                      ? Icons.check_circle_outlined
                                      : (approval == "1" ||
                                              approval == "2" ||
                                              approval == "6")
                                          ? Icons.access_time_outlined
                                          : Icons.close,
                                  color: (approval == "3")
                                      ? Colors.green
                                      : (approval == "1" ||
                                              approval == "2" ||
                                              approval == "6")
                                          ? Colors.orange
                                          : Colors.red,
                                  size: 30,
                                ),
                                CommonWidget.captionText(
                                  text: CommonWidget.convertStatus(approval),
                                  color: (approval == "3")
                                      ? Colors.green
                                      : (approval == "1" ||
                                              approval == "2" ||
                                              approval == "6")
                                          ? Colors.orange
                                          : Colors.red,
                                ),
                              ],
                            )),
                      )
                : Container()
          ],
        ),
      ),
    );
  }
}

class CustomExpandedImageCardView extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String location;
  final String image;
  final String time;

  CustomExpandedImageCardView({
    this.title = '',
    this.description = '',
    this.date = '',
    this.location = '',
    this.image = '',
    this.time = '',
  });

  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      height: 110,
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
      child: Row(
        children: [
          Container(
            width: sw * .3,
            height: sw * .3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                      image,
                    ),
                  ),
                ),
              ),
            ),
          ),
          CommonWidget.rowWidth(width: 10.0),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: sw * .5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.subtitleText(
                      text: title, fontWeight: FontWeight.bold),
                  CommonWidget.labelRowIcon(
                      icon: Icons.access_alarms_rounded,
                      widget: CommonWidget.subtitleText(text: time)),
                  CommonWidget.labelRowIcon(
                      icon: Icons.place_rounded,
                      widget: CommonWidget.subtitleText(text: description)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CommonWidget.labelExpanded(
                          label: location,
                          value: date,
                          fontWeight2: FontWeight.normal,
                          fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStockExpandedCardView extends StatelessWidget {
  final String name;
  final String type;
  final String price;
  final String stock;
  final VoidCallback? onPressedAdd;
  final VoidCallback? onPressedRemove;

  CustomStockExpandedCardView({
    this.name = '',
    this.type = '',
    this.price = '',
    this.stock = '',
    this.onPressedAdd,
    this.onPressedRemove,
  });

  @override
  Widget build(BuildContext context) {
    // final sw = SizeConfig().screenWidth;
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
                  name == ''
                      ? SizedBox(height: 0)
                      : Row(
                          children: [
                            stock != '0'
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
                  SizedBox(
                    height: 10,
                  ),
                  CommonWidget.subtitleText(text: type),
                  Row(
                    children: [
                      CommonWidget.subtitleText(text: 'Rp. '),
                      CommonWidget.minHeadText(
                          text: price,
                          // fontWeight: FontWeight.bold,
                          color: ColorConstants.mainColor),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_rounded,
                    color: Colors.red,
                    size: 20,
                  ),
                  onPressed: onPressedRemove,
                ),
                Obx(() => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonWidget.subtitleText(text: 'Stok'),
                        CommonWidget.bigText(
                            text: stock, color: ColorConstants.mainColor),
                      ],
                    )),
                IconButton(
                  icon: Icon(Icons.add_circle_rounded,
                      color: Colors.green, size: 20),
                  onPressed: onPressedAdd,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
