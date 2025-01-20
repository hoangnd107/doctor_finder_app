import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';
import 'package:videocalling_medical/patient/screens/prescription_detail_screen.dart';

class DoctorAppointmentDetails extends GetView<DAppointmentDetailsController> {
  final DAppointmentDetailsController detailsController =
      Get.put(DAppointmentDetailsController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: detailsController.willPopScope,
      child: Scaffold(
        backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: CustomAppBar(
            title: detailsController.isPharmacy.value ? 'order_str'.tr : 'appointment'.tr,
            isBackArrow: true,
            onPressed: () => Get.back(result: detailsController.areChangesMade.value),
            textStyle: Theme.of(context).textTheme.headlineSmall!.apply(
                color: Theme.of(context).scaffoldBackgroundColor, fontWeightDelta: 5),
          ),
          leading: Container(),
        ),
        body: Obx(
          () => detailsController.isErrorInLoading.value
              ? Container(
                  height: Get.height * .25,
                  alignment: Alignment.center,
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
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: AppFontStyleTextStrings.regular,
                        ),
                      )
                    ],
                  ),
                )
              : detailsController.isLoaded.value
                  ? Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: detailsController.isPharmacy.value
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Container(
                                                    margin: const EdgeInsets.fromLTRB(
                                                        0, 5, 0, 5),
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      color: AppColors.WHITE,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        detailsController.orderDetail
                                                                    .data!.userImage!
                                                                    .toString() !=
                                                                ""
                                                            ? Container(
                                                                height: 70,
                                                                width: 70,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(8),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        detailsController
                                                                            .orderDetail
                                                                            .data!
                                                                            .userImage!,
                                                                    fit: BoxFit.contain,
                                                                    placeholder:
                                                                        (context, url) =>
                                                                            Container(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight,
                                                                      child: Image.asset(
                                                                        AppImages
                                                                            .tab3dUnselect,
                                                                        height: 20,
                                                                        width: 20,
                                                                      ),
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url, err) =>
                                                                        Container(
                                                                            color: Theme.of(
                                                                                    context)
                                                                                .primaryColorLight,
                                                                            child: Image
                                                                                .asset(
                                                                              AppImages
                                                                                  .tab3dUnselect,
                                                                              height: 20,
                                                                              width: 20,
                                                                            )),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(
                                                                color: Theme.of(context)
                                                                    .primaryColorLight,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(20.0),
                                                                  child: Image.asset(
                                                                    AppImages
                                                                        .tab3dUnselect,
                                                                    height: 20,
                                                                    width: 20,
                                                                  ),
                                                                )),
                                                        10.ws,
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    AppTextWidgets
                                                                        .semiBoldText(
                                                                      text: detailsController
                                                                              .orderDetail
                                                                              .data!
                                                                              .userName
                                                                              .toString() ??
                                                                          "",
                                                                      color:
                                                                          AppColors.BLACK,
                                                                      size: 13,
                                                                    ),
                                                                    2.hs,
                                                                    Text(
                                                                      detailsController
                                                                          .orderDetail
                                                                          .data!
                                                                          .phone
                                                                          .toString(),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall!
                                                                          .apply(
                                                                            fontWeightDelta:
                                                                                2,
                                                                            color: Theme.of(
                                                                                    context)
                                                                                .primaryColorDark
                                                                                .withOpacity(
                                                                                    0.5),
                                                                          ),
                                                                    ),
                                                                    2.hs,
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(5),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                                      15),
                                                                          color: Theme.of(
                                                                                  context)
                                                                              .primaryColorLight),
                                                                      child: Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize
                                                                                .min,
                                                                        children: [
                                                                          Image.asset(
                                                                            AppImages
                                                                                .timeIcon,
                                                                            height: 13,
                                                                            width: 13,
                                                                          ),
                                                                          const SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(
                                                                            detailsController
                                                                                        .orderDetail
                                                                                        .data!
                                                                                        .status! ==
                                                                                    0
                                                                                ? 'order_status_0'
                                                                                    .tr
                                                                                : detailsController.orderDetail.data!.status! ==
                                                                                        1
                                                                                    ? 'order_status_1'
                                                                                        .tr
                                                                                    : detailsController.orderDetail.data!.status! == 2
                                                                                        ? 'order_status_2'.tr
                                                                                        : detailsController.orderDetail.data!.status! == 3
                                                                                            ? 'order_status_3'.tr
                                                                                            : detailsController.orderDetail.data!.status! == 4
                                                                                                ? 'order_status_4'.tr
                                                                                                : detailsController.orderDetail.data!.status! == 5
                                                                                                    ? 'order_status_5'.tr
                                                                                                    : detailsController.orderDetail.data!.status! == 6
                                                                                                        ? 'order_status_6'.tr
                                                                                                        : detailsController.orderDetail.data!.status! == 7
                                                                                                            ? 'order_status_7'.tr
                                                                                                            : detailsController.orderDetail.data!.status! == 8
                                                                                                                ? 'order_status_8'.tr
                                                                                                                : detailsController.orderDetail.data!.status! == 8
                                                                                                                    ? 'order_status_8'.tr
                                                                                                                    : 'order_status_9'.tr,
                                                                            style: Theme.of(
                                                                                    context)
                                                                                .textTheme
                                                                                .bodySmall!
                                                                                .apply(
                                                                                  fontSizeDelta:
                                                                                      0.5,
                                                                                  fontWeightDelta:
                                                                                      2,
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
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.end,
                                                          children: [
                                                            Image.asset(
                                                              AppImages.calender,
                                                              height: 17,
                                                              width: 17,
                                                            ),
                                                            5.hs,
                                                            AppTextWidgets.regularText(
                                                              text:
                                                                  "${detailsController.orderDetail.data!.createdAt?.substring(8, 10)}"
                                                                  "${detailsController.orderDetail.data!.createdAt?.substring(4, 8)}"
                                                                  "${detailsController.orderDetail.data!.createdAt?.substring(0, 4)}",
                                                              color: AppColors
                                                                  .LIGHT_GREY_TEXT,
                                                              size: 11,
                                                            ),
                                                            Row(
                                                              children: [
                                                                AppTextWidgets
                                                                    .regularText(
                                                                  text:
                                                                      "${detailsController.orderDetail.data!.createdAt?.substring(11, 16)}",
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
                                                  margin: const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                                  padding: const EdgeInsets.all(8),
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'delivery_address'.tr,
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .apply(
                                                                          fontWeightDelta:
                                                                              1,
                                                                          fontSizeDelta:
                                                                              1.5),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  detailsController
                                                                      .orderDetail
                                                                      .data!
                                                                      .address!
                                                                      .toString(),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodySmall!
                                                                      .apply(
                                                                        fontWeightDelta:
                                                                            2,
                                                                        color: Theme.of(
                                                                                context)
                                                                            .primaryColorDark
                                                                            .withOpacity(
                                                                                0.5),
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
                                                            MainAxisAlignment
                                                                .spaceBetween,
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
                                                                        fontWeightDelta:
                                                                            1,
                                                                        fontSizeDelta:
                                                                            1.5),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                detailsController
                                                                    .orderDetail
                                                                    .data!
                                                                    .userEmail!
                                                                    .toString(),
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .apply(
                                                                      fontWeightDelta: 2,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorDark
                                                                          .withOpacity(
                                                                              0.5),
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
                                                                    .orderDetail
                                                                    .data!
                                                                    .userEmail!
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
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'description'.tr,
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .apply(
                                                                          fontWeightDelta:
                                                                              1,
                                                                          fontSizeDelta:
                                                                              1.5),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  detailsController
                                                                      .orderDetail
                                                                      .data!
                                                                      .message!
                                                                      .toString(),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodySmall!
                                                                      .apply(
                                                                        fontWeightDelta:
                                                                            2,
                                                                        color: Theme.of(
                                                                                context)
                                                                            .primaryColorDark
                                                                            .withOpacity(
                                                                                0.5),
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 12, top: 12,right: 16),
                                                  child: AppTextWidgets.mediumText(
                                                    text: detailsController
                                                            .isprescription.value
                                                        ? 'prescription_detail'.tr
                                                        : "medicine_detail".tr,
                                                    color: AppColors.BLACK,
                                                    size: 16,
                                                  ),
                                                ),

                                                ///medicine screen detail
                                                if (detailsController
                                                        .isprescription.value ==
                                                    false)
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                    child: Container(
                                                      margin: const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 10),
                                                      padding: const EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.WHITE,
                                                      ),
                                                      child: ListView.separated(
                                                          shrinkWrap: true,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, index2) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                detailsController
                                                                            .orderDetail
                                                                            .data!
                                                                            .medicine![
                                                                                index2]
                                                                            .medicineImg
                                                                            .toString() !=
                                                                        ""
                                                                    ? Container(
                                                                        height: 70,
                                                                        width: 70,
                                                                        child: ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                                      8),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl: detailsController
                                                                                .orderDetail
                                                                                .data!
                                                                                .medicine![
                                                                                    index2]
                                                                                .medicineImg
                                                                                .toString(),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                            placeholder: (context,
                                                                                    url) =>
                                                                                Container(
                                                                              color: Theme.of(
                                                                                      context)
                                                                                  .primaryColorLight,
                                                                              child: Image
                                                                                  .asset(
                                                                                AppImages
                                                                                    .medicine1,
                                                                                height:
                                                                                    20,
                                                                                width: 20,
                                                                              ),
                                                                            ),
                                                                            errorWidget: (context,
                                                                                    url,
                                                                                    err) =>
                                                                                Container(
                                                                                    color: Theme.of(context)
                                                                                        .primaryColorLight,
                                                                                    child:
                                                                                        Image.asset(
                                                                                      AppImages.medicine1,
                                                                                      height:
                                                                                          20,
                                                                                      width:
                                                                                          20,
                                                                                    )),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                                      8),
                                                                          color: Theme.of(
                                                                                  context)
                                                                              .primaryColorLight,
                                                                        ),
                                                                        child: Padding(
                                                                          padding:
                                                                              const EdgeInsets
                                                                                  .all(
                                                                                  20.0),
                                                                          child:
                                                                              Image.asset(
                                                                            AppImages
                                                                                .medicine1,
                                                                            height: 40,
                                                                            width: 40,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text(
                                                                              "${detailsController.orderDetail.data!.medicine![index2].name.toString()}",
                                                                              maxLines: 2,
                                                                              style: const TextStyle(
                                                                                  fontFamily:
                                                                                      AppFontStyleTextStrings
                                                                                          .regular,
                                                                                  fontSize:
                                                                                      14,
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
                                                                        height: 5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          AppTextWidgets
                                                                              .regularText(
                                                                            text:
                                                                                'quantity_col'
                                                                                    .tr,
                                                                            color: AppColors
                                                                                .LIGHT_GREY_TEXT,
                                                                            size: 14,
                                                                          ),
                                                                          AppTextWidgets
                                                                              .regularText(
                                                                            text:
                                                                                '${detailsController.orderDetail.data!.medicine![index2].qty.toString() ?? ""}',
                                                                            color:
                                                                                AppColors
                                                                                    .BLACK,
                                                                            size: 14,
                                                                          ),
                                                                          const SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          const Spacer(),
                                                                          AppTextWidgets
                                                                              .regularText(
                                                                            text:
                                                                                "price_col"
                                                                                    .tr,
                                                                            color: AppColors
                                                                                .LIGHT_GREY_TEXT,
                                                                            size: 14,
                                                                          ),
                                                                          AppTextWidgets
                                                                              .regularText(
                                                                            text:
                                                                                "${detailsController.orderDetail.data!.medicine![index2].price.toStringAsFixed(1) ?? ""}$CURRENCY",
                                                                            color:
                                                                                AppColors
                                                                                    .BLACK,
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
                                                          separatorBuilder:
                                                              (context, index2) {
                                                            return SizedBox(
                                                              height: 20,
                                                              child: Divider(
                                                                color: AppColors
                                                                    .LIGHT_GREY_TEXT,
                                                                thickness: 1,
                                                              ),
                                                            );
                                                          },
                                                          itemCount: detailsController
                                                              .orderDetail
                                                              .data!
                                                              .medicine!
                                                              .length),
                                                    ),
                                                  ),

                                                if (detailsController
                                                        .isprescription.value ==
                                                    false)
                                                  Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 12, right: 12),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${'total_mrp'.tr} ",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 14,
                                                                  color: AppColors.grey,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              Text(
                                                                '${detailsController.orderDetail.data!.subtotal.toStringAsFixed(1)}$CURRENCY',
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 14,
                                                                  color: AppColors.BLACK,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          5.hs,
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${'delivery_charges'.tr} ",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 14,
                                                                  color: AppColors.grey,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              Text(
                                                                // delivery_charge
                                                                detailsController
                                                                            .orderDetail
                                                                            .data!
                                                                            .deliveryCharge !=
                                                                        null
                                                                    ? '+${detailsController.orderDetail.data!.deliveryCharge.toStringAsFixed(1)}$CURRENCY'
                                                                    : "+0.0$CURRENCY",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 14,
                                                                  color: AppColors.BLACK,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          5.hs,
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${'tax'.tr} ",
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 14,
                                                                  color: AppColors.grey,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              Text(
                                                                detailsController
                                                                            .orderDetail
                                                                            .data!
                                                                            .taxPr !=
                                                                        null
                                                                    ? '+${detailsController.orderDetail.data!.taxPr.toStringAsFixed(1)}%'
                                                                    : "+0.0%",

                                                                // "+${(double.parse(tax) ?? 0.0).toStringAsFixed(1)}%",
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
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
                                                                '${detailsController.orderDetail.data!.total}$CURRENCY',
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 19,
                                                                  color: AppColors.color1,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          3.hs,
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ///prescription screen detail
                                                if (detailsController
                                                        .isprescription.value ==
                                                    true)
                                                  Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.to(PrescriptionDetailScreen(),
                                                            arguments: {
                                                              'url':
                                                                  detailsController
                                                                      .orderDetail
                                                                      .data!
                                                                      .prescription!
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
                                                                    .orderDetail
                                                                    .data!
                                                                    .prescription!,
                                                            fit: BoxFit.cover,
                                                            placeholder: (context, url) =>
                                                                Container(
                                                              color: Theme.of(context)
                                                                  .primaryColorLight,
                                                              child: Image.asset(
                                                                AppImages.medicine1,
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
                                                                    )),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                if (detailsController
                                                        .isprescription.value ==
                                                    false)
                                                  detailsController.buttonForOrder(
                                                      context: context),

                                                if (detailsController
                                                                .isprescription.value ==
                                                            true &&
                                                        detailsController.orderDetail
                                                                .data!.status! ==
                                                            4 ||
                                                    detailsController
                                                            .orderDetail.data!.status! ==
                                                        5 ||
                                                    detailsController
                                                            .orderDetail.data!.status! ==
                                                        7 ||
                                                    detailsController
                                                            .orderDetail.data!.status! ==
                                                        3 ||
                                                    detailsController
                                                            .orderDetail.data!.status! ==
                                                        8)
                                                  Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 18, right: 18),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${'total_mrp'.tr} ",
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 14,
                                                                  color: AppColors.grey,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              Text(
                                                                '${detailsController.orderDetail.data!.prescriptionPrice.toStringAsFixed(1) ?? 0.toStringAsFixed(1)}$CURRENCY',
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 14,
                                                                  color: AppColors.BLACK,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          5.hs,
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${'delivery_charges'.tr} ",
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 14,
                                                                  color: AppColors.grey,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              Text(
                                                                // delivery_charge
                                                                detailsController
                                                                            .orderDetail
                                                                            .data!
                                                                            .deliveryCharge !=
                                                                        null
                                                                    ? '+${detailsController.orderDetail.data!.deliveryCharge.toStringAsFixed(1)}$CURRENCY'
                                                                    : "+0.0$CURRENCY",

                                                                // "+${(double.parse(deliveryCharge) ?? 0.0).toStringAsFixed(1)}$CURRENCY",
                                                                // '',
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 14,
                                                                  color: AppColors.BLACK,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          5.hs,
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${'tax'.tr} ",
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 14,
                                                                  color: AppColors.grey,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              Text(
                                                                detailsController
                                                                            .orderDetail
                                                                            .data!
                                                                            .taxPr !=
                                                                        null
                                                                    ? '+${detailsController.orderDetail.data!.taxPr.toStringAsFixed(1)}%'
                                                                    : "+0.0%",

                                                                // "+${(double.parse(tax) ?? 0.0).toStringAsFixed(1)}%",
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
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
                                                                '${detailsController.orderDetail.data!.total.toStringAsFixed(1)}$CURRENCY',
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
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

                                                if (detailsController
                                                        .isprescription.value ==
                                                    true)
                                                  detailsController.buttonForPriscription(
                                                      context: context),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    )


                                  : ListView(
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius: BorderRadius.circular(15)),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  imageUrl: detailsController
                                                      .doctorAppointmentDetailsClass
                                                      .data!
                                                      .userImage!,
                                                  height: 75,
                                                  width: 75,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    color: Theme.of(context)
                                                        .primaryColorLight,
                                                    child: Center(
                                                      child: Image.asset(
                                                        AppImages.tab3dUnselect,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url, err) =>
                                                      Container(
                                                    color: Theme.of(context)
                                                        .primaryColorLight,
                                                    child: Center(
                                                      child: Image.asset(
                                                        AppImages.tab3dUnselect,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            detailsController
                                                                .doctorAppointmentDetailsClass
                                                                .data!
                                                                .userName!,
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
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
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
                                                                        .apStatus.value ==
                                                                    0
                                                                ? 'appointment_status_1'
                                                                    .tr
                                                                : detailsController
                                                                            .apStatus
                                                                            .value ==
                                                                        1
                                                                    ? 'appointment_status_2'
                                                                        .tr
                                                                    : detailsController
                                                                                .apStatus
                                                                                .value ==
                                                                            2
                                                                        ? 'appointment_status_3'
                                                                            .tr
                                                                        : detailsController
                                                                                    .apStatus
                                                                                    .value ==
                                                                                3
                                                                            ? 'appointment_status_4'
                                                                                .tr
                                                                            : detailsController
                                                                                        .apStatus
                                                                                        .value ==
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
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
                                                      "${detailsController.doctorAppointmentDetailsClass.data!.date.toString().substring(8)}-${detailsController.doctorAppointmentDetailsClass.data!.date.toString().substring(5, 7)}-${detailsController.doctorAppointmentDetailsClass.data!.date.toString().substring(0, 4)}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall),
                                                  Text(
                                                      detailsController
                                                          .doctorAppointmentDetailsClass
                                                          .data!
                                                          .slot!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .apply(fontWeightDelta: 2)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.symmetric(horizontal: 10),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).scaffoldBackgroundColor,
                                          ),
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
                                                            .doctorAppointmentDetailsClass
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
                                                          "tel:${detailsController.doctorAppointmentDetailsClass.data!.phone!}");
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
                                                            .doctorAppointmentDetailsClass
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
                                                            .doctorAppointmentDetailsClass
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
                                                              .doctorAppointmentDetailsClass
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
                                                                    .doctorAppointmentDetailsClass
                                                                    .data!
                                                                    .userImage!
                                                                    .isNotEmpty
                                                                ? detailsController
                                                                    .doctorAppointmentDetailsClass
                                                                    .data!
                                                                    .userImage!
                                                                : AppImages.defaultUser));

                                                        StorageService.writeStringData(
                                                            key: LocalStorageKeys
                                                                .callerImage,
                                                            value: (detailsController
                                                                    .doctorAppointmentDetailsClass
                                                                    .data!
                                                                    .doctorImage!
                                                                    .isNotEmpty
                                                                ? detailsController
                                                                    .doctorAppointmentDetailsClass
                                                                    .data!
                                                                    .doctorImage!
                                                                : AppImages
                                                                    .defaultDoctor));

                                                        StorageService.writeStringData(
                                                            key: LocalStorageKeys
                                                                .callReceiverName,
                                                            value: detailsController
                                                                    .doctorAppointmentDetailsClass
                                                                    .data!
                                                                    .userName ??
                                                                '');

                                                        callOptionDialog(
                                                          callId: detailsController
                                                              .doctorAppointmentDetailsClass
                                                              .data!
                                                              .connectycubeUserId!
                                                              .toInt(),
                                                          uid: int.parse(
                                                              "117${detailsController.doctorAppointmentDetailsClass!.data!.userId!.toInt()}"),
                                                        );
                                                      },
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                              gradient:
                                                                  const LinearGradient(
                                                                colors: [
                                                                  AppColors.color1,
                                                                  AppColors.color2,
                                                                ],
                                                                begin:
                                                                    Alignment.bottomLeft,
                                                                end: Alignment.topRight,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      15)),
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
                                                        await Get.toNamed(
                                                            Routes.chatScreen,
                                                            arguments: {
                                                              'userName': detailsController
                                                                  .doctorAppointmentDetailsClass
                                                                  .data!
                                                                  .userName,
                                                              'uid':
                                                                  '117${detailsController.userId.value}',
                                                              'isUser': true,
                                                            });
                                                        Get.delete<ChatController>();
                                                      },
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                              gradient:
                                                                  const LinearGradient(
                                                                colors: [
                                                                  AppColors.color1,
                                                                  AppColors.color2,
                                                                ],
                                                                begin:
                                                                    Alignment.bottomLeft,
                                                                end: Alignment.topRight,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      15)),
                                                          height: 40,
                                                          width: 45,
                                                          child: const Icon(
                                                            Icons.chat,
                                                            color: AppColors.WHITE,
                                                          ))),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        detailsController.apStatus.value == 4
                                            ? Container(
                                                margin: const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ),
                                                child: Column(
                                                  children: [
                                                    ListView.separated(
                                                        shrinkWrap: true,
                                                        reverse: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemBuilder: (context, i) {
                                                          return Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${detailsController.doctorAppointmentDetailsClass.prescription!.medicine![i].medicine_name}",
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                            color: AppColors
                                                                                .reportTextColor,
                                                                            height: 1.2,
                                                                            fontFamily:
                                                                                AppFontStyleTextStrings
                                                                                    .regular,
                                                                            fontSize: 16),
                                                                      )
                                                                    ],
                                                                  )),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      AppTextWidgets
                                                                          .regularText(
                                                                        text:
                                                                            'medicine_param_1'
                                                                                .tr,
                                                                        color: AppColors
                                                                            .noPrescriptionTextColor,
                                                                        size: 12,
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 3,
                                                                      ),
                                                                      Text(
                                                                        "${detailsController.doctorAppointmentDetailsClass.prescription!.medicine![i].type.toString()[0].toUpperCase()}${detailsController.doctorAppointmentDetailsClass.prescription!.medicine![i].type.toString().substring(1)}",
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                            height: 1.2,
                                                                            color: AppColors
                                                                                .reportTextColor,
                                                                            fontFamily:
                                                                                AppFontStyleTextStrings
                                                                                    .regular,
                                                                            fontSize: 16),
                                                                      )
                                                                    ],
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                      child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      AppTextWidgets
                                                                          .regularText(
                                                                        text:
                                                                            'medicine_param_2'
                                                                                .tr,
                                                                        color: AppColors
                                                                            .noPrescriptionTextColor,
                                                                        size: 12,
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 3,
                                                                      ),
                                                                      Text(
                                                                        "${detailsController.doctorAppointmentDetailsClass.prescription!.medicine![i].dosage}",
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                            height: 1.2,
                                                                            color: AppColors
                                                                                .reportTextColor,
                                                                            fontFamily:
                                                                                AppFontStyleTextStrings
                                                                                    .regular,
                                                                            fontSize: 16),
                                                                      )
                                                                    ],
                                                                  )),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      AppTextWidgets
                                                                          .regularText(
                                                                        text:
                                                                            'medicine_param_3'
                                                                                .tr,
                                                                        color: AppColors
                                                                            .noPrescriptionTextColor,
                                                                        size: 12,
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 4,
                                                                      ),
                                                                      GridView.builder(
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap: true,
                                                                        gridDelegate:
                                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              4,
                                                                          childAspectRatio:
                                                                              2.5,
                                                                          mainAxisSpacing:
                                                                              10,
                                                                          crossAxisSpacing:
                                                                              10,
                                                                        ),
                                                                        itemCount: detailsController
                                                                            .doctorAppointmentDetailsClass
                                                                            .prescription!
                                                                            .medicine![i]
                                                                            .time!
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius:
                                                                                  BorderRadius
                                                                                      .circular(8),
                                                                              border: Border.all(
                                                                                  color: AppColors
                                                                                      .noPrescriptionTextColor),
                                                                            ),
                                                                            child: Center(
                                                                              child: Row(
                                                                                mainAxisAlignment:
                                                                                    MainAxisAlignment
                                                                                        .center,
                                                                                children: [
                                                                                  AppTextWidgets
                                                                                      .regularText(
                                                                                    text: DateFormat.jm().format(DateFormat.Hm().parse(detailsController
                                                                                        .doctorAppointmentDetailsClass
                                                                                        .prescription!
                                                                                        .medicine![i]
                                                                                        .time![index]
                                                                                        .tTime!)),
                                                                                    color:
                                                                                        AppColors.reportTextColor,
                                                                                    size:
                                                                                        14,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  )),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 11,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(children: [
                                                                    AppTextWidgets
                                                                        .regularText(
                                                                      text:
                                                                          'medicine_param_4'
                                                                              .tr,
                                                                      color: AppColors
                                                                          .noPrescriptionTextColor,
                                                                      size: 12,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      "${detailsController.doctorAppointmentDetailsClass.prescription!.medicine![i].repeatDays} Days",
                                                                      maxLines: 2,
                                                                      style: TextStyle(
                                                                          height: 1.2,
                                                                          fontFamily:
                                                                              AppFontStyleTextStrings
                                                                                  .regular,
                                                                          color: AppColors
                                                                              .reportTextColor,
                                                                          fontSize: 14),
                                                                    ),
                                                                  ]),
                                                                  Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: () async {
                                                                          List<TimeOfDay>
                                                                              timeListLocal =
                                                                              detailsController
                                                                                  .doctorAppointmentDetailsClass
                                                                                  .prescription!
                                                                                  .medicine![
                                                                                      i]
                                                                                  .time!
                                                                                  .map(
                                                                                    (e) =>
                                                                                        TimeOfDay(
                                                                                      hour:
                                                                                          int.parse(e.tTime?.split(":").first ?? "00"),
                                                                                      minute:
                                                                                          int.parse(e.tTime?.split(":").last.split(" ").first ?? "00"),
                                                                                    ),
                                                                                  )
                                                                                  .toList();
                                                                          int repeatDaysLocal = detailsController
                                                                              .doctorAppointmentDetailsClass
                                                                              .prescription!
                                                                              .medicine![
                                                                                  i]
                                                                              .repeatDays!;

                                                                          MedicineData medicineDataLocal = MedicineData(
                                                                              name: detailsController
                                                                                  .doctorAppointmentDetailsClass
                                                                                  .prescription!
                                                                                  .medicine![
                                                                                      i]
                                                                                  .medicine_name,
                                                                              id: detailsController
                                                                                  .doctorAppointmentDetailsClass
                                                                                  .prescription!
                                                                                  .medicine![
                                                                                      i]
                                                                                  .medicineId,
                                                                              dosage: detailsController
                                                                                  .doctorAppointmentDetailsClass
                                                                                  .prescription!
                                                                                  .medicine![
                                                                                      i]
                                                                                  .dosage,
                                                                              medicineType: detailsController
                                                                                  .doctorAppointmentDetailsClass
                                                                                  .prescription!
                                                                                  .medicine![
                                                                                      i]
                                                                                  .type
                                                                                  .toString());
                                                                          detailsController
                                                                                  .localData =
                                                                              detailsController
                                                                                  .doctorAppointmentDetailsClass
                                                                                  .prescription!
                                                                                  .medicine!;
                                                                          detailsController
                                                                              .localData
                                                                              .removeAt(
                                                                                  i);
                                                                          List<
                                                                                  Map<String,
                                                                                      dynamic>>?
                                                                              jsonData =
                                                                              detailsController
                                                                                  .localData
                                                                                  .map(
                                                                                    (e) =>
                                                                                        {
                                                                                      "time": e.time?.map((e) {
                                                                                            var h = e.tTime?.split(":");
                                                                                            var m = h?.last.split(" ").first;
                                                                                            return {
                                                                                              "t_time": "${h?.first.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}",
                                                                                            };
                                                                                          }).toList() ??
                                                                                          [],
                                                                                      "medicine_name":
                                                                                          e.medicine_name.toString(),
                                                                                      "repeat_days":
                                                                                          e.repeatDays.toString(),
                                                                                      "dosage":
                                                                                          e.dosage.toString(),
                                                                                      "type":
                                                                                          e.type.toString(),
                                                                                    },
                                                                                  )
                                                                                  .toList();

                                                                          Get.to(
                                                                            MedicinseScreen(
                                                                                updateValue2:
                                                                                    true,
                                                                                updateRepeatDays:
                                                                                    repeatDaysLocal,
                                                                                timeList: [
                                                                                  timeListLocal
                                                                                ],
                                                                                ll: [
                                                                                  medicineDataLocal
                                                                                ],
                                                                                id: int.parse(
                                                                                    detailsController
                                                                                        .id),
                                                                                oldData: jsonEncode(jsonData
                                                                                        .isEmpty
                                                                                    ? "No Data"
                                                                                    : jsonData)),
                                                                          )!
                                                                              .then(
                                                                                  (value) {
                                                                            Get.delete<
                                                                                AddMedicineToAppointmentController>();
                                                                            if (value !=
                                                                                "false") {
                                                                              detailsController
                                                                                  .fetchAppointmentDetails();
                                                                            }
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                            height: 40,
                                                                            width: 45,
                                                                            alignment:
                                                                                Alignment
                                                                                    .center,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(
                                                                                      15),
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
                                                                            ),
                                                                            child:
                                                                                SizedBox(
                                                                              height: 25,
                                                                              width: 25,
                                                                              child: SvgPicture
                                                                                  .asset(
                                                                                AppImages
                                                                                    .editIconSvg,
                                                                              ),
                                                                            )),
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: () {
                                                                          Get.dialog(
                                                                            AlertDialog(
                                                                              backgroundColor:
                                                                                  AppColors
                                                                                      .WHITE,
                                                                              shape:
                                                                                  RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                    BorderRadius.circular(
                                                                                        5),
                                                                              ),
                                                                              title:
                                                                                  Center(
                                                                                child:
                                                                                    Align(
                                                                                  alignment:
                                                                                      Alignment.center,
                                                                                  child: AppTextWidgets
                                                                                      .regularText(
                                                                                    text:
                                                                                        'confirmation'.tr,
                                                                                    color:
                                                                                        AppColors.BLACK,
                                                                                    size:
                                                                                        24,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              content:
                                                                                  Text(
                                                                                'delete_medicine'
                                                                                    .tr,
                                                                                style:
                                                                                    const TextStyle(
                                                                                  color: AppColors
                                                                                      .BLACK,
                                                                                  fontSize:
                                                                                      18,
                                                                                  fontFamily:
                                                                                      AppFontStyleTextStrings.regular,
                                                                                ),
                                                                                textAlign:
                                                                                    TextAlign
                                                                                        .center,
                                                                              ),
                                                                              actions: [
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child:
                                                                                          GestureDetector(
                                                                                        onTap: () {
                                                                                          Get.back();
                                                                                        },
                                                                                        child: Container(
                                                                                          alignment: Alignment.center,
                                                                                          height: 50,
                                                                                          width: double.infinity,
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
                                                                                          child: AppTextWidgets.regularText(
                                                                                            text: 'cancel'.tr,
                                                                                            color: AppColors.WHITE,
                                                                                            size: 18,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width:
                                                                                          10,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child:
                                                                                          GestureDetector(
                                                                                        onTap: () async {
                                                                                          detailsController.localData = detailsController.doctorAppointmentDetailsClass.prescription!.medicine!;
                                                                                          detailsController.localData.removeAt(i);
                                                                                          List<Map<String, dynamic>>? jsonData = detailsController.localData
                                                                                              .map(
                                                                                                (e) => {
                                                                                                  "time": e.time?.map((e) {
                                                                                                        var h = e.tTime?.split(":");
                                                                                                        var m = h?.last.split(" ").first;
                                                                                                        return {
                                                                                                          "t_time": "${h?.first.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}",
                                                                                                        };
                                                                                                      }).toList() ??
                                                                                                      [],
                                                                                                  "medicine_name": e.medicine_name.toString(),
                                                                                                  "repeat_days": e.repeatDays.toString(),
                                                                                                  "dosage": e.dosage.toString(),
                                                                                                  "type": e.type.toString(),
                                                                                                },
                                                                                              )
                                                                                              .toList();

                                                                                          Get.back();
                                                                                          detailsController.deleteMedicine(jsonData: jsonData);
                                                                                        },
                                                                                        child: Container(
                                                                                          alignment: Alignment.center,
                                                                                          height: 50,
                                                                                          width: double.infinity,
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
                                                                                            'delete'.tr,
                                                                                            maxLines: 1,
                                                                                            style: const TextStyle(
                                                                                              color: AppColors.WHITE,
                                                                                              fontSize: 18,
                                                                                              fontFamily: AppFontStyleTextStrings.regular,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: Container(
                                                                            height: 40,
                                                                            width: 45,
                                                                            alignment:
                                                                                Alignment
                                                                                    .center,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(
                                                                                      15),
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
                                                                            ),
                                                                            child:
                                                                                SizedBox(
                                                                              height: 25,
                                                                              width: 25,
                                                                              child: SvgPicture
                                                                                  .asset(
                                                                                AppImages
                                                                                    .deleteIconSvg,
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return SizedBox(
                                                            height: 25,
                                                            child: Divider(
                                                              color: AppColors
                                                                  .LIGHT_GREY_TEXT,
                                                              thickness: 1,
                                                            ),
                                                          );
                                                        },
                                                        itemCount: detailsController
                                                                .doctorAppointmentDetailsClass
                                                                .prescription
                                                                ?.medicine
                                                                ?.length ??
                                                            0),
                                                    ((detailsController
                                                                    .doctorAppointmentDetailsClass
                                                                    .prescription
                                                                    ?.medicine
                                                                    ?.length ??
                                                                0) ==
                                                            0)
                                                        ? const SizedBox()
                                                        : SizedBox(
                                                            height: 25,
                                                            child: Divider(
                                                              color: AppColors
                                                                  .LIGHT_GREY_TEXT,
                                                              thickness: 1,
                                                            ),
                                                          ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        List<Map<String, dynamic>>?
                                                            jsonData = detailsController
                                                                .doctorAppointmentDetailsClass
                                                                .prescription
                                                                ?.medicine
                                                                ?.map(
                                                                  (e) => {
                                                                    "time": e.time
                                                                            ?.map((e) {
                                                                          var h = e.tTime
                                                                              ?.split(
                                                                                  ":");
                                                                          var m = h?.last
                                                                              .split(" ")
                                                                              .first;
                                                                          return {
                                                                            "t_time":
                                                                                "${h?.first.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}",
                                                                          };
                                                                        }).toList() ??
                                                                        [],
                                                                    "medicine_name": e
                                                                        .medicine_name
                                                                        .toString(),
                                                                    "repeat_days": e
                                                                        .repeatDays
                                                                        .toString(),
                                                                    "dosage": e.dosage
                                                                        .toString(),
                                                                    "type":
                                                                        e.type.toString(),
                                                                  },
                                                                )
                                                                .toList();

                                                        await Get.toNamed(
                                                            Routes.dSearchMedicineScreen,
                                                            arguments: {
                                                              'medicineMap':
                                                                  jsonData == null
                                                                      ? null
                                                                      : jsonEncode(
                                                                          jsonData.isEmpty
                                                                              ? "No Data"
                                                                              : jsonData),
                                                              'id': int.parse(
                                                                  detailsController.id),
                                                            })?.then((value) {
                                                          if ((value != "false")) {
                                                            detailsController
                                                                .fetchAppointmentDetails();
                                                          }
                                                          Get.delete<
                                                              SearchMedicineController>();
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 32,
                                                            width: 32,
                                                            padding:
                                                                const EdgeInsets.all(5),
                                                            decoration: BoxDecoration(
                                                                gradient:
                                                                    const LinearGradient(
                                                                  colors: [
                                                                    AppColors.color1,
                                                                    AppColors.color2,
                                                                  ],
                                                                  begin: Alignment
                                                                      .bottomLeft,
                                                                  end: Alignment.topRight,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        5)),
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
                                                                'add_prescription'.tr,
                                                                style: TextStyle(
                                                                  color: AppColors
                                                                      .reportTextColor,
                                                                  height: 1,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .medium,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'd_add_prescription_msg'
                                                                    .tr,
                                                                style: TextStyle(
                                                                  color: AppColors
                                                                      .noPrescriptionTextColor,
                                                                  height: 1,
                                                                  fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                  fontSize: 12,
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          Container(
                                                            height: 22,
                                                            width: 22,
                                                            alignment: Alignment.center,
                                                            child: Icon(
                                                              Icons.navigate_next_rounded,
                                                              color: AppColors
                                                                  .reportTextColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        detailsController.apStatus.value == 4
                                            ? Container(
                                                margin: const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ),
                                                child: Column(
                                                  children: [
                                                    GridView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        childAspectRatio: 0.78,
                                                        mainAxisSpacing: 10,
                                                        crossAxisSpacing: 10,
                                                      ),
                                                      itemCount: detailsController
                                                          .imageList.length,
                                                      itemBuilder: (context, index) {
                                                        return GestureDetector(
                                                          onTap: () async {
                                                            await Get.toNamed(
                                                              Routes.photoViewerScreen,
                                                              arguments: {
                                                                'url':
                                                                    ("${Apis.reportImagePath}${detailsController.imageList[index].image}"),
                                                                'id': detailsController
                                                                    .imageList[index].id
                                                                    .toString(),
                                                                'isDeleteShown': true,
                                                                'reportName':
                                                                    detailsController
                                                                        .imageList[index]
                                                                        .name,
                                                              },
                                                            )?.then(
                                                              (value) {
                                                                Get.delete<
                                                                    MyPhotoViewerController>();
                                                                if (value ?? false) {
                                                                  detailsController
                                                                      .fetchAppointmentDetails();
                                                                }
                                                              },
                                                            );
                                                          },
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(10),
                                                                  child: CachedNetworkImage(
                                                                      fit: BoxFit.cover,
                                                                      imageUrl:
                                                                          ("${Apis.reportImagePath}${detailsController.imageList[index].image}")),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                detailsController
                                                                        .imageList[index]
                                                                        .name ??
                                                                    "",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .reportTextColor,
                                                                    fontFamily:
                                                                        AppFontStyleTextStrings
                                                                            .regular,
                                                                    fontSize: 15),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    detailsController.imageList.isNotEmpty
                                                        ? SizedBox(
                                                            height: 25,
                                                            child: Divider(
                                                              color: AppColors
                                                                  .LIGHT_GREY_TEXT,
                                                              thickness: 1,
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        detailsController
                                                            .textEditingController
                                                            .clear();
                                                        detailsController.fImage = null;
                                                        detailsController
                                                            .showUploadPrescriptionSheetNew();
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 32,
                                                            width: 32,
                                                            padding:
                                                                const EdgeInsets.all(5),
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .appointmentDetailsReportBgColor,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        5)),
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
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'add_reports'.tr,
                                                                  style: TextStyle(
                                                                    color: AppColors
                                                                        .reportTextColor,
                                                                    height: 1,
                                                                    fontSize: 16,
                                                                    fontFamily:
                                                                        AppFontStyleTextStrings
                                                                            .medium,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'd_add_report_msg'.tr,
                                                                  style: TextStyle(
                                                                    fontFamily:
                                                                        AppFontStyleTextStrings
                                                                            .regular,
                                                                    color: AppColors
                                                                        .noPrescriptionTextColor,
                                                                    height: 1,
                                                                    fontSize: 12,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          Container(
                                                            height: 22,
                                                            width: 22,
                                                            alignment: Alignment.center,
                                                            child: Icon(
                                                              Icons.navigate_next_rounded,
                                                              color: AppColors
                                                                  .reportTextColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            detailsController.button(context: context),
                          ],
                        ),
                        detailsController.button(context: context),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
