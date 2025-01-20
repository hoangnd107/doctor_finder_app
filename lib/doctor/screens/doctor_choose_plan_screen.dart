import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

class DoctorChooseYourPlanScreen
    extends GetView<DoctorChooseYourPlanController> {
  final DoctorChooseYourPlanController choosePlanController =
      Get.put(DoctorChooseYourPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
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
                      height: 100,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl:
                                  choosePlanController.doctorImageUrl.value,
                              height: 100,
                              width: 100,
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
                            height: 5,
                          ),
                          Text(
                            '${'hello'.tr}${choosePlanController.userName.value}',
                            style: Theme.of(context).textTheme.titleMedium!.apply(
                                fontSizeFactor: 1.2,
                                color: AppColors.LIGHT_BLACK_TEXT),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'choose_your_plan'.tr,
                  style: Theme.of(context).textTheme.titleMedium!.apply(
                        fontSizeFactor: 1.2,
                        fontWeightDelta: 2,
                        color: AppColors.choosePlanColor,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                choosePlanController.isErrorInLoading.value
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
                    : FutureBuilder(
                        future: choosePlanController.future,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              choosePlanController.userId.isEmpty) {
                            return const SizedBox(
                                height: 300.0,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                )));
                          }
                          return Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.only(left: 20),
                            height: 300.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                var data = choosePlanController
                                    .getSubscriptionPlanClass!
                                    .data!
                                    .data![index];

                                choosePlanController.price.value =
                                    choosePlanController
                                        .getSubscriptionPlanClass!
                                        .data!
                                        .data![index]
                                        .price!;
                                return GestureDetector(
                                  onTap: () {
                                    choosePlanController.selectedIndex.value =
                                        index;
                                    choosePlanController.selectedAmount1.value =
                                        choosePlanController
                                            .getSubscriptionPlanClass!
                                            .data!
                                            .data![index]
                                            .price!;

                                    choosePlanController.selectedSubId.value =
                                        data.id ?? 0;

                                    choosePlanController.price.value =
                                        choosePlanController
                                            .getSubscriptionPlanClass!
                                            .data!
                                            .data![index]
                                            .price!;
                                  },
                                  child: Stack(
                                    alignment: Alignment.topLeft,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        height: 230.0,
                                        width: 200,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              elevation: 0,
                                              child: Obx(
                                                () => AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        choosePlanController
                                                                    .selectedIndex
                                                                    .value ==
                                                                index
                                                            ? AppColors.color1
                                                            : AppColors.WHITE,
                                                        choosePlanController
                                                                    .selectedIndex
                                                                    .value ==
                                                                index
                                                            ? AppColors.color2
                                                            : AppColors.WHITE,
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      stops: const [0.0, 1.0],
                                                      tileMode: TileMode.clamp,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 22),
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 27),
                                                          child: Text(
                                                              data.month == 1
                                                                  ? 'choose_plan_t1'
                                                                      .tr
                                                                  : data.month ==
                                                                          3
                                                                      ? 'choose_plan_t2'
                                                                          .tr
                                                                      : data.month ==
                                                                              6
                                                                          ? 'choose_plan_t3'
                                                                              .tr
                                                                          : data.month ==
                                                                                  12
                                                                              ? 'choose_plan_t4'
                                                                                  .tr
                                                                              : '${data.month} ${'month_str'.tr.toLowerCase()}',
                                                              style: TextStyle(
                                                                  color: choosePlanController
                                                                              .selectedIndex
                                                                              .value ==
                                                                          index
                                                                      ? AppColors
                                                                          .WHITE
                                                                      : AppColors
                                                                          .chooseColor,
                                                                  fontSize: 23,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 22),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text:
                                                                '$CURRENCY${data.price}/',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .apply(
                                                                    color: choosePlanController
                                                                                .selectedIndex.value ==
                                                                            index
                                                                        ? AppColors
                                                                            .WHITE
                                                                        : AppColors
                                                                            .BLACK,
                                                                    fontSizeFactor:
                                                                        1.6,
                                                                    fontWeightDelta:
                                                                        2),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text: index == 0
                                                                    ? '${data.month} ${'month_str'.tr.toLowerCase()}'
                                                                    : index == 1
                                                                        ? '${data.month} ${'month_str'.tr.toLowerCase()}'
                                                                        : index ==
                                                                                2
                                                                            ? '${data.month} ${'month_str'.tr.toLowerCase()}'
                                                                            : '${data.month} ${'month_str'.tr.toLowerCase()}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium!
                                                                    .apply(
                                                                        color: choosePlanController.selectedIndex.value ==
                                                                                index
                                                                            ? AppColors
                                                                                .WHITE
                                                                            : AppColors
                                                                                .BLACK,
                                                                        fontSizeFactor:
                                                                            1.0,
                                                                        fontWeightDelta:
                                                                            9),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons.add,
                                                                  size: 20,
                                                                  color: AppColors
                                                                      .iconColor,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    'save_str'
                                                                        .tr,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleMedium!
                                                                        .apply(
                                                                            color: AppColors
                                                                                .LIGHT_BLACK_TEXT,
                                                                            fontSizeFactor:
                                                                                0.8,
                                                                            fontWeightDelta:
                                                                                1),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons.add,
                                                                  size: 20,
                                                                  color: AppColors
                                                                      .iconColor,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'access_text'
                                                                            .tr,
                                                                        style: Theme.of(context).textTheme.titleMedium!.apply(
                                                                            color: choosePlanController.selectedIndex.value == index
                                                                                ? AppColors.WHITE
                                                                                : AppColors.BLACK,
                                                                            fontSizeFactor: 0.8,
                                                                            fontWeightDelta: 6),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons.add,
                                                                  size: 20,
                                                                  color: AppColors
                                                                      .iconColor,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    'available_text'
                                                                        .tr,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleMedium!
                                                                        .apply(
                                                                            color: AppColors
                                                                                .LIGHT_BLACK_TEXT,
                                                                            fontSizeFactor:
                                                                                0.8,
                                                                            fontWeightDelta:
                                                                                1),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      Obx(() => AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            child: choosePlanController
                                                        .selectedIndex.value ==
                                                    index
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    decoration:
                                                        const BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                AppColors
                                                                    .checkColor1,
                                                                AppColors
                                                                    .checkColor2,
                                                              ],
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                            ),
                                                            shape: BoxShape
                                                                .circle),
                                                    child: const Icon(
                                                      Icons.check,
                                                      color: AppColors.WHITE,
                                                      size: 50,
                                                    ),
                                                  )
                                                : Container(),
                                          ))
                                    ],
                                  ),
                                );
                              },
                              itemCount: 4,
                            ),
                          );
                        }),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    'choose_plan_des'.tr,
                    style: Theme.of(context).textTheme.titleMedium!.apply(
                        color: AppColors.LIGHT_BLACK_TEXT,
                        fontSizeFactor: 0.8,
                        fontWeightDelta: 0),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    choosePlanController.bottomSheet(
                        choosePlanController
                            .getSubscriptionPlanClass!.data!.currency,
                        choosePlanController.selectedAmount1.value,
                        choosePlanController.selectedSubId.value);
                  },
                  child: Container(
                    height: 60,
                    width: 330,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.color1,
                            AppColors.color2,
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: AppTextWidgets.blackText(
                      text: 'continue_purchase'.tr,
                      color: AppColors.WHITE,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ));
  }
}
