import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:http/http.dart' as http;

class Report_Image_Controller extends GetxController{
  String imagepath = '';
  String reportname = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    imagepath  = Get.arguments['imagepath'];
    reportname  = Get.arguments['reportname'];
    print("${Apis.reportImagePath}${imagepath.toString()}");
  }

  Future<bool> downloadAndSaveImage(String url) async {
    http.Client client = http.Client();
    var req = await client
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: Apis.timeOut));
    if (req.statusCode >= 400) {
      Get.back();
      customDialog(
        onPressed: () {
          Get.back();
        },
        s1: 'error'.tr,
        s2: '${req.reasonPhrase}'.tr,
      );
      return false;
    }
    var bytes = req.bodyBytes;
    try {
      String dir = '/storage/emulated/0/Dcim/${url.split("/").last}';
      File file = File(dir);
      await file.writeAsBytes(bytes);
      print("${dir}");

      return true;
    } catch (e) {
      Get.back();
      customDialog(
        onPressed: () {
          Get.back();
        },
        s1: 'error'.tr,
        s2: e.toString(),
      );
      return false;
    }
  }

}