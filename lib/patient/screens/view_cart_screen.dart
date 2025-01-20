import 'package:videocalling_medical/patient/utils/patient_imports.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';

class ViewCartScreen extends GetView<ViewCartController> {
  final ViewCartController viewCartController = Get.put(ViewCartController());

  @override
  Widget build(BuildContext context) {

    final String tax = "${StorageService.readData(
        key: LocalStorageKeys
            .tax) ??
        "0"}" ?? "0";
    final String deliveryCharge ="${StorageService.readData(
        key: LocalStorageKeys
            .deliverycharges) ??
        "0"}" ?? "0";
    // print('Received tax: $tax');
    // print('Received deliveryCharge: $deliveryCharge');


    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        flexibleSpace: CustomAppBar(
          title: 'cart'.tr,
          textStyle: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: 22,
            fontFamily: AppFontStyleTextStrings.semiBold,
          ),
          isBackArrow: true,
          onPressed: () {
            // print(viewCartController.cartList.length);
            Get.back(result: viewCartController.cartList.length);
            // Get.back();
          },
        ),
        leading: Container(),
      ),
      body: Obx(() => viewCartController.isDataLoaded.value
          ? viewCartController.cartList.isEmpty
              ? Container(
                  height: Get.height * 0.3,
                  alignment: Alignment.center,
                  child: AppTextWidgets.regularText(
                    text: 'cart_empty'.tr,
                    color: AppColors.BLACK,
                    size: 18,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewCartController.cartList.length,
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                              color: AppColors.WHITE,
                              // border: Border.all(
                              //   color: AppColors.iconColor,
                              // ),
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
                                    width: 105,
                                    height: 110,
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
                                      child: viewCartController.cartList[index].image ==
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
                                                "${Apis.medicineImage}${viewCartController.cartList[index].image}",
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
                                              child: Text(
                                                viewCartController.cartList[index].name ??
                                                    "",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      AppFontStyleTextStrings.medium,
                                                  color: AppColors.reportTextColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),

                                            Text(
                                              // "${viewCartController.cartList[index].price ?? "0"}$CURRENCY",
                                              (double.parse(viewCartController
                                                          .cartList[index].price
                                                          .toString())
                                                      .toStringAsFixed(1)) +
                                                  CURRENCY,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontFamily:
                                                    AppFontStyleTextStrings.regular,
                                                fontSize: 14,
                                                color: AppColors.reportTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      viewCartController.qtyList[index]++;
                                                      viewCartController.calculatePrice();
                                                      viewCartController.update();
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 35,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)),
                                                          border: Border.all(
                                                              color:
                                                                  AppColors.greyShade4),
                                                          color: AppColors.greyShade1),
                                                      child: SizedBox(
                                                        height: 25,
                                                        width: 25,
                                                        child: SvgPicture.asset(
                                                          AppImages.plusSvg,
                                                          color:
                                                              AppColors.reportTextColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Obx(
                                                      () => Text(
                                                        "${viewCartController.qtyList[index].toString().padLeft(2, '0')}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              AppFontStyleTextStrings
                                                                  .medium,
                                                          color:
                                                              AppColors.reportTextColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      if (viewCartController
                                                              .qtyList[index] !=
                                                          1) {
                                                        viewCartController
                                                            .qtyList[index]--;
                                                        viewCartController
                                                            .calculatePrice();
                                                        viewCartController.update();
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 35,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)),
                                                          border: Border.all(
                                                              color:
                                                                  AppColors.greyShade4),
                                                          color: AppColors.greyShade1),
                                                      child: SvgPicture.asset(
                                                        AppImages.minusSvg,
                                                        color: AppColors.reportTextColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                int id = await Get.find<DBHelperCart>()
                                                    .delete(
                                                        id: viewCartController
                                                                .cartList[index].id ??
                                                            0);
                                                print(id);
                                                if (id == 1) {


                                                  if (index >= 0 && index < viewCartController.cartList.length) {
                                                    print(index);
                                                    print("Index out of range212323123231");
                                                    viewCartController.cartList.removeAt(index);
                                                    await viewCartController.calculatePrice();

                                                  } else {
                                                    print("Index out of range");
                                                  }

                                                  print("qty list ${viewCartController.qtyList}");
                                                  print("index list ${index}");

                                                  if (index >= 0 && index < viewCartController.cartList.length) {
                                                    viewCartController.qtyList.removeAt(index);
                                                    await viewCartController.calculatePrice();

                                                  } else {
                                                    print("Index out of range");
                                                  }
                                                  print(viewCartController.cartList.length);
                                                  print(viewCartController.qtyList.length);

                                                  if (viewCartController
                                                      .cartList.isNotEmpty) {
                                                    await viewCartController.calculatePrice();
                                                  }
                                                  viewCartController.update();
                                                }
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                    border: Border.all(
                                                        color: AppColors.greyShade4),
                                                    color: AppColors.greyShade1),
                                                child: SizedBox(
                                                  height: 35,
                                                  width: 35,
                                                  child: Image.asset(
                                                    AppImages.deleteicon,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                5.ws,

                                // Column(
                                //   children: [
                                //     Text(
                                //       // "${viewCartController.cartList[index].price ?? "0"}$CURRENCY",
                                //       (double.parse(
                                //           viewCartController.cartList[index].price.toString())
                                //           .toStringAsFixed(
                                //           1)) +
                                //           CURRENCY,
                                //       maxLines: 2,
                                //       style: TextStyle(
                                //         fontFamily:
                                //         AppFontStyleTextStrings.regular,
                                //         fontSize: 14,
                                //         color: AppColors.reportTextColor,
                                //       ),
                                //     ),
                                //     const SizedBox(height: 10),
                                //
                                //     GestureDetector(
                                //       onTap: () async {
                                //         int id = await Get.find<DBHelperCart>()
                                //             .delete(
                                //                 id: viewCartController
                                //                         .cartList[index].id ??
                                //                     0);
                                //         if (id == 1) {
                                //           viewCartController.cartList
                                //               .removeAt(index);
                                //           viewCartController.qtyList
                                //               .removeAt(index);
                                //           if (viewCartController
                                //               .cartList.isNotEmpty) {
                                //             viewCartController.calculatePrice();
                                //           }
                                //           viewCartController.update();
                                //         }
                                //       },
                                //       child: Container(
                                //         height: 35,
                                //         width: 35,
                                //         alignment: Alignment.center,
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //             BorderRadius.all(Radius.circular(10)
                                //             ),
                                //             border: Border.all(color: AppColors.greyShade4),
                                //             color: AppColors.greyShade1
                                //         ),
                                //         child: SizedBox(
                                //           height: 35,
                                //           width: 35,
                                //           child: Image.asset(
                                //             AppImages.deleteicon,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(
                                  width: 12,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 18,right: 18),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${'total_mrp'.tr} ",
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: AppFontStyleTextStrings.regular,
                                  fontSize: 14,
                                  color: AppColors.grey,
                                ),
                              ),
                              Spacer(),
                              Obx(
                                () => Text(
                                  "${(viewCartController.total.value % 2 == 0
                                      ? viewCartController.total.value.toStringAsFixed(1)
                                      : viewCartController.total.value.toStringAsFixed(1))
                                  }$CURRENCY",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: AppFontStyleTextStrings.regular,
                                    fontSize: 14,
                                    color: AppColors.BLACK,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          5.hs,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${'delivery_charges'.tr} ",
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: AppFontStyleTextStrings.regular,
                                  fontSize: 14,
                                  color: AppColors.grey,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "+${(double.parse(deliveryCharge) ?? 0.0).toStringAsFixed(1)}$CURRENCY",
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: AppFontStyleTextStrings.regular,
                                  fontSize: 14,
                                  color: AppColors.BLACK,
                                ),
                              ),
                            ],
                          ),
                          5.hs,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${'tax'.tr} ",
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: AppFontStyleTextStrings.regular,
                                  fontSize: 14,
                                  color: AppColors.grey,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "+${(double.parse(tax) ?? 0.0).toStringAsFixed(1)}%",
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: AppFontStyleTextStrings.regular,
                                  fontSize: 14,
                                  color: AppColors.BLACK,
                                ),
                              ),
                            ],
                          ),
                          5.hs,
                          Divider(
                            thickness: 1,
                          ),
                          5.hs,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${'total_price1'.tr}",
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: AppFontStyleTextStrings.semiBold,
                                  fontSize: 19,
                                  color: AppColors.reportTextColor,
                                ),
                              ),
                              Spacer(),
                              Obx(() {
                                return Text(
                                  "${(((double.parse(viewCartController.total.value.toString()) % 2 == 0
                                      ? double.parse(viewCartController.total.value.toString()).toInt()
                                      : double.parse(viewCartController.total.value.toString()))
                                      + double.parse(deliveryCharge))
                                      + (((double.parse(viewCartController.total.value.toString()) % 2 == 0
                                          ? double.parse(viewCartController.total.value.toString()).toInt()
                                          : double.parse(viewCartController.total.value.toString()))
                                          + double.parse(deliveryCharge)) * double.parse(tax)) / 100).toStringAsFixed(1)}$CURRENCY",

                                  // 25.0000.toStringAsFixed(2),
                                  // "${result.value}",
                                //   "${viewCartController.total.value % 2 == 0 ? viewCartController.total.value.toString().split(".").first : viewCartController.total.value}$CURRENCY",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: AppFontStyleTextStrings.regular,
                                    fontSize: 19,
                                    color: AppColors.color1,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 55,
                        margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                        child: InkWell(
                          onTap: () async {
                            print(viewCartController.qtyList);

                            if (StorageService.readData(key: LocalStorageKeys.isLoggedIn) ??
                                false) {
                              await Get.toNamed(Routes.medicineOrderScreen, arguments: {
                                'type': 1,
                                'total_medicine': viewCartController.cartList.length,
                                'total_price': (double.parse(viewCartController.total.value % 2 == 0 ?
                                viewCartController.total.value.toString().split(".").
                                first : viewCartController.total.value.toString()) + int.parse(deliveryCharge))
                                    + (((double.parse(viewCartController.total.value % 2 == 0 ?
                                    viewCartController.total.value.toString().split(".").first
                                        : viewCartController.total.value.toString())
                                        + int.parse(deliveryCharge)) * int.parse(tax)) / 100),

                                "mrp":"${(viewCartController.total.value % 2 == 0
                                    ? viewCartController.total.value.toStringAsFixed(1)
                                    : viewCartController.total.value.toStringAsFixed(1))
                                }",
                                "tax":"${(double.parse(tax) ?? 0.0).toStringAsFixed(1)}",
                                "delivery":"${(double.parse(deliveryCharge) ?? 0.0).toStringAsFixed(1)}",
                                "qlist":viewCartController.qtyList,
                              });
                              Get.delete<ViewCartController>();
                            }
                            else {
                              Get.toNamed(Routes.loginUserScreen, arguments: {
                                "isBack": true,
                              })?.then((value) async {
                                if (value ?? false) {
                                  viewCartController.checkLogin();
                                  await Get.toNamed(Routes.medicineOrderScreen, arguments: {
                                    'type': 1,
                                    'total_medicine': viewCartController.cartList.length,
                                    'total_price': (int.parse(viewCartController.total.value % 2 == 0 ?
                                    viewCartController.total.value.toString().split(".").
                                    first : viewCartController.total.value.toString()) + int.parse(deliveryCharge))
                                        + (((int.parse(viewCartController.total.value % 2 == 0 ?
                                        viewCartController.total.value.toString().split(".").first
                                            : viewCartController.total.value.toString())
                                            + int.parse(deliveryCharge)) * int.parse(tax)) / 100),
                                    "mrp":"${(viewCartController.total.value % 2 == 0
                                        ? viewCartController.total.value.toStringAsFixed(1)
                                        : viewCartController.total.value.toStringAsFixed(1))
                                    }",
                                    "tax":"${(double.parse(tax) ?? 0.0).toStringAsFixed(1)}",
                                    "delivery":"${(double.parse(deliveryCharge) ?? 0.0).toStringAsFixed(1)}",
                                  "qlist":viewCartController.qtyList,

                                  });
                                  Get.delete<ViewCartController>();
                                }
                              });
                            }
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
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
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Center(
                                  child:
                                  // PharmacyMedicineController.isLoggedIn.value
                                  //     ?
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        child: Obx(() {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              AppTextWidgets.mediumText(
                                                text:
                                                "${(((double.parse(viewCartController.total.value.toString()) % 2 == 0
                                                    ? double.parse(viewCartController.total.value.toString()).toInt()
                                                    : double.parse(viewCartController.total.value.toString()))
                                                    + double.parse(deliveryCharge))
                                                    + (((double.parse(viewCartController.total.value.toString()) % 2 == 0
                                                        ? double.parse(viewCartController.total.value.toString()).toInt()
                                                        : double.parse(viewCartController.total.value.toString()))
                                                        + double.parse(deliveryCharge)) * double.parse(tax)) / 100).toStringAsFixed(1)}$CURRENCY",
                                                color: AppColors.WHITE,
                                                size: 18,
                                              ),
                                              AppTextWidgets.mediumText(
                                                text: 'total_price1'.tr,
                                                color: AppColors.WHITE,
                                                size: 9,
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                      5.ws,
                                      Container(
                                        height: 70,
                                        child: const VerticalDivider(
                                          color: AppColors.WHITE,
                                          indent: 5,
                                          thickness: 0.5,
                                          endIndent: 5,
                                        ),
                                      ),
                                      3.ws,

                                      Expanded(child:  Obx(
                                            () => Text(
                                          viewCartController.loggedIn.value
                                              ? 'proceed_order'.tr
                                              : 'login_to_proceed_order'.tr,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontFamily: AppFontStyleTextStrings.regular,
                                            color: AppColors.WHITE,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),),

                                      3.ws,
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.WHITE,
                                        size: 16,
                                      ),
                                      12.ws,
                                    ],
                                  )

                                //     : Row(
                                //   mainAxisAlignment:
                                //   MainAxisAlignment.spaceAround,
                                //   children: [
                                //     Row(
                                //       children: [
                                //         Container(
                                //           width: 100,
                                //           decoration: BoxDecoration(
                                //             borderRadius:
                                //             BorderRadius.circular(20),
                                //           ),
                                //           padding:
                                //           const EdgeInsets.fromLTRB(
                                //               20, 5, 0, 5),
                                //           child: Column(
                                //             crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //             children: [
                                //               AppTextWidgets.mediumText(
                                //                 text:
                                //                 "${CURRENCY.trim()}${detailController.doctorDetailsClass!.data!.consultationFee ?? 'not_specified'.tr}",
                                //                 color: AppColors.WHITE,
                                //                 size: 18,
                                //               ),
                                //               AppTextWidgets.mediumText(
                                //                 text:
                                //                 'appointment_fee'.tr,
                                //                 color: AppColors.WHITE,
                                //                 size: 9,
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //         5.ws,
                                //         Container(
                                //           height: 70,
                                //           child: const VerticalDivider(
                                //             color: AppColors.WHITE,
                                //             indent: 5,
                                //             thickness: 0.5,
                                //             endIndent: 5,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //     Expanded(
                                //       child: Padding(
                                //         padding: const EdgeInsets.only(
                                //             right: 12, left: 10),
                                //         child: Text(
                                //           'login_to_book_appointment'.tr,
                                //           textAlign: TextAlign.right,
                                //           maxLines: 1,
                                //           overflow: TextOverflow.ellipsis,
                                //           style: const TextStyle(
                                //             fontFamily:
                                //             AppFontStyleTextStrings
                                //                 .medium,
                                //             color: AppColors.WHITE,
                                //             fontSize: 14,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                )
          : const Center(
              child: CircularProgressIndicator(),
            )),
    );
  }
}
