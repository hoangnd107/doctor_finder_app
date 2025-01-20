import 'package:videocalling_medical/common/utils/app_imports.dart';

class MyVideoThumbnailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyVideoThumbnailController>(
      () => MyVideoThumbnailController(url: ''),
    );
  }
}
