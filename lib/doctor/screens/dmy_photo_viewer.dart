import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

class DMyPhotoView extends GetView<DMyPhotoViewController> {
  final DMyPhotoViewController photoViewController =
      Get.put(DMyPhotoViewController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: AppColors.transparentColor,
        toolbarHeight: kToolbarHeight,
        elevation: 0.0,
        flexibleSpace: CustomAppBar(
          title: ''.tr,
          onPressed: () {

            Get.back();
          },
          isBackArrow: true,

        ),
      ),
      body:  Container(
        color: Colors.transparent,
        child: photoViewController.isFromFile
            ? PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.transparent),
          imageProvider: FileImage(File(photoViewController.imagePath)),
        )
            : PhotoView(
          imageProvider: NetworkImage(photoViewController.imagePath),
        ),
      ),
    );
  }
}
