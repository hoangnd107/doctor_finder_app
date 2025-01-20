import 'package:videocalling_medical/common/utils/app_imports.dart';
import '../controllers/repot_image_controller.dart';

class Report_Image_Screen extends GetView<Report_Image_Controller> {
  @override
  Widget build(BuildContext context) {
    Get.put(Report_Image_Controller());

    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        flexibleSpace: CustomAppBar(
          title: controller.reportname,
          isBackArrow: true,
          onPressed: () => Get.back(),
          textStyle: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: 22,
            fontFamily: AppFontStyleTextStrings.medium,
          ),
        ),
        elevation: 0,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 18),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: ("${Apis.reportImagePath}${controller.imagepath}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.color1,
        child: const Icon(
          Icons.download,
          color: AppColors.WHITE,
        ),
        onPressed: () async {
          {
            customDialog1(
                s1: 'reporting_dialog1'
                    .tr,
                s2: 'please_wait_while_processing'
                    .tr);
            await controller
                .downloadAndSaveImage(
              ("${Apis.reportImagePath}${controller.imagepath}"),
            )
                .then((value) {
              if (value) {
                Get.back();
                customDialog(
                  onPressed: () {
                    Get.back();
                  },
                  s1: 'success'.tr,
                  s2: 'image_save_success'
                      .tr,
                );
              }
            });
          }
          },
      ),

    );
  }
}
