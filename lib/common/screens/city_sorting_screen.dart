import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CitySortingScreen extends GetView<UserHomeController> {

  final UserHomeController homeController = Get.put(UserHomeController());

  @override
  Widget build(BuildContext context) {
    homeController.getCity();
    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        flexibleSpace: CustomAppBar(
            isBackArrow: true,
            onPressed: () {
              Get.back();
            },
            title: 'Sort by city',
            textStyle: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: Theme.of(context).scaffoldBackgroundColor, fontWeightDelta: 5)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.WHITE,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 6,),
              if (homeController.citydata != null && homeController.citydata!.data!.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeController.citydata!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          homeController.selectedCityIndex.value =
                              homeController.selectedCityIndex.value == index ? -1 : index;
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items
                              children: [
                                SizedBox(width: 4,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        homeController.citydata!.data![index].cityName ??
                                            'Unknown City',
                                        style: TextStyle(
                                          fontFamily: AppFontStyleTextStrings.regular,
                                            color: AppColors.BLACK,
                                            fontSize: 15,
                                           ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(() {
                                  return SizedBox(
                                    width: 40, // Control width
                                    height: 40, // Control height
                                    child: Checkbox(
                                      value: homeController.selectedCityIndex.value == index,
                                    activeColor: AppColors.color2,
                                      onChanged: (bool? value) {
                                        if (value == true) {
                                          homeController.selectedCityIndex.value = index;
                                        } else {
                                          homeController.selectedCityIndex.value =
                                              -1; // Deselect if unchecked
                                        }
                                      },
                                    ),
                                  );
                                }),
                              ],
                            ),
                            Divider(color: AppColors.themeColor3,),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              if (homeController.citydata == null || homeController.citydata!.data!.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('no_city'.tr, style: TextStyle(color: Colors.grey)),
                  ),
                ),

              SizedBox(height: 8),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 15,),
                    Expanded(
                      child: InkWell(
                        onTap:  () {
                          homeController.selectedCityIndex.value = -1;

                          StorageService.writeStringData(
                            key: LocalStorageKeys.sortCityId,
                            value: "0".toString(),
                          );
                          StorageService.writeStringData(
                            key: LocalStorageKeys.sortCityName,
                            value: "".toString(),
                          );
                          print("${StorageService.readData(key: LocalStorageKeys.sortCityName,)}");
                          // Navigator.pop(context);
                          Get.back(result: 0 );

                        },
                        child: Stack(
                          alignment: Alignment.center,
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
                                // width: Get.width / 3,
                              ),
                            ),
                            Center(
                              child: AppTextWidgets.mediumText(
                                text: 'clear'.tr,
                                color: AppColors.WHITE,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: InkWell(
                        onTap: () {

                          if (homeController.selectedCityIndex.value != -1) {
                            final selectedCity =
                            homeController.citydata!.data![homeController.selectedCityIndex.value];

                            StorageService.writeStringData(
                              key: LocalStorageKeys.sortCityId,
                              value: "${selectedCity.id.toString()}".toString(),
                            );
                            StorageService.writeStringData(
                              key: LocalStorageKeys.sortCityName,
                              value: "${selectedCity.cityName}".toString(),
                            );

                            print("sortCityName");
                            print("${StorageService.readData(key: LocalStorageKeys.sortCityName,)}");


                            Get.back(result: selectedCity.id!);
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please select a city to submit.')),
                            );
                          }
                          // homeController.selectedCityIndex.value = -1;
                        },
                        child: Stack(
                          alignment: Alignment.center,
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
                                // width: Get.width / 3,
                              ),
                            ),
                            Center(
                              child: AppTextWidgets.mediumText(
                                text: 'Submit'.tr,
                                color: AppColors.WHITE,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),

                  ],
                ),
              ),
              SizedBox(height: 15,),

            ],
          ),
        ),
      ),
    );
  }
}
