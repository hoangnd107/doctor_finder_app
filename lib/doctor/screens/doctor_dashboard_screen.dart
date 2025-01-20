import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

class DoctorDashboard extends GetView<DoctorDashboardController> {
  final DoctorDashboardController dashboardController =
      Get.put(DoctorDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: CustomAppBar(
          title:
          dashboardController.isPharmacy.value
          ? 'pharmacy_dashboard'.tr
          : 'doctor_dashboard'.tr,
          textStyle: Theme.of(context).textTheme.headlineSmall!.apply(
              color: Theme.of(context).scaffoldBackgroundColor, fontWeightDelta: 5),
        ),
        leading: Container(),
      ),
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      body: SmartRefresher(
        controller: dashboardController.refreshController,
        onRefresh: dashboardController.onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => dashboardController.isErrorInProfileLoading.value
                  ? Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.search_off_rounded,
                              size: 75,
                              color: AppColors.LIGHT_GREY_TEXT,
                            ),
                            const SizedBox(
                              height: 10,
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
                  : dashboardController.isProfileLoaded.value
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: (dashboardController
                                                  .doctorProfileWithRating!.data?.image ==
                                              (Apis.doctorImagePath + "user.png") ||
                                          dashboardController
                                                  .doctorProfileWithRating!.data?.image ==
                                              "user.png")
                                      ? ""
                                      : dashboardController
                                              .doctorProfileWithRating!.data!.image!
                                              .contains(Apis.doctorImagePath)
                                          ? dashboardController
                                              .doctorProfileWithRating!.data!.image!
                                          : (Apis.doctorImagePath +
                                              "${dashboardController.doctorProfileWithRating!.data!.image!}"),
                                  height: 85,
                                  width: 85,
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
                                            dashboardController
                                                .doctorProfileWithRating!.data!.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .apply(fontWeightDelta: 2),
                                          ),
                                          Row(
                                            children: [
                                              ///add category
                                              dashboardController.isPharmacy.value
                                                  ? Text("")
                                                  : Text(
                                                      dashboardController
                                                              .doctorProfileWithRating!
                                                              .data!
                                                              .departmentName!
                                                              .isEmpty
                                                          ? 'speciality'.tr
                                                          : dashboardController
                                                                  .doctorProfileWithRating!
                                                                  .data!
                                                                  .departmentName ??
                                                              'speciality'.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .apply(
                                                              color: Theme.of(context)
                                                                  .primaryColorDark),
                                                    ),
                                              if (dashboardController.isPharmacy.value ==
                                                  false)
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              dashboardController
                                                          .doctorProfileWithRating !=
                                                      null
                                                  ? dashboardController.buildRatingStars(
                                                      double.parse(
                                                          "${dashboardController.doctorProfileWithRating!.data?.avgratting}"),
                                                    )
                                                  : Image.asset(
                                                      AppImages.starFill,
                                                      height: 15,
                                                      width: 15,
                                                    ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                double.parse(dashboardController
                                                            .doctorProfileWithRating!
                                                            .data
                                                            ?.avgratting
                                                            .toString() ??
                                                        "0.0")
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .apply(
                                                        color: Theme.of(context)
                                                            .primaryColorDark),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          dashboardController.isPharmacy.value ? 2 : 10,
                                    ),
                                    Container(
                                      child: Text(
                                        dashboardController
                                                .doctorProfileWithRating!.data!.address ??
                                            'no_address'.tr,
                                        style:
                                            Theme.of(context).textTheme.bodySmall!.apply(
                                                  color: Theme.of(context)
                                                      .primaryColorDark
                                                      .withOpacity(0.4),
                                                  fontSizeDelta: 0.1,
                                                ),
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
                        )
                      : Container(
                          height: 100,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        )),

              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return Text(
                            dashboardController.isPharmacy.value
                                ? 'order_str'.tr
                                : 'appointments_str'.tr,
                            style: Theme.of(context).textTheme.titleMedium,
                          );
                        }),
                        TextButton(
                          onPressed: () async {
                            if(dashboardController.isPharmacy.value == false) {
                              await Get.toNamed(Routes.dAllAppointmentsScreen);
                              Get.delete<DAllAppointmentsController>();
                            }else{
                              await Get.toNamed(Routes.dAllAppointmentsScreen);
                              Get.delete<DAllAppointmentsController>();

                              // Get.to(DoctorPastAppointments(),arguments: {'all':true});
                              // Get.delete<DoctorPastAppointmentsController>();


                            }
                          },
                          child: Text('see_all'.tr,
                              style: Theme.of(context).textTheme.bodyMedium!.apply(
                                    color: Theme.of(context).hintColor,
                                    fontWeightDelta: 5,
                                  )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    ///order or appointment
                    dashboardController.isPharmacy.value
                    /// pharmacy order
                        ? Obx(() => dashboardController.isErrorInLoading.value
                            ? Container(
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Icon(
                                        Icons.search_off_rounded,
                                        size: 100,
                                        color: AppColors.LIGHT_GREY_TEXT,
                                      ),
                                      const SizedBox(
                                        height: 10,
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
                            : dashboardController.isLoaded.value
                                ? dashboardController.isOrderAvailable.value == true
                                    ? ListView.builder(
                                        itemCount: dashboardController
                                            .pharmacyorderdetail!
                                            .data!
                                            .length,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                borderRadius: BorderRadius.circular(15),
                                                onTap: () async {
                                                  await Get.toNamed(
                                                      Routes.dAppointmentDetailScreen,
                                                      arguments: {
                                                        'id': dashboardController
                                                            .pharmacyorderdetail!
                                                            .data![index]
                                                            .id
                                                            .toString()
                                                      })?.then((value) {
                                                    Get.delete<
                                                        DAppointmentDetailsController>();
                                                    if (value ?? false) {
                                                      dashboardController
                                                          .fetchPharmacyOrder();
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 5),
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(15),
                                                        child: CachedNetworkImage(
                                                          imageUrl: dashboardController
                                                                  .pharmacyorderdetail!
                                                                  .data![index].image ??
                                                              " ",
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
                                                          errorWidget:
                                                              (context, url, err) =>
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
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    dashboardController
                                                                        .pharmacyorderdetail!
                                                                        .data![index]
                                                                            .name ??
                                                                        "",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .apply(
                                                                            fontWeightDelta:
                                                                                5),
                                                                  ),
                                                                  Text(
                                                                    dashboardController
                                                                        .pharmacyorderdetail!
                                                                        .data![index]
                                                                            .phone.toString() ??
                                                                        "",
                                                                    style:
                                                                        Theme.of(context)
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
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets.all(5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(15),
                                                                  color: Theme.of(context)
                                                                      .primaryColorLight),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize.min,
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
                                                                    dashboardController.pharmacyorderdetail!.data![index].status! == 0
                                                                        ? 'order_status_0'.tr
                                                                        : dashboardController.pharmacyorderdetail!.data![index].status! == 1
                                                                        ? 'order_status_1'
                                                                        .tr
                                                                        : dashboardController.pharmacyorderdetail!.data![index].status! == 2
                                                                        ? 'order_status_2'
                                                                        .tr
                                                                        : dashboardController.pharmacyorderdetail!.data![index].status! == 3
                                                                        ? 'order_status_3'
                                                                        .tr
                                                                        : dashboardController.pharmacyorderdetail!.data![index].status! == 4
                                                                        ? 'order_status_4'
                                                                        .tr
                                                                        : dashboardController.pharmacyorderdetail!.data![index].status! == 5
                                                                        ? 'order_status_5'.tr
                                                                        : dashboardController.pharmacyorderdetail!.data![index].status! == 6
                                                                        ? 'order_status_6'.tr
                                                                        : dashboardController.pharmacyorderdetail!.data![index].status! == 7
                                                                        ? 'order_status_7'.tr
                                                                        : dashboardController.pharmacyorderdetail!.data![index].status! == 8
                                                                        ? 'order_status_8'.tr
                                                                        : dashboardController.pharmacyorderdetail!.data![index].status! == 8
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

                                                          // Text(
                                                          //     dashboardController
                                                          //         .pharmacyorderdetail!
                                                          //         .data![index]
                                                          //             .createdAt
                                                          //             .toString()
                                                          //             .substring(8) +
                                                          //         "-" +
                                                          //         dashboardController
                                                          //             .pharmacyorderdetail!
                                                          //             .data![index]
                                                          //             .createdAt
                                                          //             .toString()
                                                          //             .substring(5, 7) +
                                                          //         "-" +
                                                          //         dashboardController
                                                          //             .pharmacyorderdetail!
                                                          //             .data![index]
                                                          //             .createdAt
                                                          //             .toString()
                                                          //             .substring(0, 4),
                                                          //     style: Theme.of(context)
                                                          //         .textTheme
                                                          //         .bodySmall),

                                                          AppTextWidgets.regularText(
                                                            text:
                                                            "${ dashboardController
                                                                .pharmacyorderdetail!
                                                                .data![index].createdAt?.substring(8, 10)}"
                                                                "${ dashboardController
                                                                .pharmacyorderdetail!
                                                                .data![index].createdAt?.substring(4, 8)}"
                                                                "${ dashboardController
                                                                .pharmacyorderdetail!
                                                                .data![index].createdAt?.substring(0, 4)}",
                                                            color: AppColors.LIGHT_GREY_TEXT,
                                                            size: 11,
                                                          ),
                                                          // Text(
                                                          //     dashboardController
                                                          //             .doctorAppointmentsClass!
                                                          //             .data!
                                                          //             .doctorAppointmentData![
                                                          //                 index]
                                                          //             .slot ??
                                                          //         "",
                                                          //     style: Theme.of(context)
                                                          //         .textTheme
                                                          //         .bodyLarge!
                                                          //         .apply(
                                                          //             fontWeightDelta:
                                                          //                 2)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              // Text("data")
                                            ],
                                          );
                                        },
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.WHITE,
                                            borderRadius: BorderRadius.circular(15)),
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Image.asset(AppImages.noAppointment),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            AppTextWidgets.blackTextWithSize(
                                              text: dashboardController.isPharmacy.value
                                                  ? 'pharmacy_not_order_text'.tr
                                                  : 'doctor_not_appointment_text'.tr,
                                              size: 11,
                                            ),
                                          ],
                                        ),
                                      )
                                : Container(
                                    height: 150,
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(),
                                  ))
                    /// doctor appointment
                        : Obx(() => dashboardController.isErrorInLoading.value
                            ? Container(
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Icon(
                                        Icons.search_off_rounded,
                                        size: 100,
                                        color: AppColors.LIGHT_GREY_TEXT,
                                      ),
                                      const SizedBox(
                                        height: 10,
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
                            : dashboardController.isLoaded.value
                                ? dashboardController.isAppointmentAvailable.value
                                    ? ListView.builder(
                                        itemCount: dashboardController
                                            .doctorAppointmentsClass!
                                            .data!
                                            .doctorAppointmentData!
                                            .length,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                borderRadius: BorderRadius.circular(15),
                                                onTap: () async {
                                                  await Get.toNamed(
                                                      Routes.dAppointmentDetailScreen,
                                                      arguments: {
                                                        'id': dashboardController
                                                            .doctorAppointmentsClass!
                                                            .data!
                                                            .doctorAppointmentData![index]
                                                            .id
                                                            .toString()
                                                      })?.then((value) {
                                                    Get.delete<
                                                        DAppointmentDetailsController>();
                                                    if (value ?? false) {
                                                      dashboardController
                                                          .fetchDoctorAppointment();
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 5),
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(15),
                                                        child: CachedNetworkImage(
                                                          imageUrl: dashboardController
                                                                  .doctorAppointmentsClass!
                                                                  .data!
                                                                  .doctorAppointmentData![
                                                                      index]
                                                                  .image ??
                                                              " ",
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
                                                          errorWidget:
                                                              (context, url, err) =>
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
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    dashboardController
                                                                            .doctorAppointmentsClass!
                                                                            .data!
                                                                            .doctorAppointmentData![
                                                                                index]
                                                                            .name ??
                                                                        "",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .apply(
                                                                            fontWeightDelta:
                                                                                5),
                                                                  ),
                                                                  Text(
                                                                    dashboardController
                                                                            .doctorAppointmentsClass!
                                                                            .data!
                                                                            .doctorAppointmentData![
                                                                                index]
                                                                            .phone ??
                                                                        "",
                                                                    style:
                                                                        Theme.of(context)
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
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets.all(5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(15),
                                                                  color: Theme.of(context)
                                                                      .primaryColorLight),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize.min,
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
                                                                    dashboardController
                                                                            .doctorAppointmentsClass!
                                                                            .data!
                                                                            .doctorAppointmentData![
                                                                                index]
                                                                            .status ??
                                                                        "",
                                                                    style:
                                                                        Theme.of(context)
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
                                                              dashboardController
                                                                      .doctorAppointmentsClass!
                                                                      .data!
                                                                      .doctorAppointmentData![
                                                                          index]
                                                                      .date
                                                                      .toString()
                                                                      .substring(8) +
                                                                  "-" +
                                                                  dashboardController
                                                                      .doctorAppointmentsClass!
                                                                      .data!
                                                                      .doctorAppointmentData![
                                                                          index]
                                                                      .date
                                                                      .toString()
                                                                      .substring(5, 7) +
                                                                  "-" +
                                                                  dashboardController
                                                                      .doctorAppointmentsClass!
                                                                      .data!
                                                                      .doctorAppointmentData![
                                                                          index]
                                                                      .date
                                                                      .toString()
                                                                      .substring(0, 4),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall),
                                                          Text(
                                                              dashboardController
                                                                      .doctorAppointmentsClass!
                                                                      .data!
                                                                      .doctorAppointmentData![
                                                                          index]
                                                                      .slot ??
                                                                  "",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .apply(
                                                                      fontWeightDelta:
                                                                          2)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.WHITE,
                                            borderRadius: BorderRadius.circular(15)),
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Image.asset(AppImages.noAppointment),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            AppTextWidgets.blackTextWithSize(
                                              text: dashboardController.isPharmacy.value
                                                  ? 'pharmacy_not_order_text'.tr
                                                  : 'doctor_not_appointment_text'.tr,
                                              size: 11,
                                            ),
                                          ],
                                        ),
                                      )
                                : Container(
                                    height: 150,
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(),
                                  )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
