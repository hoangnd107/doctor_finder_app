import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

class DoctorRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorRegisterController>(
      () => DoctorRegisterController(),
    );
  }
}
