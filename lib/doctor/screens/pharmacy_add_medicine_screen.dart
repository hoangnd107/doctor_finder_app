import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';
import 'package:videocalling_medical/doctor/screens/pharmacy_medicine_edit_screen.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

class PharmacyAddMedicineScreen extends GetView<DMoreInfoController> {
  final DMoreInfoController controller = Get.put(DMoreInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: CustomAppBar(
          title: 'medicine_str'.tr,
          textStyle: Theme.of(context).textTheme.headlineSmall!.apply(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeightDelta: 5,
              ),
        ),
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child:

        Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             if(controller.isLoaded.value == false)
              Spacer(),

              controller.isLoaded.value
                  ? Expanded(
                flex: 20,
                    child: Container(
                    // height: Get.height-270,
                        child:
                        ListView.builder(
                          controller: controller.allMedicineScrollController,
                          itemCount: controller.medicineAllData!.data!.length,
                           scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              decoration: BoxDecoration(
                                color: AppColors.WHITE,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyShade3,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 0),
                                        child: controller
                                                    .medicineAllData!.data![index].image ==
                                                "null"
                                            ? Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: Color(0xFFEEEEEE),
                                                ),
                                                child: Opacity(
                                                  opacity: 0.60,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(12),
                                                    child: Image.asset(
                                                      AppImages.medicine1,
                                                      fit: BoxFit.contain,
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.network(
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit.cover,
                                                  "${Apis.medicineImage}${controller.medicineAllData!.data![index].image}",
                                                  errorBuilder:
                                                      (context, error, stackTrace) {
                                                    return Image.asset(
                                                      AppImages.medicine1,
                                                    );
                                                  },
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 10,
                                                child: Text(
                                                  controller.medicineAllData!.data![index]
                                                          .name ??
                                                      "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFontStyleTextStrings.medium,
                                                    color: AppColors.reportTextColor,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          // medicine_price
                                          Row(
                                            children: [
                                              Text(
                                                "medicine_price".tr,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFontStyleTextStrings.medium,
                                                  fontSize: 15,
                                                  color: AppColors.color1,
                                                ),
                                              ),
                                              Text(
                                                " ${(double.parse(controller.medicineAllData!.data![index].price!.toString()).toStringAsFixed(1)).toString()}$CURRENCY",
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFontStyleTextStrings.medium,
                                                  fontSize: 15,
                                                  color: AppColors.color1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 12,left: 12),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            controller.nameController.clear();
                                            controller.feeController.clear();
                                            controller.aboutUsController.clear();
                                            controller.imagePath.value = '';
                                            controller.sImage = null;
                                            controller.getMedicineData(controller
                                                .medicineAllData!.data![index].id
                                                .toString());
                                            Get.to(PharmacyMedicineEditScreen());
                                          },
                                          child: Container(
                                              height: 35,
                                              width: 35,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: AppColors.color1),
                                              child: SizedBox(
                                                height: 16,
                                                width: 16,
                                                child: Image.asset(
                                                  AppImages.editicon_medicine,
                                                  color: AppColors.WHITE,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                  )
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Theme.of(context).hintColor),
                      ),
                    ),

              if(controller.isLoaded.value == false)
                Spacer(),

              Container(
                child: InkWell(
                    onTap: () async {
                      controller.nameController.clear();
                      controller.feeController.clear();
                      controller.aboutUsController.clear();
                      controller.imagePath.value = '';
                      controller.sImage = null;
                      Get.to(PharmacyMedicineEditScreen());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.color1,
                              AppColors.color2,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      height: 50,
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'add_medicine'.tr,
                            style: Theme.of(context).textTheme.bodyLarge!.apply(
                                fontWeightDelta: 1,
                                color: AppColors.WHITE,
                                fontSizeDelta: 5),
                          ),
                          SizedBox(width: 8,),
                          const Icon(
                            Icons.add,
                            color: AppColors.WHITE,
                            size: 27,
                          )
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          );
        }),
      ),
    );
  }
}
