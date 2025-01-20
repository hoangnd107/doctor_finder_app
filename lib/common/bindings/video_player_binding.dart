import 'package:videocalling_medical/common/utils/app_imports.dart';

class MyVideoPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyVideoPlayerController>(
      () => MyVideoPlayerController(),
    );
  }
}
