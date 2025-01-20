import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

class DoctorPastAppointments extends GetView<DoctorPastAppointmentsController> {
  final DoctorPastAppointmentsController appointmentsController =
      Get.put(DoctorPastAppointmentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: CustomAppBar(
          // isBackArrow: true,
            onPressed: () {
              Get.back();
            },
            title: appointmentsController.isPharmacy.value
                ? 'all_orders'.tr
                : 'all_appointment'.tr,
            textStyle: Theme.of(context).textTheme.headlineSmall!.apply(
                color: Theme.of(context).scaffoldBackgroundColor, fontWeightDelta: 5)),
        leading: Container(),
      ),
      body: SingleChildScrollView(
        controller: appointmentsController.scrollController,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              /// is pharmacy order detail
              appointmentsController.isPharmacy.value
                  ? Obx(() => appointmentsController.isErrorInLoading.value
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
                      : appointmentsController.isLoaded.value
                          ? appointmentsController.isOrderAvailable.value == true
                              ? ListView.builder(
                                  itemCount: appointmentsController
                                      .pharmacyorderdetail!.data!.length,
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
                                                  'id': appointmentsController
                                                      .pharmacyorderdetail!
                                                      .data![index]
                                                      .id
                                                      .toString()
                                                })?.then((value) {
                                              Get.delete<DAppointmentDetailsController>();
                                              if (value ?? false) {
                                                appointmentsController.fetchPastOrder();
                                              }
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: CachedNetworkImage(
                                                    imageUrl: appointmentsController
                                                            .pharmacyorderdetail!
                                                            .data![index]
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
                                                              appointmentsController
                                                                      .pharmacyorderdetail!
                                                                      .data![index]
                                                                      .name ??
                                                                  "",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .apply(
                                                                      fontWeightDelta: 5),
                                                            ),
                                                            Text(
                                                              appointmentsController
                                                                      .pharmacyorderdetail!
                                                                      .data![index]
                                                                      .phone
                                                                      .toString() ??
                                                                  "",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .apply(
                                                                    fontWeightDelta: 2,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColorDark
                                                                        .withOpacity(0.5),
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
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
                                                              appointmentsController.pharmacyorderdetail!.data![index].status! == 0
                                                                  ? 'order_status_0'.tr
                                                                  : appointmentsController.pharmacyorderdetail!.data![index].status! == 1
                                                                      ? 'order_status_1'
                                                                          .tr
                                                                      : appointmentsController.pharmacyorderdetail!.data![index].status! == 2
                                                                          ? 'order_status_2'
                                                                              .tr
                                                                          : appointmentsController.pharmacyorderdetail!.data![index].status! == 3
                                                                              ? 'order_status_3'
                                                                                  .tr
                                                                              : appointmentsController.pharmacyorderdetail!.data![index].status! == 4
                                                                                  ? 'order_status_4'
                                                                                      .tr
                                                                                  : appointmentsController.pharmacyorderdetail!.data![index].status! == 5
                                                                                      ? 'order_status_5'.tr
                                                                                      : appointmentsController.pharmacyorderdetail!.data![index].status! == 6
                                                                                          ? 'order_status_6'.tr
                                                                                          : appointmentsController.pharmacyorderdetail!.data![index].status! == 7
                                                                                              ? 'order_status_7'.tr
                                                                                              : appointmentsController.pharmacyorderdetail!.data![index].status! == 8
                                                                                                  ? 'order_status_8'.tr
                                                                                                  : appointmentsController.pharmacyorderdetail!.data![index].status! == 8
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
                                                    AppTextWidgets.regularText(
                                                      text:
                                                          "${appointmentsController.pharmacyorderdetail!.data![index].createdAt?.substring(8, 10)}"
                                                          "${appointmentsController.pharmacyorderdetail!.data![index].createdAt?.substring(4, 8)}"
                                                          "${appointmentsController.pharmacyorderdetail!.data![index].createdAt?.substring(0, 4)}",
                                                      color: AppColors.LIGHT_GREY_TEXT,
                                                      size: 11,
                                                    ),
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
                                        text: 'pharmacy_not_order_text'.tr,
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


              /// is doctor appointment detail
                  : Obx(() => appointmentsController.isErrorInLoading.value
                      ? Center(
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
                        )
                      : appointmentsController.isLoaded.value
                          ? appointmentsController.isAppointmentAvailable.value
                              ? ListView.builder(
                                  itemCount:
                                      appointmentsController.nextUrl.value != "null"
                                          ? appointmentsController.list.length + 1
                                          : appointmentsController.list.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (appointmentsController.list.length == index) {
                                      return const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: SizedBox(
                                            height: 80,
                                            child: Center(
                                                child: CircularProgressIndicator())),
                                      );
                                    }
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          borderRadius: BorderRadius.circular(15),
                                          onTap: () async {
                                            await Get.toNamed(
                                                Routes.dAppointmentDetailScreen,
                                                arguments: {
                                                  'id': appointmentsController
                                                      .list[index].id
                                                      .toString()
                                                });
                                            Get.delete<DAppointmentDetailsController>();
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: CachedNetworkImage(
                                                    imageUrl: appointmentsController
                                                            .list[index].image ??
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
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            appointmentsController
                                                                    .list[index].name ??
                                                                "",
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .apply(
                                                                    fontWeightDelta: 5),
                                                          ),
                                                          Text(
                                                            appointmentsController
                                                                    .list[index].phone ??
                                                                "",
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
                                                      const SizedBox(
                                                        height: 5,
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
                                                              appointmentsController
                                                                      .list[index]
                                                                      .status ??
                                                                  "",
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
                                                        "${appointmentsController.list[index].date.toString().substring(8)}-${appointmentsController.list[index].date.toString().substring(5, 7)}-${appointmentsController.list[index].date.toString().substring(0, 4)}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall),
                                                    Text(
                                                        appointmentsController
                                                                .list[index].slot ??
                                                            "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .apply(fontWeightDelta: 2)),
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
                                        text: 'doctor_not_appointment_text'.tr,
                                        size: 11,
                                      ),
                                    ],
                                  ),
                                )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height - 100,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )),

              if (appointmentsController.isPharmacy.value == false)
                Obx(() => appointmentsController.isLoadingMore.value
                    ? const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: LinearProgressIndicator(),
                      )
                    : Container(
                        height: 50,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
