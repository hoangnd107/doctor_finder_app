import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

class DoctorChooseYourPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorChooseYourPlanController>(
      () => DoctorChooseYourPlanController(),
    );
  }
}
