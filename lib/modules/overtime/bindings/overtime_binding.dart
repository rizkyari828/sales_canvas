import 'package:get/get.dart';
import 'package:sales/modules/overtime/controllers/overtime_controller.dart';
import 'package:sales/modules/overtime/controllers/overtime_detail_controller.dart';
import 'package:sales/modules/overtime/controllers/overtime_list_controller.dart';


class OvertimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OvertimeController>(
      () => OvertimeController(apiRepository: Get.find()),
    );

    Get.lazyPut<OvertimeListController>(
      () => OvertimeListController(apiRepository: Get.find()),
    );

    Get.lazyPut<OvertimeDetailController>(
      () => OvertimeDetailController(apiRepository: Get.find()),
    );
  }
}
