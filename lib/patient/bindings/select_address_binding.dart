import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class SelectAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectAddressController>(
      () => SelectAddressController(),
    );
  }
}
