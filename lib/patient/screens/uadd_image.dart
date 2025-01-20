import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class UserAddImage extends GetView<UserEditController> {
  final UserEditController editController = Get.put(UserEditController());
  final RegisterPatientController registerController = Get.put(RegisterPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: CustomAppBar(
          title: 'upload_image'.tr,
          isBackArrow: false,
          onPressed: () => Get.back(),
        ),
        leading: Container(),
      ),
      body: Obx(() => editController.isLoaded.value
          ? const LinearProgressIndicator()
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // add user image
                          Stack(
                            children: [
                              Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(70),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColorDark.withOpacity(0.4),
                                    width: 1,
                                  ),
                                ),
                                child: Obx(() => Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(65),
                                        child: editController.image != null || editController.isImageSelected.value
                                            ? Image.file(
                                                editController.image!,
                                                height: 130,
                                                width: 130,
                                                fit: BoxFit.fill,
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: editController.profileImage,
                                                height: 130,
                                                width: 130,
                                                placeholder: (context, url) => Icon(
                                                  Icons.image,
                                                  color: Theme.of(context).primaryColorDark.withOpacity(0.5),
                                                ),
                                                errorWidget: (context, url, error) => Icon(
                                                  Icons.image,
                                                  color: Theme.of(context).primaryColorDark.withOpacity(0.5),
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 135,
                                width: 135,
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        editController.getImage();
                                      },
                                      child: Image.asset(
                                        AppImages.editHomeScreen,
                                        height: 35,
                                        width: 35,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 150,
                        decoration: const BoxDecoration(
                            color: AppColors.WHITE,
                            borderRadius:
                                BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: InkWell(
                                  onTap: () {
                                    editController.updateUser();
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.color1,
                                                AppColors.color2,
                                              ],
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                            ),
                                          ),
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                      Center(
                                        child: AppTextWidgets.regularText(
                                          text: 'update'.tr,
                                          color: AppColors.WHITE,
                                          size: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 40,
                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AppTextWidgets.regularText(text: 'dont_upload'.tr, size: 12, color: AppColors.BLACK),
                                        GestureDetector(
                                          onTap: () {
                                            Get.offAllNamed(Routes.userTabScreen);
                                          },
                                          child: AppTextWidgets.mediumText(
                                            text: " ${'skip'.tr}",
                                            color: AppColors.AMBER,
                                            size: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),

                                // InkWell(
                                //   onTap: () {
                                //     Get.offAllNamed(Routes.userTabScreen);
                                //   },
                                //   child: Stack(
                                //     children: [
                                //       ClipRRect(
                                //         borderRadius: BorderRadius.circular(25),
                                //         child: Container(
                                //           decoration: const BoxDecoration(
                                //             gradient: LinearGradient(
                                //               colors: [
                                //                 AppColors.color1,
                                //                 AppColors.color2,
                                //               ],
                                //               begin: Alignment.bottomLeft,
                                //               end: Alignment.topRight,
                                //             ),
                                //           ),
                                //           height: 50,
                                //           width: MediaQuery.of(context).size.width,
                                //         ),
                                //       ),
                                //       Center(
                                //         child: AppTextWidgets.regularText(
                                //           text: 'skip'.tr,
                                //           color: AppColors.WHITE,
                                //           size: 18,
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),


                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),


              ],
            )),
    );
  }
}
