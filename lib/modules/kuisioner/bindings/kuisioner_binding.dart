import 'package:get/get.dart';
import 'package:sales/modules/kuisioner/controllers/kuisioner_controller.dart';

class KusionerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KusionerController>(
      () => KusionerController(apiRepository: Get.find()),
    );
  }
}
