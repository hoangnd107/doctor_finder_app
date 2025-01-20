import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/screens/prescription_detail_screen.dart';
import 'package:videocalling_medical/patient/screens/report_image_screen.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class UserAppointmentDetailsScreen extends GetView<UserAppointmentDetailsController> {
  final UserAppointmentDetailsController detailsController =
      Get.put(UserAppointmentDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        flexibleSpace: CustomAppBar(
          title: 'appointment'.tr,
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
      body: Obx(
        () => detailsController.isErrorInLoading.value
            ? Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 100,
                        color: AppColors.LIGHT_GREY_TEXT,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'unable_to_load_data'.tr,
                        style: const TextStyle(
                          fontFamily: AppFontStyleTextStrings.regular,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : detailsController.isPharmacy.value
                ?

                ///pharmacy order detail
                detailsController.isLoaded.value
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (1 == index) {
                              return const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: LinearProgressIndicator(),
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.WHITE,
                                      ),
                                      child: Row(
                                        children: [
                                          detailsController.dataList.data!.pharmacyImage
                                                      .toString() !=
                                                  ""
                                              ? Container(
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      // borderRadius: BorderRadius.circular(8),
                                                      // border: Border.all(color: AppColors.greyShade3)
                                                      ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    child: CachedNetworkImage(
                                                      imageUrl: detailsController
                                                          .dataList.data!.pharmacyImage
                                                          .toString(),
                                                      fit: BoxFit.contain,
                                                      placeholder: (context, url) =>
                                                          Container(
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                        child: Image.asset(
                                                          AppImages.tab3dUnselect,
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                      ),
                                                      errorWidget: (context, url, err) =>
                                                          Container(
                                                              color: Theme.of(context)
                                                                  .primaryColorLight,
                                                              child: Image.asset(
                                                                AppImages.tab3dUnselect,
                                                                height: 20,
                                                                width: 20,
                                                              )),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  color:
                                                      Theme.of(context).primaryColorLight,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(20.0),
                                                    child: Image.asset(
                                                      AppImages.tab3dUnselect,
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                  )),
                                          10.ws,
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      AppTextWidgets.semiBoldText(
                                                        text: detailsController.dataList
                                                                .data!.pharmacyName
                                                                .toString() ??
                                                            "",
                                                        color: AppColors.BLACK,
                                                        size: 13,
                                                      ),
                                                      2.hs,
                                                      Text(
                                                        detailsController.dataList.data!
                                                            .pharmacyPhoneno
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .apply(
                                                              fontWeightDelta: 2,
                                                              color: Theme.of(context)
                                                                  .primaryColorDark
                                                                  .withOpacity(0.5),
                                                            ),
                                                      ),
                                                      2.hs,
                                                      Container(
                                                        padding: const EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(15),
                                                            color: Theme.of(context)
                                                                .primaryColorLight),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Image.asset(
                                                              AppImages.timeIcon,
                                                              height: 13,
                                                              width: 13,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              detailsController
                                                                          .dataList
                                                                          .data!
                                                                          .status! ==
                                                                      0
                                                                  ? 'order_status_0'.tr
                                                                  : detailsController
                                                                              .dataList
                                                                              .data!
                                                                              .status! ==
                                                                          1
                                                                      ? 'order_status_1'
                                                                          .tr
                                                                      : detailsController
                                                                                  .dataList
                                                                                  .data!
                                                                                  .status! ==
                                                                              2
                                                                          ? 'order_status_2'
                                                                              .tr
                                                                          : detailsController
                                                                                      .dataList
                                                                                      .data!
                                                                                      .status!! ==
                                                                                  3
                                                                              ? 'order_status_3'
                                                                                  .tr
                                                                              : detailsController.dataList.data!.status! ==
                                                                                      4
                                                                                  ? 'order_status_4'
                                                                                      .tr
                                                                                  : detailsController.dataList.data!.status! ==
                                                                                          5
                                                                                      ? 'order_status_5'.tr
                                                                                      : detailsController.dataList.data!.status! == 6
                                                                                          ? 'order_status_6'.tr
                                                                                          : detailsController.dataList.data!.status! == 7
                                                                                              ? 'order_status_7'.tr
                                                                                              : detailsController.dataList.data!.status! == 8
                                                                                                  ? 'order_status_8'.tr
                                                                                                  : detailsController.dataList.data!.status! == 8
                                                                                                      ? 'order_status_8'.tr
                                                                                                      : 'order_status_9'.tr,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .apply(
                                                                    fontSizeDelta: 0.5,
                                                                    fontWeightDelta: 2,
                                                                  ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          5.ws,
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Image.asset(
                                                AppImages.calender,
                                                height: 17,
                                                width: 17,
                                              ),
                                              5.hs,
                                              AppTextWidgets.regularText(
                                                text:
                                                    "${detailsController.dataList.data!.createdAt?.substring(8, 10)}"
                                                    "${detailsController.dataList.data!.createdAt?.substring(4, 8)}"
                                                    "${detailsController.dataList.data!.createdAt?.substring(0, 4)}",
                                                color: AppColors.LIGHT_GREY_TEXT,
                                                size: 11,
                                              ),
                                              Row(
                                                children: [
                                                  AppTextWidgets.regularText(
                                                    text:
                                                        "${detailsController.dataList.data!.createdAt?.substring(11, 16)}",
                                                    color: AppColors.BLACK,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    padding: const EdgeInsets.all(8),
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'delivery_address'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .apply(
                                                            fontWeightDelta: 1,
                                                            fontSizeDelta: 1.5),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    detailsController
                                                        .dataList.data!.address!
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .apply(
                                                          fontWeightDelta: 2,
                                                          color: Theme.of(context)
                                                              .primaryColorDark
                                                              .withOpacity(0.5),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 70,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'email_address'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .apply(
                                                          fontWeightDelta: 1,
                                                          fontSizeDelta: 1.5),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  detailsController
                                                      .dataList.data!.pharmacyEmail!
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .apply(
                                                        fontWeightDelta: 2,
                                                        color: Theme.of(context)
                                                            .primaryColorDark
                                                            .withOpacity(0.5),
                                                      ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                ///add email detail
                                                launch(Uri(
                                                  scheme: 'mailto',
                                                  path: detailsController
                                                      .dataList.data!.pharmacyEmail!
                                                      .toString(),
                                                ).toString());
                                              },
                                              child: Image.asset(
                                                AppImages.emailIcon,
                                                height: 45,
                                                width: 45,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'description'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .apply(
                                                            fontWeightDelta: 1,
                                                            fontSizeDelta: 1.5),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    detailsController
                                                        .dataList.data!.message!
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .apply(
                                                          fontWeightDelta: 2,
                                                          color: Theme.of(context)
                                                              .primaryColorDark
                                                              .withOpacity(0.5),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  if (detailsController.isprescription == false)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, top: 12,right: 12),
                                      child: AppTextWidgets.mediumText(
                                        text: "medicine_detail".tr,
                                        color: AppColors.BLACK,
                                        size: 16,
                                      ),
                                    ),

                                  if (detailsController.isprescription == true)
                                    if (detailsController.dataList.data!.status! == 5)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, top: 12, right: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize.min,
                                                              children: [
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: Text(
                                                                    'pharmacy_price_detail'
                                                                        .tr,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyLarge!
                                                                        .apply(
                                                                            fontWeightDelta:
                                                                                1,
                                                                            // color: Theme.of(context)
                                                                            //     .primaryColorDark
                                                                            //     .withOpacity(0.6),
                                                                            fontSizeDelta:
                                                                                1.5),
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                // Text(
                                                                //   detailsController
                                                                //       .dataList.data!.total!
                                                                //       .toString() + CURRENCY,
                                                                //   style: Theme.of(context)
                                                                //       .textTheme
                                                                //       .bodyMedium!
                                                                //       .apply(
                                                                //     fontWeightDelta: 2,
                                                                //     fontSizeDelta: 8,
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                      left: 0, right: 0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${'total_mrp'.tr} ",
                                                                        maxLines: 1,
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              AppFontStyleTextStrings
                                                                                  .regular,
                                                                          fontSize: 14,
                                                                          color: AppColors
                                                                              .grey,
                                                                        ),
                                                                      ),
                                                                      Spacer(),
                                                                      Text(
                                                                          '${detailsController.dataList.data!.prescriptionPrice.toStringAsFixed(1) ?? 0.toStringAsFixed(1)}$CURRENCY',
                                                                          maxLines: 1,
                                                                          style: Theme.of(
                                                                                  context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .apply(
                                                                                fontWeightDelta:
                                                                                    2,
                                                                                fontSizeDelta:
                                                                                    2,
                                                                              ))
                                                                    ],
                                                                  ),
                                                                  5.hs,
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${'delivery_charges'.tr} ",
                                                                        maxLines: 1,
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              AppFontStyleTextStrings
                                                                                  .regular,
                                                                          fontSize: 14,
                                                                          color: AppColors
                                                                              .grey,
                                                                        ),
                                                                      ),
                                                                      Spacer(),
                                                                      Text(
                                                                          '+${detailsController.dataList.data!.deliveryCharge.toStringAsFixed(1) ?? 0.toStringAsFixed(1)}$CURRENCY',
                                                                          maxLines: 1,
                                                                          style: Theme.of(
                                                                                  context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .apply(
                                                                                fontWeightDelta:
                                                                                    2,
                                                                                fontSizeDelta:
                                                                                    2,
                                                                              )),
                                                                    ],
                                                                  ),
                                                                  5.hs,
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${'tax'.tr} ",
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              AppFontStyleTextStrings
                                                                                  .regular,
                                                                          fontSize: 14,
                                                                          color: AppColors
                                                                              .grey,
                                                                        ),
                                                                      ),
                                                                      Spacer(),
                                                                      Text(
                                                                          '+${detailsController.dataList.data!.taxPr.toStringAsFixed(1) ?? 0.0.toStringAsFixed(1)}%',
                                                                          style: Theme.of(
                                                                                  context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .apply(
                                                                                fontWeightDelta:
                                                                                    2,
                                                                                fontSizeDelta:
                                                                                    2,
                                                                              )),
                                                                    ],
                                                                  ),
                                                                  5.hs,
                                                                  Divider(
                                                                    thickness: 1,
                                                                  ),
                                                                  5.hs,
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${'total_price1'.tr}",
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              AppFontStyleTextStrings
                                                                                  .semiBold,
                                                                          fontSize: 19,
                                                                          color: AppColors
                                                                              .reportTextColor,
                                                                        ),
                                                                      ),
                                                                      Spacer(),
                                                                      Text(
                                                                        '${detailsController.dataList.data!.total.toStringAsFixed(1)}$CURRENCY',
                                                                        // '${detailsController.orderDetail.data!.total}$CURRENCY',
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              AppFontStyleTextStrings
                                                                                  .regular,
                                                                          fontSize: 19,
                                                                          color: AppColors
                                                                              .color1,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  3.hs,
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: InkWell(
                                                                  onTap: () async {
                                                                    detailsController
                                                                        .changeOrderStatus(
                                                                            4);
                                                                  },
                                                                  child: Container(
                                                                    alignment:
                                                                        Alignment.center,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            gradient:
                                                                                const LinearGradient(
                                                                              colors: [
                                                                                AppColors
                                                                                    .color1,
                                                                                AppColors
                                                                                    .color2,
                                                                              ],
                                                                              begin: Alignment
                                                                                  .bottomLeft,
                                                                              end: Alignment
                                                                                  .topRight,
                                                                            ),
                                                                            // border: Border.all(width: 2,
                                                                            //   color: AppColors.greyShade3,
                                                                            // ),
                                                                            borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                        15)),
                                                                    height: 40,
                                                                    width: 54,
                                                                    child: Text(
                                                                      'order_status_2'.tr,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .apply(
                                                                              fontWeightDelta:
                                                                                  1,
                                                                              fontSizeDelta:
                                                                                  1.5),
                                                                    ),
                                                                  )),
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Expanded(
                                                              child: InkWell(
                                                                  onTap: () async {
                                                                    detailsController
                                                                        .changeOrderStatus(
                                                                            6);
                                                                  },
                                                                  child: Container(
                                                                    alignment:
                                                                        Alignment.center,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            // border: Border.all(width: 2,
                                                                            //   color: AppColors.greyShade3,
                                                                            // ),
                                                                            gradient:
                                                                                const LinearGradient(
                                                                              colors: [
                                                                                AppColors
                                                                                    .color1,
                                                                                AppColors
                                                                                    .color2,
                                                                              ],
                                                                              begin: Alignment
                                                                                  .bottomLeft,
                                                                              end: Alignment
                                                                                  .topRight,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                        15)),
                                                                    height: 40,
                                                                    width: 54,
                                                                    child: Text(
                                                                      'order_status_2'.tr,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .apply(
                                                                              fontWeightDelta:
                                                                                  1,
                                                                              fontSizeDelta:
                                                                                  1.5),
                                                                    ),
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                  if (detailsController.isprescription == true)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, top: 12,right: 12),
                                      child: AppTextWidgets.mediumText(
                                        text: "prescription_detail".tr,
                                        color: AppColors.BLACK,
                                        size: 16,
                                      ),
                                    ),

                                  ///medicine screen detail
                                  if (detailsController.isprescription.value == false)
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.WHITE,
                                        ),
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index2) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  detailsController
                                                              .dataList
                                                              .data!
                                                              .medicine![index2]
                                                              .medicineImg
                                                              .toString() !=
                                                          ""
                                                      ? Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                              // borderRadius: BorderRadius.circular(8),
                                                              // border: Border.all(color: AppColors.greyShade3)
                                                              ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(8),
                                                            child: CachedNetworkImage(
                                                              imageUrl: detailsController
                                                                  .dataList
                                                                  .data!
                                                                  .medicine![index2]
                                                                  .medicineImg
                                                                  .toString(),
                                                              fit: BoxFit.cover,
                                                              placeholder:
                                                                  (context, url) =>
                                                                      Container(
                                                                color: Theme.of(context)
                                                                    .primaryColorLight,
                                                                child: Image.asset(
                                                                  AppImages.medicine1,
                                                                  height: 20,
                                                                  width: 20,
                                                                ),
                                                              ),
                                                              errorWidget: (context, url,
                                                                      err) =>
                                                                  Container(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight,
                                                                      child: Image.asset(
                                                                        AppImages
                                                                            .medicine1,
                                                                        height: 20,
                                                                        width: 20,
                                                                      )),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(8),
                                                            color: Theme.of(context)
                                                                .primaryColorLight,
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(
                                                                20.0),
                                                            child: Image.asset(
                                                              AppImages.medicine1,
                                                              height: 30,
                                                              width: 30,
                                                            ),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "${detailsController.dataList.data!.medicine![index2].name.toString()}",
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        AppFontStyleTextStrings
                                                                            .regular,
                                                                    fontSize: 14,
                                                                    color:
                                                                        AppColors.BLACK),
                                                                overflow:
                                                                    TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            AppTextWidgets.regularText(
                                                              text: 'quantity_col'.tr,
                                                              color: AppColors
                                                                  .LIGHT_GREY_TEXT,
                                                              size: 14,
                                                            ),
                                                            AppTextWidgets.regularText(
                                                              text:
                                                                  '${detailsController.dataList.data!.medicine![index2].qty.toString() ?? ""}',
                                                              color: AppColors.BLACK,
                                                              size: 14,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            const Spacer(),
                                                            AppTextWidgets.regularText(
                                                              text: "price_col".tr,
                                                              color: AppColors
                                                                  .LIGHT_GREY_TEXT,
                                                              size: 14,
                                                            ),
                                                            AppTextWidgets.regularText(
                                                              text:
                                                                  "${detailsController.dataList.data!.medicine![index2].price.toStringAsFixed(1) ?? ""}$CURRENCY",
                                                              color: AppColors.BLACK,
                                                              size: 14,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            separatorBuilder: (context, index2) {
                                              return SizedBox(
                                                height: 20,
                                                child: Divider(
                                                  color: AppColors.LIGHT_GREY_TEXT,
                                                  thickness: 1,
                                                ),
                                              );
                                            },
                                            itemCount: detailsController
                                                .dataList.data!.medicine!.length),
                                      ),
                                    ),

                                  if (detailsController.isprescription.value == false)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18, right: 18),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${'total_mrp'.tr} ",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
                                                    fontSize: 14,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '${detailsController.dataList.data!.subtotal}$CURRENCY',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
                                                    fontSize: 14,
                                                    color: AppColors.BLACK,
                                                  ),
                                                )
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
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
                                                    fontSize: 14,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  // delivery_charge
                                                  detailsController.dataList.data!
                                                              .deliveryCharge !=
                                                          null
                                                      ? '+${detailsController.dataList.data!.deliveryCharge.toStringAsFixed(1)}$CURRENCY'
                                                      : "+0.0$CURRENCY",

                                                  // "+${(double.parse(deliveryCharge) ?? 0.0).toStringAsFixed(1)}$CURRENCY",
                                                  // '',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
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
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
                                                    fontSize: 14,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  detailsController
                                                              .dataList.data!.taxPr !=
                                                          null
                                                      ? '+${detailsController.dataList.data!.taxPr.toStringAsFixed(1)}%'
                                                      : "+0.0%",

                                                  // "+${(double.parse(tax) ?? 0.0).toStringAsFixed(1)}%",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
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
                                                    fontFamily:
                                                        AppFontStyleTextStrings.semiBold,
                                                    fontSize: 19,
                                                    color: AppColors.reportTextColor,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '${detailsController.dataList.data!.total}$CURRENCY',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
                                                    fontSize: 19,
                                                    color: AppColors.color1,
                                                  ),
                                                )
                                              ],
                                            ),
                                            15.hs,
                                          ],
                                        ),
                                      ),
                                    ),

                                  ///prescription screen detail
                                  if (detailsController.isprescription.value == true)
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(PrescriptionDetailScreen(), arguments: {
                                            'url': detailsController
                                                .dataList.data!.prescription!
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              imageUrl: Apis.prescription +
                                                  detailsController
                                                      .dataList.data!.prescription!,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Container(
                                                color:
                                                    Theme.of(context).primaryColorLight,
                                                child: Image.asset(
                                                  AppImages.tab3dUnselect,
                                                ),
                                              ),
                                              errorWidget: (context, url, err) =>
                                                  Container(
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                      child: Image.asset(
                                                        AppImages.tab3dUnselect,
                                                      )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  if (detailsController.isprescription.value == true &&
                                          detailsController.dataList.data!.status! == 4 ||
                                      detailsController.dataList.data!.status! == 7 ||
                                      detailsController.dataList.data!.status!
                                              .toString() ==
                                          "3" ||
                                      detailsController.dataList.data!.status! == 8)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18, right: 18),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${'total_mrp'.tr} ",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
                                                    fontSize: 14,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  detailsController.dataList.data!
                                                      .prescriptionPrice !=
                                                      null
                                                  ?'${detailsController.dataList.data!.prescriptionPrice.toStringAsFixed(1)}'
                                                    :'0.0$CURRENCY',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
                                                    fontSize: 14,
                                                    color: AppColors.BLACK,
                                                  ),
                                                )
                                              ],
                                            ),
                                            5.hs,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${'delivery_charges'.tr} ",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
                                                    fontSize: 14,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  detailsController.dataList.data!
                                                              .deliveryCharge !=
                                                          null
                                                      ? '+${detailsController.dataList.data!.deliveryCharge.toStringAsFixed(1)}$CURRENCY'
                                                      : "+0.0$CURRENCY",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
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
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
                                                    fontSize: 14,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  detailsController
                                                              .dataList.data!.taxPr !=
                                                          null
                                                      ? '+${detailsController.dataList.data!.taxPr.toStringAsFixed(1)}%'
                                                      : "+0.0%",

                                                  // "+${(double.parse(tax) ?? 0.0).toStringAsFixed(1)}%",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
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
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.semiBold,
                                                    fontSize: 19,
                                                    color: AppColors.reportTextColor,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '${detailsController.dataList.data!.total.toStringAsFixed(1)}$CURRENCY',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFontStyleTextStrings.regular,
                                                    fontSize: 19,
                                                    color: AppColors.color1,
                                                  ),
                                                )
                                              ],
                                            ),
                                            15.hs,
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }
                          },
                        ),
                      )
                    : Container()
                :

                ///doctor appointment detail
                FutureBuilder(
                    future: detailsController.getAppointmentDetails,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(child: CircularProgressIndicator()));
                      } else if (snapshot.connectionState == ConnectionState.none) {
                        return Container();
                      } else {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: detailsController
                                          .doctorAppointmentDetailsClass!
                                          .data!
                                          .doctorImage
                                          .toString(),
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        color: Theme.of(context).primaryColorLight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Image.asset(
                                            AppImages.tab3dUnselect,
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, err) => Container(
                                          color: Theme.of(context).primaryColorLight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Image.asset(
                                              AppImages.tab3dUnselect,
                                              height: 20,
                                              width: 20,
                                            ),
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                detailsController
                                                    .doctorAppointmentDetailsClass!
                                                    .data!
                                                    .doctorName!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .apply(
                                                        fontWeightDelta: 5,
                                                        fontSizeDelta: 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                        detailsController.doctorSpeciality.isEmpty
                                            ? const SizedBox()
                                            : Text(
                                                detailsController.doctorSpeciality.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!,
                                              ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Theme.of(context).primaryColorLight),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                AppImages.timeIcon,
                                                height: 13,
                                                width: 13,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                detailsController
                                                            .doctorAppointmentDetailsClass!
                                                            .data!
                                                            .status! ==
                                                        0
                                                    ? 'appointment_status_1'.tr
                                                    : detailsController
                                                                .doctorAppointmentDetailsClass!
                                                                .data!
                                                                .status! ==
                                                            1
                                                        ? 'appointment_status_2'.tr
                                                        : detailsController
                                                                    .doctorAppointmentDetailsClass!
                                                                    .data!
                                                                    .status! ==
                                                                2
                                                            ? 'appointment_status_3'.tr
                                                            : detailsController
                                                                        .doctorAppointmentDetailsClass!
                                                                        .data!
                                                                        .status! ==
                                                                    3
                                                                ? 'appointment_status_4'
                                                                    .tr
                                                                : detailsController
                                                                            .doctorAppointmentDetailsClass!
                                                                            .data!
                                                                            .status! ==
                                                                        4
                                                                    ? 'appointment_status_5'
                                                                        .tr
                                                                    : 'appointment_status_6'
                                                                        .tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .apply(
                                                      fontSizeDelta: 0.5,
                                                      fontWeightDelta: 2,
                                                    ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        AppImages.calender,
                                        height: 17,
                                        width: 17,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${detailsController.doctorAppointmentDetailsClass!.data!.date.toString().substring(8)}-${detailsController.doctorAppointmentDetailsClass!.data!.date.toString().substring(5, 7)}-${detailsController.doctorAppointmentDetailsClass!.data!.date.toString().substring(0, 4)}",
                                          style: Theme.of(context).textTheme.bodySmall),
                                      Text(
                                          detailsController
                                              .doctorAppointmentDetailsClass!.data!.slot!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .apply(fontWeightDelta: 2)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      padding: const EdgeInsets.all(8),
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'phone_number'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .apply(
                                                            fontWeightDelta: 1,
                                                            fontSizeDelta: 1.5),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    detailsController
                                                        .doctorAppointmentDetailsClass!
                                                        .data!
                                                        .phone!
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .apply(
                                                          fontWeightDelta: 2,
                                                          color: Theme.of(context)
                                                              .primaryColorDark
                                                              .withOpacity(0.5),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launch(
                                                      "tel:${detailsController.doctorAppointmentDetailsClass!.data!.phone!}");
                                                },
                                                child: Image.asset(
                                                  AppImages.phoneIcon,
                                                  height: 45,
                                                  width: 45,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'email_address'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .apply(
                                                            fontWeightDelta: 1,
                                                            fontSizeDelta: 1.5),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    detailsController
                                                        .doctorAppointmentDetailsClass!
                                                        .data!
                                                        .email!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .apply(
                                                          fontWeightDelta: 2,
                                                          color: Theme.of(context)
                                                              .primaryColorDark
                                                              .withOpacity(0.5),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launch(Uri(
                                                    scheme: 'mailto',
                                                    path: detailsController
                                                        .doctorAppointmentDetailsClass!
                                                        .data!
                                                        .email,
                                                  ).toString());
                                                },
                                                child: Image.asset(
                                                  AppImages.emailIcon,
                                                  height: 45,
                                                  width: 45,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'description'.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .apply(
                                                              fontWeightDelta: 1,
                                                              fontSizeDelta: 1.5),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      detailsController
                                                          .doctorAppointmentDetailsClass!
                                                          .data!
                                                          .description!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .apply(
                                                            fontWeightDelta: 2,
                                                            color: Theme.of(context)
                                                                .primaryColorDark
                                                                .withOpacity(0.5),
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    StorageService.writeStringData(
                                                        key: LocalStorageKeys
                                                            .callReceiverImage,
                                                        value: (detailsController
                                                                .doctorAppointmentDetailsClass!
                                                                .data!
                                                                .doctorImage!
                                                                .isNotEmpty
                                                            ? detailsController
                                                                .doctorAppointmentDetailsClass!
                                                                .data!
                                                                .doctorImage!
                                                            : AppImages.defaultDoctor));

                                                    StorageService.writeStringData(
                                                        key: LocalStorageKeys.callerImage,
                                                        value: (detailsController
                                                                .doctorAppointmentDetailsClass!
                                                                .data!
                                                                .userImage!
                                                                .isNotEmpty
                                                            ? detailsController
                                                                .doctorAppointmentDetailsClass!
                                                                .data!
                                                                .userImage!
                                                            : AppImages.defaultUser));

                                                    StorageService.writeStringData(
                                                        key: LocalStorageKeys
                                                            .callReceiverName,
                                                        value: detailsController
                                                                .doctorAppointmentDetailsClass!
                                                                .data!
                                                                .doctorName ??
                                                            '');

                                                    callOptionDialog(
                                                      callId: detailsController
                                                          .doctorAppointmentDetailsClass!
                                                          .data!
                                                          .connectycubeUserId!
                                                          .toInt(),
                                                      uid: int.parse(
                                                          "100${detailsController.doctorAppointmentDetailsClass!.data!.doctorId!.toInt()}"),
                                                    );
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
                                                          borderRadius:
                                                              BorderRadius.circular(15)),
                                                      height: 40,
                                                      width: 45,
                                                      child: const Icon(
                                                        Icons.video_call,
                                                        color: AppColors.WHITE,
                                                      ))),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                  onTap: () async {
                                                    await Get.toNamed(Routes.chatScreen,
                                                        arguments: {
                                                          'userName': detailsController
                                                              .doctorAppointmentDetailsClass!
                                                              .data!
                                                              .doctorName,
                                                          'uid':
                                                              '100${detailsController.doctorId.value}',
                                                          'isUser': false,
                                                        });
                                                    Get.delete<ChatController>();
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
                                                          borderRadius:
                                                              BorderRadius.circular(15)),
                                                      height: 40,
                                                      width: 45,
                                                      child: const Icon(
                                                        Icons.chat,
                                                        color: AppColors.WHITE,
                                                      ))),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      padding: const EdgeInsets.all(8),
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 32,
                                                width: 32,
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    gradient: const LinearGradient(
                                                      colors: [
                                                        AppColors.color1,
                                                        AppColors.color2,
                                                      ],
                                                      begin: Alignment.bottomLeft,
                                                      end: Alignment.topRight,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: SvgPicture.asset(
                                                  AppImages.medicineIcon,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'prescription'.tr,
                                                    style: TextStyle(
                                                      color: AppColors.reportTextColor,
                                                      height: 1,
                                                      fontSize: 16,
                                                      fontFamily: AppFontStyleTextStrings
                                                          .semiBold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    (detailsController
                                                                    .doctorAppointmentDetailsClass!
                                                                    .prescription
                                                                    .toString() ==
                                                                "null" ||
                                                            detailsController
                                                                .doctorAppointmentDetailsClass!
                                                                .prescription!
                                                                .medicine!
                                                                .isEmpty)
                                                        ? 'user_no_prescription_msg'.tr
                                                        : 'user_no_prescription_msg1'.tr,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppFontStyleTextStrings.regular,
                                                      color: AppColors
                                                          .noPrescriptionTextColor,
                                                      height: 1,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                              )),
                                            ],
                                          ),
                                          !(detailsController
                                                          .doctorAppointmentDetailsClass!
                                                          .prescription
                                                          .toString() ==
                                                      "null" ||
                                                  detailsController
                                                      .doctorAppointmentDetailsClass!
                                                      .prescription!
                                                      .medicine!
                                                      .isEmpty)
                                              ? SizedBox(
                                                  height: 25,
                                                  child: Divider(
                                                    color: AppColors.LIGHT_GREY_TEXT,
                                                    thickness: 1,
                                                  ),
                                                )
                                              : const SizedBox(),
                                          (detailsController
                                                          .doctorAppointmentDetailsClass!
                                                          .prescription
                                                          .toString() ==
                                                      "null" ||
                                                  detailsController
                                                      .doctorAppointmentDetailsClass!
                                                      .prescription!
                                                      .medicine!
                                                      .isEmpty)
                                              ? const SizedBox()
                                              : ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context, i) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${detailsController.doctorAppointmentDetailsClass!.prescription!.medicine![i].medicine_name}",
                                                                      maxLines: 2,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              AppFontStyleTextStrings
                                                                                  .regular,
                                                                          fontSize: 14,
                                                                          color: AppColors
                                                                              .BLACK),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  AppTextWidgets
                                                                      .regularText(
                                                                    text:
                                                                        'medicine_param1'
                                                                            .tr,
                                                                    color:
                                                                        AppColors.BLACK,
                                                                    size: 14,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  AppTextWidgets
                                                                      .regularText(
                                                                    text:
                                                                        "${detailsController.doctorAppointmentDetailsClass!.prescription!.medicine![i].type.toString().substring(0, 1).toUpperCase()}${detailsController.doctorAppointmentDetailsClass!.prescription!.medicine![i].type.toString().substring(1).toLowerCase()}",
                                                                    color: AppColors
                                                                        .LIGHT_GREY_TEXT,
                                                                    size: 14,
                                                                  ),
                                                                  const Spacer(),
                                                                  AppTextWidgets
                                                                      .regularText(
                                                                    text:
                                                                        'medicine_param2'
                                                                            .tr,
                                                                    color:
                                                                        AppColors.BLACK,
                                                                    size: 14,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  AppTextWidgets
                                                                      .regularText(
                                                                    text:
                                                                        "${detailsController.doctorAppointmentDetailsClass!.prescription!.medicine![i].dosage}",
                                                                    color: AppColors
                                                                        .LIGHT_GREY_TEXT,
                                                                    size: 14,
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      vertical: 5,
                                                                    ),
                                                                    child: AppTextWidgets
                                                                        .regularText(
                                                                      text:
                                                                          'medicine_param3'
                                                                              .tr,
                                                                      color:
                                                                          AppColors.BLACK,
                                                                      size: 14,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Expanded(
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Wrap(
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment
                                                                                  .start,
                                                                          runSpacing: 15,
                                                                          spacing: 8,
                                                                          children: [
                                                                            for (int j =
                                                                                    0;
                                                                                j <
                                                                                    detailsController
                                                                                        .doctorAppointmentDetailsClass!
                                                                                        .prescription!
                                                                                        .medicine![i]
                                                                                        .time!
                                                                                        .length;
                                                                                j++)
                                                                              Container(
                                                                                alignment:
                                                                                    Alignment
                                                                                        .center,
                                                                                width: 65,
                                                                                decoration:
                                                                                    BoxDecoration(
                                                                                  borderRadius:
                                                                                      BorderRadius.circular(5),
                                                                                  border:
                                                                                      Border.all(
                                                                                    color:
                                                                                        AppColors.color1,
                                                                                  ),
                                                                                ),
                                                                                padding: const EdgeInsets
                                                                                    .symmetric(
                                                                                    horizontal:
                                                                                        8,
                                                                                    vertical:
                                                                                        6),
                                                                                child: AppTextWidgets
                                                                                    .regularText(
                                                                                  text:
                                                                                      "${detailsController.doctorAppointmentDetailsClass!.prescription!.medicine![i].time![j].tTime}",
                                                                                  color: AppColors
                                                                                      .BLACK,
                                                                                  size:
                                                                                      12,
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              AppTextWidgets.regularText(
                                                                text: 'consume_it_days'
                                                                    .trParams({
                                                                  'days':
                                                                      '${detailsController.doctorAppointmentDetailsClass!.prescription!.medicine![i].repeatDays}'
                                                                }),
                                                                color: AppColors
                                                                    .LIGHT_GREY_TEXT,
                                                                size: 14,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder: (context, index) {
                                                    return SizedBox(
                                                      height: 25,
                                                      child: Divider(
                                                        color: AppColors.LIGHT_GREY_TEXT,
                                                        thickness: 1,
                                                      ),
                                                    );
                                                  },
                                                  itemCount: detailsController
                                                      .doctorAppointmentDetailsClass!
                                                      .prescription!
                                                      .medicine!
                                                      .length),
                                          SizedBox(
                                            height: (detailsController
                                                            .doctorAppointmentDetailsClass!
                                                            .prescription
                                                            .toString() ==
                                                        "null" ||
                                                    detailsController
                                                        .doctorAppointmentDetailsClass!
                                                        .prescription!
                                                        .medicine!
                                                        .isEmpty)
                                                ? 0
                                                : 5,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              (detailsController
                                                              .doctorAppointmentDetailsClass!
                                                              .prescription
                                                              .toString() ==
                                                          "null" ||
                                                      detailsController
                                                          .doctorAppointmentDetailsClass!
                                                          .prescription!
                                                          .medicine!
                                                          .isEmpty)
                                                  ? const SizedBox()
                                                  : Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          await Get.toNamed(
                                                              Routes
                                                                  .uAppointmentPdfScreen,
                                                              arguments: {
                                                                'appointmentId':
                                                                    int.parse(
                                                                        detailsController
                                                                            .id),
                                                              });
                                                          Get.delete<
                                                              AppointmentDetailsScreenPdfController>();
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: 50,
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                  horizontal: 2),
                                                          decoration: BoxDecoration(
                                                            gradient:
                                                                const LinearGradient(
                                                              colors: [
                                                                AppColors.color1,
                                                                AppColors.color2,
                                                              ],
                                                              begin: Alignment.bottomLeft,
                                                              end: Alignment.topRight,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    8.71),
                                                          ),
                                                          child: AutoSizeText(
                                                            'download_prescription'.tr,
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    AppFontStyleTextStrings
                                                                        .regular,
                                                                fontSize: 18,
                                                                color: AppColors.WHITE),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                          SizedBox(
                                            height: (detailsController
                                                            .doctorAppointmentDetailsClass!
                                                            .prescription
                                                            .toString() ==
                                                        "null" ||
                                                    detailsController
                                                        .doctorAppointmentDetailsClass!
                                                        .prescription!
                                                        .medicine!
                                                        .isEmpty)
                                                ? 0
                                                : 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      padding: const EdgeInsets.all(8),
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 32,
                                                width: 32,
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .appointmentDetailsReportBgColor,
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: SvgPicture.asset(
                                                  AppImages.reportIcon,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'report'.tr,
                                                    style: TextStyle(
                                                      color: AppColors.reportTextColor,
                                                      height: 1,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          AppFontStyleTextStrings.medium,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    (detailsController
                                                                    .doctorAppointmentDetailsClass!
                                                                    .image
                                                                    ?.length ??
                                                                0) ==
                                                            0
                                                        ? 'user_no_report_msg'.tr
                                                        : 'user_no_report_msg1'.tr,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppFontStyleTextStrings.regular,
                                                      color: AppColors
                                                          .noPrescriptionTextColor,
                                                      height: 1,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                              )),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                            ],
                                          ),
                                          (detailsController
                                                          .doctorAppointmentDetailsClass!
                                                          .image
                                                          ?.length ??
                                                      0) !=
                                                  0
                                              ? SizedBox(
                                                  height: 25,
                                                  child: Divider(
                                                    color: AppColors.LIGHT_GREY_TEXT,
                                                    thickness: 1,
                                                  ),
                                                )
                                              : const SizedBox(),
                                          ListView.separated(
                                              separatorBuilder: (context, index) {
                                                return SizedBox(
                                                  height: 25,
                                                  child: Divider(
                                                    color: AppColors.LIGHT_GREY_TEXT,
                                                    thickness: 1,
                                                  ),
                                                );
                                              },
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: detailsController
                                                      .doctorAppointmentDetailsClass!
                                                      .image
                                                      ?.length ??
                                                  0,
                                              itemBuilder: (context, i) {
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(Report_Image_Screen(),
                                                        arguments: {
                                                          'imagepath':
                                                              '${detailsController.doctorAppointmentDetailsClass!.image![i].image}',
                                                          'reportname':
                                                              '${detailsController.doctorAppointmentDetailsClass!.image![i].name}',
                                                        });
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 10, vertical: 8),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .LIGHT_GREY_TEXT),
                                                            borderRadius:
                                                                BorderRadius.circular(8),
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Get.to(
                                                                  Report_Image_Screen(),
                                                                  arguments: {
                                                                    'imagepath':
                                                                        '${detailsController.doctorAppointmentDetailsClass!.image![i].image}',
                                                                    'reportname':
                                                                        '${detailsController.doctorAppointmentDetailsClass!.image![i].name}',
                                                                  });
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      8),
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                    ("${Apis.reportImagePath}${detailsController.doctorAppointmentDetailsClass!.image![i].image}"),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        10.ws,
                                                        Expanded(
                                                          child:
                                                              AppTextWidgets.regularText(
                                                            text:
                                                                "${detailsController.doctorAppointmentDetailsClass!.image![i].name}",
                                                            color:
                                                                AppColors.LIGHT_GREY_TEXT,
                                                            size: 18,
                                                          ),
                                                        ),
                                                        10.ws,
                                                        GestureDetector(
                                                          // onTap: () async {
                                                          //   customDialog1(
                                                          //       s1: 'reporting_dialog1'.tr,
                                                          //       s2: 'please_wait_while_processing'.tr);
                                                          //   await detailsController
                                                          //       .downloadAndSaveImage(
                                                          //     ("${Apis.reportImagePath}${detailsController.doctorAppointmentDetailsClass!.image![i].image}"),
                                                          //   )
                                                          //       .then((value) {
                                                          //     if (value) {
                                                          //       Get.back();
                                                          //       customDialog(
                                                          //         onPressed: () {
                                                          //           Get.back();
                                                          //         },
                                                          //         s1: 'success'.tr,
                                                          //         s2: 'image_save_success'.tr,
                                                          //       );
                                                          //     }
                                                          //   });
                                                          // },
                                                          child: const Icon(
                                                            Icons.arrow_forward_ios,
                                                            color: AppColors.color1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              })
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
      ),
    );
  }
}
