import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/utils/size_config.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:flutter/material.dart';

class ApprovalFlow {
  static Widget buttonApprovalCnC(controller) {
    final sw = SizeConfig().screenWidth;
    return Container(
      child: controller.detail.value.statusLabel == 'Waiting for approval'
          ? controller.groupId.toString() == '5'
              ? controller.detail.value.statusLabel == 'Waiting for approval'
                  ? Container(
                      child: CustomButton(
                        buttonText: 'SIMPAN',
                        width: sw,
                        onPressed: () {
                          controller.submit();
                        },
                      ),
                    )
                  : Container()
              : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        buttonColor: Colors.red,
                        buttonText: 'REJECT',
                        width: sw / 2.5,
                        onPressed: () {
                          controller.approval(action: 'reject');
                        },
                      ),
                      CustomButton(
                        buttonColor: Colors.green,
                        buttonText: 'APPROVE',
                        width: sw / 2.5,
                        onPressed: () {
                          controller.approval(action: 'approve');
                        },
                      ),
                    ],
                  ),
                )
          : Container(),
    );
  }

  static Widget buttonApproval(controller, condition, levelCondition) {
    final sw = SizeConfig().screenWidth;
    return Container(
      child: controller.detail.value.status == '1' ||
              controller.detail.value.statusLabel == 'Created'
          ? controller.groupId.toString() == '5'
              ? controller.detail.value.statusLabel == 'Created'
                  ? Container(
                      child: CustomButton(
                        buttonText: 'SIMPAN',
                        width: sw,
                        onPressed: () {
                          controller.submit();
                        },
                      ),
                    )
                  : Container()
              : condition == '1'
                  ? Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            buttonColor: Colors.red,
                            buttonText: 'REJECT',
                            width: sw / 2.5,
                            onPressed: () {
                              controller.approval(action: 'reject');
                            },
                          ),
                          CustomButton(
                            buttonColor: Colors.green,
                            buttonText: 'APPROVE',
                            width: sw / 2.5,
                            onPressed: () {
                              controller.approval(action: 'approve');
                            },
                          ),
                        ],
                      ),
                    )
                  : buttonLevelCondition(
                      controller, levelCondition, controller.groupId.toString())
          : Container(),
    );
  }

  static Widget buttonLevelCondition(controller, levelCondition, groupId) {
    final sw = SizeConfig().screenWidth;
    bool _showButton = false;
    if (groupId == '2') {
      if (levelCondition == '3') {
        _showButton = true;
      } else {}
    } else if (groupId == '3') {
      if (levelCondition == '2') {
        _showButton = true;
      } else {}
    } else if (groupId == '4') {
      if (levelCondition == '1') {
        _showButton = true;
      } else {}
    } else {}
    return _showButton
        ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  buttonColor: Colors.red,
                  buttonText: 'REJECT',
                  width: sw / 2.5,
                  onPressed: () {
                    controller.approval(action: 'reject');
                  },
                ),
                CustomButton(
                  buttonColor: Colors.green,
                  buttonText: 'APPROVE',
                  width: sw / 2.5,
                  onPressed: () {
                    controller.approval(action: 'approve');
                  },
                ),
              ],
            ),
          )
        : Container();
  }

  static Widget buttonApprovalClient(controller) {
    final sw = SizeConfig().screenWidth;
    return Container(
      child: controller.detail.value.status == '1' ||
              controller.detail.value.statusLabel == 'Created'
          ? controller.groupId.toString() == '5' ||
                  controller.groupId.toString() == '2' ||
                  controller.groupId.toString() == '3'
              ? controller.detail.value.statusLabel == 'Created'
                  ? Container(
                      child: CustomButton(
                        buttonText: 'SIMPAN',
                        width: sw,
                        onPressed: () {
                          controller.submit();
                        },
                      ),
                    )
                  : Container()
              : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        buttonColor: Colors.red,
                        buttonText: 'REJECT',
                        width: sw / 2.5,
                        onPressed: () {
                          controller.approval(action: 'reject');
                        },
                      ),
                      CustomButton(
                        buttonColor: Colors.green,
                        buttonText: 'APPROVE',
                        width: sw / 2.5,
                        onPressed: () {
                          controller.approval(action: 'approve');
                        },
                      ),
                    ],
                  ),
                )
          : Container(),
    );
  }

  static Widget hideWidget({id, widget, hideId = '5'}) {
    return id != hideId ? widget : Container();
  }

  static Widget hideClientWidget({id, widget}) {
    return id == '2' || id == '3' ? Container() : widget;
  }

  static Widget hideClientKorlapWidget({id, widget}) {
    return id == '2' || id == '3' || id == '4' ? Container() : widget;
  }

  static Widget hideClientTadWidget({id, widget}) {
    return id == '2' || id == '3' || id == '5' ? Container() : widget;
  }

  static Widget notHideWidget({id, widget, hideId = '5'}) {
    return id == hideId ? widget : Container();
  }

  static Widget statusApproval_(data) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Container(
        width: sw,
        height: sh * .05,
        child: Card(
            elevation: 0,
            color: data.status == '2' || data.statusLabel == 'Selesai'
                ? Colors.green
                : data.status == '1' ||
                        data.statusLabel == 'Created' ||
                        data.statusLabel == 'Rencana'
                    ? Colors.yellow[800]
                    : Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            )),
            child: Center(
                child: CommonWidget.bodyText(
                    text: data.statusLabel.toString(), color: Colors.white))));
  }

  static Widget statusApproval(label) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Container(
        width: sw,
        height: sh * .05,
        child: Card(
            elevation: 0,
            color: label == 'Booking'
                ? Colors.green
                : label == 'Order' || label == 'Prospek'
                    ? Colors.yellow[800]
                    : Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            )),
            child: Center(
                child: CommonWidget.bodyText(
                    text: label.toString(), color: Colors.white))));
  }

  static Widget deleteButtonApproval({controller, name}) {
    return controller.groupId.toString() != '3'
        ? IconButton(
            onPressed: () {
              controller.deleteGoods(name: name);
            },
            icon: Icon(Icons.close_rounded),
            color: Colors.red,
          )
        : Container();
  }

  static Widget addButtonApproval({controller, name, onPressed, showId = '1'}) {
    return controller.groupId.toString() == showId
        ? IconButton(
            onPressed: onPressed,
            tooltip: 'Tambah',
            icon: Icon(Icons.add_box_rounded, size: 20),
          )
        : Container();
  }

  static Widget addButtonApprovalClient(
      {controller, name, onPressed, showId = '5'}) {
    return controller.groupId.toString() == showId ||
            controller.groupId.toString() == '2'
        ? IconButton(
            onPressed: onPressed,
            tooltip: 'Tambah',
            icon: Icon(Icons.add_box_rounded, size: 20),
          )
        : Container();
  }
}
