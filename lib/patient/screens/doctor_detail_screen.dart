import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class DoctorDetailScreen extends GetView<DoctorDetailController> {
  final DoctorDetailController detailController = Get.put(DoctorDetailController());

  /// doctor detail and pharmacy detail screen
  /// 1== doctor, 2== pharmacy

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: CustomAppBar(
          title: detailController.page == 1 ? 'doctor_detail'.tr : 'pharmacy_detail'.tr,
          isBackArrow: true,
          onPressed: () => Get.back(),
        ),
        leading: Container(),
      ),
      body: Obx(() => Stack(
            children: [
              detailController.isErrorInLoading.value
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          10.hs,
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
                  : !detailController.isLoading.value
                      ? Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.WHITE,
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: CachedNetworkImage(
                                              imageUrl: detailController
                                                      .doctorDetailsClass?.data?.image ??
                                                  '',
                                              height:
                                                  detailController.page == 1 ? 80 : 90,
                                              width:
                                                  detailController.page == 1 ? 80 : 90,
                                              fit: BoxFit.contain,
                                              placeholder: (context, url) => Container(
                                                color:
                                                    Theme.of(context).primaryColorLight,
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
                                                color:
                                                    Theme.of(context).primaryColorLight,
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
                                          10.ws,
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppTextWidgets.mediumText(
                                                  text: detailController
                                                          .doctorDetailsClass!
                                                          .data!
                                                          .name ??
                                                      "",
                                                  color: AppColors.BLACK,
                                                  size:  16,
                                                ),
                                                2.hs,
                                                AppTextWidgets.regularText(
                                                  text:

                                                      ///add pharmacy email

                                                  detailController.page == 1
                                                          ? detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .departmentName
                                                              .toString()
                                                          // :"",
                                                          : detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .email
                                                              .toString(),
                                                  size: 14,
                                                  color: AppColors.LIGHT_GREY_TEXT,
                                                ),
                                                4.hs,
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    AppTextWidgets.mediumText(
                                                      text: double.parse(detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .avgratting
                                                              .toString()).toStringAsFixed(1) ??
                                                          "",
                                                      color: AppColors.BLACK,
                                                      size: 16,
                                                    ),
                                                    2.ws,
                                                    Expanded(
                                                      flex: 3,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Image.asset(
                                                                      detailController
                                                                                  .doctorDetailsClass!
                                                                                  .data!
                                                                                  .avgratting ==
                                                                              null
                                                                          ? AppImages
                                                                              .starNoFill
                                                                          : detailController
                                                                                      .doctorDetailsClass!
                                                                                      .data!
                                                                                      .avgratting! >=
                                                                                  1
                                                                              ? AppImages
                                                                                  .starFill
                                                                              : AppImages
                                                                                  .starNoFill,
                                                                      height: 17,
                                                                      width: 17,
                                                                    )),
                                                                    Expanded(
                                                                        child:
                                                                            Image.asset(
                                                                      detailController
                                                                                  .doctorDetailsClass!
                                                                                  .data!
                                                                                  .avgratting ==
                                                                              null
                                                                          ? AppImages
                                                                              .starNoFill
                                                                          : detailController
                                                                                      .doctorDetailsClass!
                                                                                      .data!
                                                                                      .avgratting! >=
                                                                                  2
                                                                              ? AppImages
                                                                                  .starFill
                                                                              : AppImages
                                                                                  .starNoFill,
                                                                      height: 17,
                                                                      width: 17,
                                                                    )),
                                                                    Expanded(
                                                                        child:
                                                                            Image.asset(
                                                                      detailController
                                                                                  .doctorDetailsClass!
                                                                                  .data!
                                                                                  .avgratting ==
                                                                              null
                                                                          ? AppImages
                                                                              .starNoFill
                                                                          : detailController
                                                                                      .doctorDetailsClass!
                                                                                      .data!
                                                                                      .avgratting! >=
                                                                                  3
                                                                              ? AppImages
                                                                                  .starFill
                                                                              : AppImages
                                                                                  .starNoFill,
                                                                      height: 17,
                                                                      width: 17,
                                                                    )),
                                                                    Expanded(
                                                                        child:
                                                                            Image.asset(
                                                                      detailController
                                                                                  .doctorDetailsClass!
                                                                                  .data!
                                                                                  .avgratting ==
                                                                              null
                                                                          ? AppImages
                                                                              .starNoFill
                                                                          : detailController
                                                                                      .doctorDetailsClass!
                                                                                      .data!
                                                                                      .avgratting! >=
                                                                                  4
                                                                              ? AppImages
                                                                                  .starFill
                                                                              : AppImages
                                                                                  .starNoFill,
                                                                      height: 17,
                                                                      width: 17,
                                                                    )),
                                                                    Expanded(
                                                                        child:
                                                                            Image.asset(
                                                                      detailController
                                                                                  .doctorDetailsClass!
                                                                                  .data!
                                                                                  .avgratting ==
                                                                              null
                                                                          ? AppImages
                                                                              .starNoFill
                                                                          : detailController
                                                                                      .doctorDetailsClass!
                                                                                      .data!
                                                                                      .avgratting! >=
                                                                                  5
                                                                              ? AppImages
                                                                                  .starFill
                                                                              : AppImages
                                                                                  .starNoFill,
                                                                      height: 17,
                                                                      width: 17,
                                                                    )),
                                                                  ],
                                                                ),
                                                                (1.5).hs
                                                              ],
                                                            ),
                                                          ),
                                                          AppTextWidgets.regularText(
                                                              text:
                                                                  " (${detailController.doctorDetailsClass!.data!.totalReview ?? 0} ${'review_str'.tr})",
                                                              size:
                                                                  detailController.page ==
                                                                          1
                                                                      ? 8
                                                                      : 10,
                                                              color: AppColors
                                                                  .LIGHT_GREY_TEXT),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await Get.toNamed(
                                                      Routes.doctorReviewScreen,
                                                      arguments: {
                                                        'id': detailController
                                                            .doctorDetailsClass!.data!.id
                                                            .toString()
                                                      },
                                                    )?.then((value) {
                                                      Get.delete<ReviewController>();
                                                      if (value ?? false) {
                                                        detailController
                                                            .fetchDoctorDetails();
                                                      }
                                                    });
                                                  },
                                                  child: AppTextWidgets.mediumText(
                                                    text: "see_all_review".tr,
                                                    color: Theme.of(context).hintColor,
                                                    size:  11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                        color: AppColors.WHITE,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (detailController.page == 1)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppTextWidgets.mediumText(
                                                      text: 'phone_number'.tr,
                                                      color: AppColors.BLACK,
                                                      size: 15,
                                                    ),
                                                    AppTextWidgets.mediumText(
                                                      text: detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .phoneno ??
                                                          "",
                                                      color: AppColors.LIGHT_GREY_TEXT,
                                                      size: 10,
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    launch(
                                                        "tel://${detailController.doctorDetailsClass!.data!.phoneno!}");
                                                  },
                                                  child: Image.asset(
                                                    AppImages.phoneIcon,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (detailController.page == 2)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppTextWidgets.mediumText(
                                                  text: detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .aboutus ==
                                                          null
                                                      ? " "
                                                      : 'about'.tr,
                                                  color: AppColors.BLACK,
                                                  size: 15,
                                                ),
                                                AppTextWidgets.mediumText(
                                                  text: detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .aboutus ==
                                                          null
                                                      ? " "
                                                      : detailController
                                                          .doctorDetailsClass!
                                                          .data!
                                                          .aboutus
                                                          .toString(),
                                                  color: AppColors.LIGHT_GREY_TEXT,
                                                  size:
                                                  // detailController.page == 1
                                                  //     ? 10
                                                  //     :
                                                  10,
                                                ),
                                              ],
                                            ),
                                          if (detailController.page == 2)
                                            4.hs,
                                          if (detailController.page == 2)
                                            Divider(
                                                thickness: 1,
                                                color: AppColors.greyShade3),
                                          if (detailController.page == 2)
                                            2.hs,
                                          if (detailController.page == 1)
                                            15.hs,
                                          if (detailController.page == 1)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppTextWidgets.mediumText(
                                                  text: detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .aboutus ==
                                                          null
                                                      ? " "
                                                      : 'about'.tr,
                                                  color: AppColors.BLACK,
                                                  size: 15,
                                                ),
                                                AppTextWidgets.mediumText(
                                                  text: detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .aboutus ==
                                                          null
                                                      ? " "
                                                      : detailController
                                                          .doctorDetailsClass!
                                                          .data!
                                                          .aboutus
                                                          .toString(),
                                                  color: AppColors.LIGHT_GREY_TEXT,
                                                  size: 10,
                                                ),
                                              ],
                                            ),
                                          if (detailController.page == 2)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppTextWidgets.mediumText(
                                                      text: 'phone_number'.tr,
                                                      color: AppColors.BLACK,
                                                      size: 14,
                                                    ),
                                                    AppTextWidgets.mediumText(
                                                      text: detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .phoneno ??
                                                          "",
                                                      color: AppColors.LIGHT_GREY_TEXT,
                                                      size:  10,
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    launch(
                                                        "tel://${detailController.doctorDetailsClass!.data!.phoneno!}");
                                                  },
                                                  child: Image.asset(
                                                    AppImages.phoneIcon,
                                                    height: 40,
                                                    width: 50,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (detailController.page == 2) 4.hs,

                                          if (detailController.page == 2)
                                            Divider(
                                                thickness: 1,
                                                color: AppColors.greyShade3),
                                          if (detailController.page == 2) 2.hs,
                                          if (detailController.page == 1) 15.hs,
                                          Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          AppTextWidgets.mediumText(
                                                            text: detailController
                                                                        .doctorDetailsClass!
                                                                        .data!
                                                                        .address ==
                                                                    null
                                                                ? " "
                                                                : 'address'.tr,
                                                            color: AppColors.BLACK,
                                                            size: 15,
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        child: AppTextWidgets.mediumText(
                                                          text: detailController
                                                                      .doctorDetailsClass!
                                                                      .data!
                                                                      .address ==
                                                                  null
                                                              ? " "
                                                              : detailController
                                                                  .doctorDetailsClass!
                                                                  .data!
                                                                  .address
                                                                  .toString(),
                                                          color:
                                                              AppColors.LIGHT_GREY_TEXT,
                                                          size:  10,
                                                        ),
                                                      ),
                                                      10.hs,
                                                      Row(
                                                        children: [
                                                          AppTextWidgets.mediumText(
                                                            text: detailController
                                                                        .doctorDetailsClass!
                                                                        .data!
                                                                        .workingTime ==
                                                                    null
                                                                ? " "
                                                                : 'working_time'.tr,
                                                            color: AppColors.BLACK,
                                                            size: 15,
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        child: AppTextWidgets.mediumText(
                                                          text: detailController
                                                                      .doctorDetailsClass!
                                                                      .data!
                                                                      .workingTime ==
                                                                  null
                                                              ? " "
                                                              : detailController
                                                                  .doctorDetailsClass!
                                                                  .data!
                                                                  .workingTime
                                                                  .toString(),
                                                          color:
                                                              AppColors.LIGHT_GREY_TEXT,
                                                          size: detailController.page == 1
                                                              ? 10
                                                              : 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                50.hs,
                                                Expanded(
                                                    flex: 2,
                                                    child: InkWell(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            child: InkWell(
                                                              onTap: () {
                                                                detailController.openMap(
                                                                    double.parse(
                                                                        detailController
                                                                            .doctorDetailsClass!
                                                                            .data!
                                                                            .lat!),
                                                                    double.parse(
                                                                        detailController
                                                                            .doctorDetailsClass!
                                                                            .data!
                                                                            .lon!));
                                                              },
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        15),
                                                                child: Stack(
                                                                  children: [
                                                                    detailController
                                                                                .doctorDetailsClass!
                                                                                .data!
                                                                                .address ==
                                                                            null
                                                                        ? Container()
                                                                        : Image.asset(
                                                                            AppImages
                                                                                .mapIcon,
                                                                            height: 100,
                                                                            width: 90,
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          if (detailController.page == 2) 4.hs,
                                          if (detailController.page == 2)
                                            Divider(
                                                thickness: 1,
                                                color: AppColors.greyShade3),
                                          if (detailController.page == 2) 2.hs,
                                          if (detailController.page == 1) 15.hs,
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppTextWidgets.mediumText(
                                                text: detailController.doctorDetailsClass!
                                                            .data!.services ==
                                                        null
                                                    ? " "
                                                    : 'services'.tr,
                                                color: AppColors.BLACK,
                                                size: 15,
                                              ),
                                              AppTextWidgets.mediumText(
                                                text: detailController.doctorDetailsClass!
                                                            .data!.services ==
                                                        null
                                                    ? ""
                                                    : detailController.doctorDetailsClass!
                                                        .data!.services
                                                        .toString(),
                                                color: AppColors.LIGHT_GREY_TEXT,
                                                size:
                                                    detailController.page == 1 ? 10 : 10,
                                              ),
                                              8.hs,
                                              if (detailController.page == 1)
                                                AppTextWidgets.mediumText(
                                                  text: detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .healthcare ==
                                                          null
                                                      ? " "
                                                      : 'health_care'.tr,
                                                  color: AppColors.BLACK,
                                                  size: 15,
                                                ),
                                              if (detailController.page == 1)
                                                AppTextWidgets.mediumText(
                                                  text: detailController
                                                              .doctorDetailsClass!
                                                              .data!
                                                              .healthcare ==
                                                          null
                                                      ? " "
                                                      : detailController
                                                          .doctorDetailsClass!
                                                          .data!
                                                          .healthcare
                                                          .toString(),
                                                  color: AppColors.LIGHT_GREY_TEXT,
                                                  size: 10,
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    8.hs,

                                    /// prescription button
                                    detailController.page == 2
                                        ? InkWell(
                                            onTap: () {
                                              detailController.showUploadRecipeSheet();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                  color: AppColors.WHITE,
                                                ),
                                                padding: EdgeInsets.all(12),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      height: 35,
                                                      width: 33,
                                                      AppImages.prescription,
                                                      color: AppColors.color1,
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
                                                          'send_prescription'.tr,
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.reportTextColor,
                                                            height: 1,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                AppFontStyleTextStrings
                                                                    .medium,
                                                          ),
                                                        ),
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
                                                        Icons.arrow_forward_outlined,
                                                        color: AppColors.reportTextColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),

                                    /// medicines button
                                    detailController.page == 2
                                        ? InkWell(
                                            onTap: () async {
                                              await Get.toNamed(
                                                Routes.pharmacyMedicineScreen,
                                                arguments: {'id': detailController.id},
                                              );
                                              Get.delete<PharmacyMedicineController>();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                  color: AppColors.WHITE,
                                                ),
                                                padding: EdgeInsets.all(12),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      height: 33,
                                                      width: 33,
                                                      AppImages.orderMedicines,
                                                      color: AppColors
                                                          .appointmentDetailsReportBgColor,
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
                                                          'order_medicine1'.tr,
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.reportTextColor,
                                                            height: 1,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                AppFontStyleTextStrings
                                                                    .medium,
                                                          ),
                                                        ),
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
                                                        Icons.arrow_forward_outlined,
                                                        color: AppColors.reportTextColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ),

                            /// show dialog
                            if (detailController.page == 1)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 63,
                                  margin: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: InkWell(
                                    onTap: () {
                                      detailController.processPayment();
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
                                          child: detailController.isLoggedIn.value
                                              ? Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(20),
                                                      ),
                                                      padding: const EdgeInsets.fromLTRB(
                                                          20, 5, 0, 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          AppTextWidgets.mediumText(
                                                            text:
                                                                "${CURRENCY.trim()}${detailController.doctorDetailsClass!.data!.consultationFee ?? 'not_specified'.tr}",
                                                            color: AppColors.WHITE,
                                                            size: 18,
                                                          ),
                                                          AppTextWidgets.mediumText(
                                                            text: 'book_now'.tr,
                                                            color: AppColors.WHITE,
                                                            size: 9,
                                                            maxline: 1,
                                                          ),
                                                        ],
                                                      ),
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
                                                    Expanded(child: 0.ws),
                                                    AppTextWidgets.mediumText(
                                                      text: 'book_now'.tr,
                                                      color: AppColors.WHITE,
                                                      size: 16,
                                                    ),
                                                    3.ws,
                                                    const Icon(
                                                      Icons.arrow_forward_ios_rounded,
                                                      color: AppColors.WHITE,
                                                      size: 16,
                                                    ),
                                                    12.ws,
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(20),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.fromLTRB(
                                                                  20, 5, 0, 5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              AppTextWidgets.mediumText(
                                                                text:
                                                                    "${CURRENCY.trim()}${detailController.doctorDetailsClass!.data!.consultationFee ?? 'not_specified'.tr}",
                                                                color: AppColors.WHITE,
                                                                size: 18,
                                                              ),
                                                              AppTextWidgets.mediumText(
                                                                text:
                                                                    'appointment_fee'.tr,
                                                                color: AppColors.WHITE,
                                                                size: 9,
                                                                  maxline: 1,
                                                              ),
                                                            ],
                                                          ),
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
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            right: 12, left: 10),
                                                        child: Text(
                                                          'login_to_book_appointment'.tr,
                                                          textAlign: TextAlign.right,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                            fontFamily:
                                                                AppFontStyleTextStrings
                                                                    .medium,
                                                            color: AppColors.WHITE,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
            ],
          )),
    );
  }
}
