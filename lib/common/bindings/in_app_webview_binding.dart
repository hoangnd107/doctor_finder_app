import 'package:videocalling_medical/common/utils/app_imports.dart';

class InAppWebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InAppWebViewController1>(
      () => InAppWebViewController1(),
    );
  }
}
