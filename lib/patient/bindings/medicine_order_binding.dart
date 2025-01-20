import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class MedicineOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicineOrderController>(
      () => MedicineOrderController(),
    );
  }
}
