import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

import '../../common/screens/city_sorting_screen.dart';

class SpecialityDoctorScreen extends GetView<SpecialityDoctorController> {
  final SpecialityDoctorController specialityDoctorController =
  Get.put(SpecialityDoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        // flexibleSpace: Obx(() {
        //   print("${specialityDoctorController.selected_city_name.value}");
        //   return CustomAppBar(
        //     title: specialityDoctorController.page == 2 ? 'pharmacy'.tr : 'nearby_doctors'.tr,
        //     isTitle2: (specialityDoctorController.selected_city_name.value.toString() == 0 || nearbyController.selected_city_name.value.toString() == "" || nearbyController.selected_city_name.value.toString() == "not") ? false : true,
        //     title2: "${specialityDoctorController.selected_city_name.value}",
        //     // title2:"${nearbyController.selected_city_name.toString()}",
        //     isBackArrow: true,
        //     sortIcon: true,
        //     onPressedClear: () {
        //       Get.to(CitySortingScreen())!.then((cityId) {
        //         print("cityId==> $cityId");
        //
        //         specialityDoctorController.selected_city =
        //         "${StorageService.readData(key: LocalStorageKeys.sortCityId) ?? "0"}";
        //
        //         String selected_city_n =
        //             "${StorageService.readData(key: LocalStorageKeys.sortCityName) ?? "not"}";
        //
        //         // nearbyController.selected_city_name = selected_city_n;
        //         specialityDoctorController.selected_city_name.value =
        //             selected_city_n; // Use .value to update the observable
        //
        //         nearbyController.page == 2 ?
        //         nearbyController.list1.clear() :
        //         nearbyController.list.clear();
        //         if (cityId != null) {
        //           nearbyController.page == 2 ?
        //           nearbyController.callPharmacyApi(
        //               cityId: nearbyController.selected_city.toString())
        //               :
        //           nearbyController.callApi(
        //               latitude: double.parse(latitude.toString()),
        //               longitude: double.parse(longitude.toString()),
        //               cityId: nearbyController.selected_city.toString()
        //           );
        //         }
        //         else {
        //           nearbyController.page == 2 ?
        //           nearbyController.callPharmacyApi(
        //               cityId: nearbyController.selected_city.toString())
        //               :
        //           nearbyController.callApi(
        //               latitude: double.parse(latitude.toString()),
        //               longitude: double.parse(longitude.toString()),
        //               cityId: nearbyController.selected_city.toString());
        //         }
        //       });
        //     },
        //
        //
        //     onPressed: () => Get.back(),
        //   );
        // }),

        flexibleSpace: Obx(() {
          return CustomAppBar(
            title: specialityDoctorController.name.toString(),
            isTitle2: (specialityDoctorController.selected_city_name.value.toString() == 0 ||
                specialityDoctorController.selected_city_name.value.toString() == "" ||
                specialityDoctorController.selected_city_name.value.toString() == "not"
            )
                ? false
                : true,
            title2: "${specialityDoctorController.selected_city_name.value}",
            isBackArrow: true,
            sortIcon: true,
            onPressedClear: () async {

              // homeController.selectedCityIndex.value= int.parse(selected_city.toString())-1;
              Get.to(CitySortingScreen())!.then((cityId) {

                print("cityId==> $cityId");

                String selected_city = "${StorageService.readData(
                    key: LocalStorageKeys
                        .sortCityId) ??
                    "0"}";

                String selected_city_n =
                    "${StorageService.readData(key: LocalStorageKeys.sortCityName) ?? "not"}";

                specialityDoctorController.selected_city_name.value =
                    selected_city_n;

                if (cityId != null) {
                  // homeController.callApi(
                  //     latitude: double.parse(latitude.toString()),
                  //     longitude: double.parse(longitude.toString()),
                  //     cityId: selected_city.toString());
                  specialityDoctorController.doctorList.clear();
                  specialityDoctorController.getLocationStart(cityId: cityId.toString());

                  // homeController.callApi(cityId: cityId.toString());
                }
                else{
                  specialityDoctorController.doctorList.clear();
                  specialityDoctorController.getLocationStart(cityId: "${selected_city}");
                }
              });
            },

            onPressed: () => Get.back(),
          );
        }),
        elevation: 0,
      ),
      bottomNavigationBar: Obx(() =>
          Container(
            child: specialityDoctorController.isLoadingMore.value
                ? const LinearProgressIndicator(color: AppColors.color1)
                : const SizedBox(),
          )),
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      body: Obx(
            () =>
        specialityDoctorController.isErrorInLoading.value
            ? Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 100,
                color: AppColors.LIGHT_GREY_TEXT,
              ),
              20.hs,
              Text(
                'unable_to_load_data'.tr,
                style: const TextStyle(
                  fontFamily: AppFontStyleTextStrings.regular,
                ),
              )
            ],
          ),
        )
            : SingleChildScrollView(
          controller: specialityDoctorController.scrollController,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 5),
            child: Column(
              children: [
                10.hs,
                specialityDoctorController.isNearbyLoading.value
                    ? SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 80,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    : specialityDoctorController.doctorList.isEmpty
                    ? specialityDoctorController.isErrorInNearby.value
                    ? Center(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      30.hs,
                      AppTextWidgets.regularText(
                          text: 'turn_on_location_and_retry'
                              .tr,
                          size: 12,
                          color: AppColors.BLACK),
                    ],
                  ),
                )
                    : Container(
                  height: Get.height * 0.4,
                  alignment: Alignment.center,
                  child: AppTextWidgets.regularText(
                      text: 'doctor_not_found'.tr,
                      size: 20,
                      color: AppColors.BLACK),
                )
                    : Obx(
                      () =>
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: specialityDoctorController
                            .doctorList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () async {
                              await Get.toNamed(
                                  Routes.doctorDetailScreen,
                                  arguments: {
                                    'id': specialityDoctorController
                                        .doctorList[index].id
                                        .toString(),
                                    'type': 1
                                  });
                              Get.delete<DoctorDetailController>();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.WHITE,
                                borderRadius:
                                BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.fromLTRB(
                                10,
                                10,
                                10,
                                20,
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        specialityDoctorController
                                            .doctorList[index]
                                            .image!,
                                        fit: BoxFit.cover,
                                        width: 250,
                                        placeholder:
                                            (context, url) =>
                                            Container(
                                              color: Theme
                                                  .of(context)
                                                  .primaryColorLight,
                                              child: Center(
                                                child: Image.asset(
                                                  AppImages
                                                      .tab3dUnselect,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ),
                                            ),
                                        errorWidget:
                                            (context, url, err) =>
                                            Container(
                                              color: Theme
                                                  .of(context)
                                                  .primaryColorLight,
                                              child: Center(
                                                child: Image.asset(
                                                  AppImages
                                                      .tab3dUnselect,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                  10.hs,
                                  AppTextWidgets.mediumText(
                                    text: specialityDoctorController
                                        .doctorList[index]
                                        .name ??
                                        "",
                                    color: AppColors.BLACK,
                                    size: 13,
                                  ),
                                  AppTextWidgets.mediumText(
                                    text: specialityDoctorController
                                        .doctorList[index]
                                        .departmentName ??
                                        "",
                                    color:
                                    AppColors.LIGHT_GREY_TEXT,
                                    size: 9.5,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
