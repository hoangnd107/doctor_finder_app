import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

class DAppointmentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DAppointmentDetailsController>(
      () => DAppointmentDetailsController(),
    );
  }
}
