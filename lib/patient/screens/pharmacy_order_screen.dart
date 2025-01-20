import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';


class PharmacyOrderScreen extends GetView<UserPastAppointmentsController> {
  final UserPastAppointmentsController pharmacyOrderController =
      Get.put(UserPastAppointmentsController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Container(
                child:
                    ListView.builder(
              itemCount: pharmacyOrderController.orderlist.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                if (pharmacyOrderController.orderlist.length == index) {
                  return const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: LinearProgressIndicator(),
                  );
                }
                else {
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Get.toNamed(Routes.uAppointmentDetailScreen, arguments: {
                        "id": pharmacyOrderController.orderlist[index].id.toString(),
                        "bool": true,

                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.WHITE,
                        ),
                        child: Row(
                          children: [
                            pharmacyOrderController.orderlist[index].pharmacyImage
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
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: pharmacyOrderController
                                            .orderlist[index].pharmacyImage!,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) => Container(
                                          color: Theme.of(context).primaryColorLight,
                                          child: Image.asset(
                                            AppImages.tab3dUnselect,
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        errorWidget: (context, url, err) => Container(
                                            color: Theme.of(context).primaryColorLight,
                                            child: Image.asset(
                                              AppImages.tab3dUnselect,
                                              height: 20,
                                              width: 20,
                                            )),
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: Theme.of(context).primaryColorLight,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppTextWidgets.mediumText(
                                          text:
                                              "${'order_id'.tr}${pharmacyOrderController.orderlist[index].id.toString() ?? ""}",
                                          color: AppColors.color1,
                                          size: 14,
                                        ),
                                        2.hs,
                                        AppTextWidgets.semiBoldText(
                                          text: pharmacyOrderController
                                                  .orderlist[index].pharmacyName
                                                  .toString() ??
                                              "",
                                          color: AppColors.BLACK,
                                          size: 13,
                                        ),
                                        2.hs,
                                        Text(
                                          pharmacyOrderController
                                                  .orderlist[index].pharmacyAddress ??
                                              "",
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: AppFontStyleTextStrings.medium,
                                            color: AppColors.LIGHT_GREY_TEXT,
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
                                      "${pharmacyOrderController.orderlist[index].createdAt?.substring(8, 10)}"
                                      "${pharmacyOrderController.orderlist[index].createdAt?.substring(4, 8)}"
                                      "${pharmacyOrderController.orderlist[index].createdAt?.substring(0, 4)}",
                                  color: AppColors.LIGHT_GREY_TEXT,
                                  size: 11,
                                ),
                                Row(
                                  children: [
                                    AppTextWidgets.regularText(
                                      text:
                                          "${pharmacyOrderController.orderlist[index].createdAt?.substring(11, 16)}",
                                      color: AppColors.BLACK,
                                      size: 15,
                                    ),
                                    if(pharmacyOrderController.ampm1!= null)
                                    AppTextWidgets.regularText(
                                      text:
                                          " ${pharmacyOrderController.ampm1![index]}",
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
                  );
                }
              },
            )
                //     : Container(
                //   width: MediaQuery
                //       .of(context)
                //       .size
                //       .width,
                //   decoration: BoxDecoration(
                //     color: Theme
                //         .of(context)
                //         .scaffoldBackgroundColor,
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   padding: const EdgeInsets.all(30.0),
                //   margin: const EdgeInsets.only(top: 10.0),
                //   child: Column(
                //     children: [
                //       Image.asset(
                //         AppImages.noAppointment,
                //       ),
                //       15.hs,
                //       AppTextWidgets.blackTextWithSize(
                //         text: 'not_appointment1'.tr,
                //         size: 11,
                //       ),
                //       3.hs,
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           AppTextWidgets.mediumTextWithSize(
                //             text: 'not_appointment2'.tr,
                //             size: 10,
                //           ),
                //           3.ws,
                //           InkWell(
                //             onTap: () async {
                //               await Get.toNamed(Routes.specialityScreen);
                //               Get.delete<SpecialityController>();
                //             },
                //             child: AppTextWidgets.blackText(
                //               text: 'not_appointment3'.tr,
                //               size: 10,
                //               color: AppColors.AMBER,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                ),
          );
        }));
  }
}
