import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class AddressAddUpdateScreen extends GetView<AddressAddUpdateController> {
  final AddressAddUpdateController addressController =
      Get.put(AddressAddUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomAppBar(
          title: addressController.isEdit
              ? 'update_address_title'.tr
              : 'add_address_title'.tr,
          isBackArrow: true,
          onPressed: () => Get.back(),
          textStyle: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: 22,
            fontFamily: AppFontStyleTextStrings.medium,
          ),
        ),
        leading: Container(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                addressController.preformAction();
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.color1,
                      AppColors.color2,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(8.71),
                ),
                child: Text(
                  addressController.isEdit ? 'update'.tr : 'save'.tr,
                  maxLines: 1,
                  style: const TextStyle(
                    fontFamily: AppFontStyleTextStrings.regular,
                    fontSize: 18,
                    color: AppColors.WHITE,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            height: Get.height - 40,
            child: Column(
              children: [
                Obx(
                  () => Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: addressController.isGoogleMapLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                              // GoogleMap(
                              //   onMapCreated: addressController.onMapCreated,
                              //   initialCameraPosition: CameraPosition(
                              //     target: addressController.center!,
                              //     zoom: 15.0,
                              //   ),
                              //   onTap: (latLang) {
                              //     addressController.sLocationUpdated.value = false;
                              //     addressController.center = latLang;
                              //     addressController.onMapTap(latLang);
                              //     addressController.test.value == true
                              //         ? addressController
                              //             .locateMarker(addressController.center!)
                              //         : addressController
                              //             .locateMarker(addressController.center!);
                              //     addressController.update();
                              //   },
                              //   buildingsEnabled: true,
                              //   compassEnabled: true,
                              //   markers: Set<Marker>.of(
                              //       addressController.markers.values.toSet()),
                              // ),
                        addressController.map()
                            ),
                    ),
                  ),
                ),
                10.hs,
                Expanded(
                    child: Column(
                  children: [
                    Obx(
                      () => EditTextField(
                        keyboardType: TextInputType.name,
                        editingController: addressController.tcAddress,
                        labelText: 'select_address_title'.tr,
                        errorText: addressController.isTcAddressError.value
                            ? 'select_address_error'.tr
                            : null,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            addressController.isTcAddressError.value = false;
                          }
                        },
                      ),
                    ),
                    Obx(
                      () => Container(
                        child:
                        Container(
                          width: Get.width -20,
                          child: EditTextField(
                            keyboardType: TextInputType.name,
                            editingController: addressController.saveAs,
                            labelText: 'save_as'.tr,
                            errorText: addressController.isSaveAsError.value
                                ? 'save_as_error'.tr
                                : null,
                            onChanged: (val) {
                              if (val.isNotEmpty) {
                                addressController.isSaveAsError.value = false;
                              }
                            },
                            onSubmitted: (val) {
                              FocusScope.of(context).unfocus();
                              addressController.preformAction();
                            },
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     AppTextWidgets.regularTextWithColor(
                        //       text: 'default_address'.tr,
                        //       color: AppColors.BLACK,
                        //     ),
                        //     Obx(
                        //       () => Checkbox(
                        //         side: const BorderSide(
                        //             color: AppColors.color1, width: 1.5),
                        //         fillColor: addressController.isDefault.value
                        //             ? const MaterialStatePropertyAll(AppColors.color1)
                        //             : const MaterialStatePropertyAll(
                        //                 Colors.transparent),
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(4)),
                        //         onChanged: (value) {
                        //           addressController.isDefault.value =
                        //               !addressController.isDefault.value;
                        //         },
                        //         value: addressController.isDefault.value,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
