import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class UserPastAppointmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPastAppointmentsController>(
      () => UserPastAppointmentsController(),
    );
  }
}
