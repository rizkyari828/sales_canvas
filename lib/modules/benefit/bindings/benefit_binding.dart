import 'package:sales/modules/benefit/controllers/benefit_add_controller.dart';
import 'package:sales/modules/benefit/controllers/benefit_detail_controller.dart';
import 'package:get/get.dart';

import '../controllers/benefit_controller.dart';

class BenefitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BenefitController>(
      () => BenefitController(apiRepository: Get.find()),
    );

    Get.lazyPut<BenefitDetailController>(
      () => BenefitDetailController(apiRepository: Get.find()),
    );

    Get.lazyPut<BenefitAddController>(
      () => BenefitAddController(apiRepository: Get.find()),
    );
  }
}
