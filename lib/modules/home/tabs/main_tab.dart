import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sales/models/response/user/users_response.dart';
import 'package:sales/modules/home/home.dart';
import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    double scaleWidth = MediaQuery.of(context).size.width / 360;
    controller.context = context;
    return Scaffold(
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
      body: Obx(() => RefreshIndicator(
            child: _buildGridView(scaleWidth, context),
            onRefresh: () => controller.onRefresh(),
          )),
    );
  }

  Widget _buildGridView(scaleWidth, context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return SingleChildScrollView(
      child: Stack(
        children: [
          // Container(
          //   width: sw,
          //   height: sh,
          //   decoration: BoxDecoration(
          //     // borderRadius: BorderRadius.only(
          //     //   topRight: Radius.circular(20),
          //     //   topLeft: Radius.circular(20),
          //     // ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.3),
          //         blurRadius: 20.0,
          //         spreadRadius: 4.0,
          //         offset: Offset(
          //           -10.0,
          //           10.0,
          //         ),
          //       ),
          //     ],
          //     color: ColorConstants.lightScaffoldBackgroundColor,
          //   ),
          // ),
          // CommonWidget.rowHeight(),
          Container(
            margin: EdgeInsets.only(left: sw * .04, right: sw * .04, top: 0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: sh / 20,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(controller.profilePhoto.value),
                    ),
                    title: Text(
                      controller.name.value,
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    subtitle: CommonWidget.subtitleText(
                        text: controller.idPegawai.value,
                        color: ColorConstants.black),
                    trailing: InkWell(
                        onTap: controller.goToNotificationPages,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstants.mainColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  -10.0,
                                  10.0,
                                ),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.notifications,
                                color: ColorConstants.white, size: 27),
                          ),
                        )),
                  ),
                ),
                CommonWidget.rowHeight(),
                Container(height: sh * .28, child: _getSlideImage(controller)),
                // CommonWidget.rowHeight(height: sh * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, left: 10),
                    child: CommonWidget.minHeadText(
                        text: 'Menu', color: ColorConstants.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _cardMenu(Icons.airplane_ticket_rounded, "Leave",
                        controller.goToLeavePages, Colors.blue),
                    CommonWidget.rowWidth(width: sw * .03),
                    _cardMenu(Icons.handshake_rounded, "Prospek",
                        controller.goToProspekDialogPages, Colors.indigo),
                    CommonWidget.rowWidth(width: sw * .03),
                    _cardMenu(Icons.edit, "Input", controller.goToInputPages,
                        Colors.green),
                    CommonWidget.rowWidth(width: sw * .03),
                    _cardMenu(Icons.attach_money_rounded, "Benefit",
                        controller.goToBenefitPages, Colors.orange),
                  ],
                ),
                CommonWidget.rowHeight(height: sh * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _cardMenu(Icons.store, "Store", controller.goToStorePages,
                        Colors.redAccent),
                    CommonWidget.rowWidth(width: sw * .03),
                    _cardMenu(Icons.assignment, "Kuisioner",
                        controller.goToKuisionerPages, Colors.blueGrey),
                  ],
                ),
                CommonWidget.rowHeight(height: sh * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, left: 10),
                    child: CommonWidget.minHeadText(
                        text: 'Ringkasan', color: ColorConstants.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _benefitMenu(context),
                    _eventMenu(context),
                  ],
                ),
                CommonWidget.rowHeight(height: sh * 0.03),
                _statusTaskBar(),
                CommonWidget.rowHeight(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _benefitMenu(context) {
    final sw = SizeConfig().screenWidth;
    return InkWell(
      onTap: () => controller.goToBenefitPages(),
      child: Container(
          width: sw / 2.3,
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
              child: Column(children: [
                CommonWidget.bodyText(
                    text: 'Benefit'.toUpperCase(), color: ColorConstants.black),
                CommonWidget.rowHeight(),
                Icon(
                  Icons.attach_money_rounded,
                  size: 50,
                  color: Colors.orange,
                ),
                CommonWidget.rowHeight(),
                CommonWidget.subtitleText(
                    text: (controller.benefitDashboard.value?.nominal
                            .toString() ??
                        "0")),
                CommonWidget.rowHeight(height: 8.0),
                CommonWidget.subtitleText(
                  text:
                      '${DateFormat("MMMM, yyyy", "en_EN").format(DateTime.now())}',
                ),
                CommonWidget.rowHeight(),
              ]))),
    );
  }

  Widget _eventMenu(context) {
    final sw = SizeConfig().screenWidth;
    return InkWell(
      onTap: () => controller.goToEventPages(),
      child: Container(
          width: sw / 2.3,
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonWidget.bodyText(
                        text: 'Event'.toUpperCase(),
                        color: ColorConstants.black),
                    CommonWidget.rowHeight(),
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 50,
                      color: Colors.cyan,
                    ),
                    CommonWidget.rowHeight(),
                    CommonWidget.subtitleText(
                        text: controller.benefitDashboard.value?.event == ""
                            ? 'Tidak ada event'
                            : controller.benefitDashboard.value?.event ??
                                'Tidak ada event'),
                    CommonWidget.rowHeight(height: 8.0),
                    CommonWidget.subtitleText(text: controller.dateNow.value),
                    CommonWidget.rowHeight(),
                  ]))),
    );
  }

  Widget _statusTaskBar() {
    return InkWell(
      onTap: () => controller.goToLemburPages(controller.monthInt, "now", '3',
          needBack: false),
      child: Container(
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
        height: SizeConfig().screenHeight / 9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidget.rowHeight(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: CommonWidget.bodyText(
                  text: 'Data Booking'.toUpperCase(),
                  color: ColorConstants.black),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: ListTile(
                leading: Container(
                  decoration: new BoxDecoration(
                    color: ColorConstants.mainColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.library_books_rounded,
                      color: Colors.white,
                      size: SizeConfig().screenWidth * .06,
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    CommonWidget.headText(
                        text:
                            "${controller.benefitDashboard.value?.jumlahBoking ?? 0} ",
                        color: ColorConstants.mainColor),
                    CommonWidget.subtitleText(
                        text: "Dari bulan kemarin",
                        color: ColorConstants.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardMenu(icon, String title, onPressed, Color colorCircle) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: colorCircle.withOpacity(0.9),
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
        width: SizeConfig().screenWidth * .20,
        height: SizeConfig().screenHeight * .13,
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        icon,
                        color: colorCircle,
                        size: SizeConfig().screenWidth * .06,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig().screenHeight * .01),
                  CommonWidget.subtitleText(
                      text: title.toUpperCase(),
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Datum>? get data {
    return controller.users.value == null ? [] : controller.users.value!.data;
  }

  Widget _getSlideImage(HomeController controller) {
    final sw = SizeConfig().screenWidth;
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        height: 400.0,
        viewportFraction: 1,
      ),
      items: controller.listEvent.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                controller.goToDetailEventPages(
                  id: i.id.toString(),
                );
              },
              child: Container(
                width: sw,
                // margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: sw,
                        height: sw * .5,
                        child: ClipRRect(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Colors.black,
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.dstATop),
                                image: new NetworkImage(
                                  i.foto ?? '',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonWidget.bodyText(
                              text: i.namaEvent ?? '', color: Colors.white),
                          CommonWidget.bodyText(
                              text: DateFormat("MMMM dd, yyyy", "en_EN")
                                  .format(i.tanggalAcara ?? DateTime.now())
                                  .toString(),
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _getSlideImage_(HomeController controller) {
    final sw = SizeConfig().screenWidth;
    return ListView.builder(
      controller: controller.scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, i) => InkWell(
        onTap: () {
          controller.goToDetailEventPages(id: '1');
        },
        child: Container(
          width: sw,
          // margin: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Stack(
            children: [
              Container(
                width: sw,
                height: sw * .7,
                child: ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.dstATop),
                        image: new NetworkImage(
                          'https://www.ilmubahasainggris.com/wp-content/uploads/2017/03/NGC.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonWidget.bodyText(text: 'Title', color: Colors.white),
                    CommonWidget.bodyText(
                        text: DateFormat("MMMM dd, yyyy", "en_EN")
                            .format(DateTime.now())
                            .toString(),
                        color: Colors.white),
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
