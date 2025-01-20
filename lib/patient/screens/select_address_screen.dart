import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class SelectAddressScreen extends GetView<SelectAddressController> {
  final SelectAddressController addressController =
  Get.put(SelectAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: CustomAppBar(
          title: 'address'.tr,
          isBackArrow: true,
          onPressed: () {
            if (addressController.selectedId.value == 0) {
              Get.back();
            } else {
              Get.back(
                  result: addressController.aList[addressController.aList
                      .indexWhere((element) =>
                  element.id == addressController.selectedId.value)]);
            }
          },
          textStyle: TextStyle(
            color: Theme
                .of(context)
                .scaffoldBackgroundColor,
            fontSize: 22,
            fontFamily: AppFontStyleTextStrings.medium,
          ),
        ),
        leading: Container(),
      ),

      bottomNavigationBar: Obx(() =>
      addressController.selectedId.value == 0
          ? 0.hs
          : Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Get.back(
                  result: addressController.aList[addressController.aList
                      .indexWhere((element) =>
                  element.id ==
                      addressController.selectedId.value)],
                );
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
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'select_above_address'.tr,
                  maxLines: 1,
                  style: const TextStyle(
                    fontFamily: AppFontStyleTextStrings.semiBold,
                    fontSize: 18,
                    color: AppColors.WHITE,
                  ),
                ),
              ),
            )
          ],
        ),
      )),

      body: Obx(() =>
      addressController.isDataLoaded.value
          ? addressController.aList.isEmpty
          ? Column(
            children: [
              Spacer(),
              Text(
                'address_not_found'.tr,
                maxLines: 1,
                style: const TextStyle(
                  fontFamily: AppFontStyleTextStrings.regular,
                  fontSize: 20,
                  color: AppColors.BLACK,
                ),
              ),
              Spacer(),
              Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  await Get.toNamed(
                    Routes.addressAddUpdateScreen,
                    arguments: {
                      'isEdit': false,
                    },
                  );
                  Get.delete<AddressAddUpdateController>();
                  addressController.getAddressList();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
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
                    'add_address1'.tr,
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: AppFontStyleTextStrings.regular,
                      fontSize: 18,
                      color: AppColors.WHITE,
                    ),
                  ),
                ),
              ),
                      ),
                    ),
            ],
          )
          :

      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15, bottom: 2),
            child: InkWell(
              onTap: () async {
                await Get.toNamed(
                  Routes.addressAddUpdateScreen,
                  arguments: {
                    'isEdit': false,
                  },
                );
                Get.delete<AddressAddUpdateController>();
                addressController.getAddressList();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                    color: AppColors.WHITE
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('add_address1'.tr,
                        style: TextStyle(
                          fontFamily: AppFontStyleTextStrings.semiBold,
                          fontSize: 18,
                          color: AppColors.reportTextColor,
                        )),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: addressController.aList.length,
              itemBuilder: (context, index) {
                bool isDefault =
                    addressController.aList[index].defaultAddress ==
                        1;
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15, bottom:2),
                  child: InkWell(
                    onTap: () {
                      addressController.indexval.value = index;
                      addressController.selected = addressController.aList[index];
                      // print(addressController.selected);
                      // print(addressController.aList);
                      // print(addressController.selectedId);
                      // print(addressController.selected?.tag);
                      addressController.selectedId.value = addressController.selected?.id ?? 0;
                      addressController.update();
                      Get.back(
                        result: addressController.aList[addressController.aList
                            .indexWhere((element) =>
                        element.id ==
                            addressController.selectedId.value)],
                      );
                    },
                    child: Obx(() {
                      return Container(
                        // margin: const EdgeInsets.only(top: 5, bottom: 5),
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 15, top: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color:
                                 isDefault ?
                                 AppColors.color1 :
                            (addressController.indexval.value.toString() ==
                                index.toString())
                                ? AppColors.color1
                                : Colors.transparent
                            ),
                            color: AppColors.WHITE,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            // if (isDefault)
                            //   Padding(
                            //     padding: const EdgeInsets.only(left: 15),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Flexible(
                            //           child:
                            //               AppTextWidgets.boldTextWithColor(
                            //                   text: 'default'.tr,
                            //                   size: 18,
                            //                   color: AppColors.BLACK),
                            //         ),
                            //         Row(
                            //           children: [
                            //             InkWell(
                            //               onTap: () async {
                            //                 addressController.performUpdate(
                            //                     index: index);
                            //               },
                            //               child: Container(
                            //                   height: 40,
                            //                   width: 45,
                            //                   alignment: Alignment.center,
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(
                            //                             15),
                            //                     gradient:
                            //                         const LinearGradient(
                            //                       colors: [
                            //                         AppColors.color1,
                            //                         AppColors.color2,
                            //                       ],
                            //                       begin:
                            //                           Alignment.bottomLeft,
                            //                       end: Alignment.topRight,
                            //                     ),
                            //                   ),
                            //                   child: SizedBox(
                            //                     height: 25,
                            //                     width: 25,
                            //                     child: SvgPicture.asset(
                            //                       AppImages.editIconSvg,
                            //                     ),
                            //                   )),
                            //             ),
                            //             10.ws,
                            //             InkWell(
                            //               onTap: () async {
                            //                 addressController.performDelete(
                            //                     index: index);
                            //               },
                            //               child: Container(
                            //                   height: 40,
                            //                   width: 45,
                            //                   alignment: Alignment.center,
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(
                            //                             15),
                            //                     gradient:
                            //                         const LinearGradient(
                            //                       colors: [
                            //                         AppColors.color1,
                            //                         AppColors.color2,
                            //                       ],
                            //                       begin:
                            //                           Alignment.bottomLeft,
                            //                       end: Alignment.topRight,
                            //                     ),
                            //                   ),
                            //                   child: SizedBox(
                            //                     height: 25,
                            //                     width: 25,
                            //                     child: SvgPicture.asset(
                            //                       AppImages.deleteIconSvg,
                            //                     ),
                            //                   )),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // if (isDefault)
                            //   Padding(
                            //     padding:
                            //         EdgeInsets.only(left: 16, right: 8),
                            //     child: Divider(
                            //       color: AppColors.greyShade6,
                            //     ),
                            //   ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Obx(
                                //   () => Radio(
                                //     value: addressController.aList[index].id
                                //         .toString(),
                                //     groupValue: addressController
                                //         .selectedId.value
                                //         .toString(),
                                //     activeColor: AppColors.BLACK,
                                //     onChanged: (val) {
                                //       addressController.selected =
                                //           addressController.aList[
                                //               addressController.aList
                                //                   .indexWhere((element) =>
                                //                       element.id
                                //                           .toString() ==
                                //                       val)];
                                //       print(addressController.selected);
                                //       addressController.selectedId.value =
                                //           addressController.selected!.id ??
                                //               0;
                                //       addressController.update();
                                //     },
                                //   ),
                                // ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                AppTextWidgets.blackText(
                                                  text:
                                                  '${addressController.aList[index]
                                                      .tag}',
                                                  size: 16,
                                                  color:   (addressController.indexval.value.toString() ==
                                                      index.toString())
                                                      ? AppColors.color1:AppColors.BLACK,
                                                ),
                                                5.ws,
                                                if (isDefault)
                                                  AppTextWidgets.blackText(
                                                    text:
                                                    '(Default)',
                                                    size: 16,
                                                    color:   (addressController.indexval.value.toString() ==
                                                        index.toString())
                                                        ? AppColors.color1:AppColors.BLACK,
                                                  ),
                                              ],
                                            ),
                                          ),

                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  addressController
                                                      .performUpdate(
                                                      index: index);
                                                },
                                                child: Container(
                                                    height: 40,
                                                    width: 30,
                                                    alignment:
                                                    Alignment.center,
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          15),
                                                      // gradient:
                                                      // const LinearGradient(
                                                      //   colors: [
                                                      //     AppColors
                                                      //         .color1,
                                                      //     AppColors
                                                      //         .color2,
                                                      //   ],
                                                      //   begin: Alignment
                                                      //       .bottomLeft,
                                                      //   end: Alignment
                                                      //       .topRight,
                                                      // ),
                                                    ),
                                                    child: SizedBox(
                                                      height: 25,
                                                      width: 25,
                                                      child: Image
                                                          .asset(
                                                        AppImages
                                                            .editicon,
                                                        color: AppColors.reportTextColor,
                                                      ),
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  addressController
                                                      .performDelete(
                                                      index: index);
                                                },
                                                child: Container(
                                                    height: 40,
                                                    width: 35,
                                                    alignment:
                                                    Alignment.center,
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          15),
                                                      // gradient:
                                                      // const LinearGradient(
                                                      //   colors: [
                                                      //     AppColors
                                                      //         .color1,
                                                      //     AppColors
                                                      //         .color2,
                                                      //   ],
                                                      //   begin: Alignment
                                                      //       .bottomLeft,
                                                      //   end: Alignment
                                                      //       .topRight,
                                                      // ),
                                                    ),
                                                    child: SizedBox(
                                                      height: 35,
                                                      width: 35,
                                                      child: Image
                                                          .asset(
                                                        AppImages
                                                            .deleteicon,
                                                        color: AppColors.RED,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      5.hs,
                                      AppTextWidgets.regularTextWithColor(
                                        text:
                                        '${addressController.aList[index].address}',
                                        color: AppColors.BLACK,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          )
        ],
      )
          : const Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
