import 'package:videocalling_medical/common/utils/app_imports.dart';

class IncomingCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncomingCallController>(
      () => IncomingCallController(),
    );
  }
}
