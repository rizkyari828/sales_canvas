// modules/leads/views/leads_view.dart
import 'package:sales/modules/leads/controllers/leads_list_controller.dart';
import 'package:sales/shared/constants/constants.dart';
import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/widgets/approval.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LeadsView extends GetView<LeadsListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.black),
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
      body: Obx(() => _getItems(context, controller)),
    );
  }

  SmartRefresher _getItems(BuildContext context, LeadsListController c) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(),
      controller: c.refreshController,
      onRefresh: c.onRefresh,
      onLoading: c.onLoading,
      child: CustomScrollView(
        slivers: [
          // Header filter tabs
          SliverToBoxAdapter(
            child: _FilterTabsBar(controller: c),
          ),

          // List items
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => InkWell(
                onTap: () => c.goToDetailPages(dataLead: c.list[i]),
                child: CommonWidget.customStatusCard(
                  firstParagraf: c.list[i].nama ?? '',
                  secondParagraf: 'Email',
                  secondParagrafValue: c.list[i].email ?? '',
                  thirdParagraf: 'No Telepon',
                  thirdParagrafValue: c.list[i].telphone ?? '',
                  status: c.list[i].statusLead ?? '',
                  typeStatus: 'lead',
                ),
              ),
              childCount: c.list.length,
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Widget Chips Bar =====
class _FilterTabsBar extends StatelessWidget {
  const _FilterTabsBar({required this.controller});
  final LeadsListController controller;

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).primaryColor;
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(
          children: controller.tabs.map((label) {
            final bool selected = controller.currentFilter.value == label;
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ChoiceChip(
                label: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : Colors.black87,
                    letterSpacing: 0.2,
                  ),
                ),
                selected: selected,
                onSelected: (_) => controller.applyFilter(label),
                shape: const StadiumBorder(),
                selectedColor: activeColor, // warna aktif (hijau tua di tema)
                backgroundColor: const Color(0xFFF1F3F5), // abu-abu muda
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                pressElevation: 0,
                elevation: 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
