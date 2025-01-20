import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

import '../controllers/pharmacy_edit_medicine_controller.dart';

class PharmacyMedicineEditScreen extends GetView<DMoreInfoController> {

  final DMoreInfoController controller = Get.put(DMoreInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: CustomAppBar(
          isBackArrow: true,
          onPressed: () => Get.back(),
          title: "add_medicine_str".tr,
          textStyle: Theme.of(context).textTheme.headlineSmall!.apply(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontWeightDelta: 5,
          ),
        ),
        leading: Container(),
      ),
      body: 
      Container(
        child: controller.step1(context: context),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(12.0),
      //   child: Obx(() {
      //     return Column(
      //       children: [
      //         Container(
      //           child: InkWell(
      //               onTap: () async {},
      //               child: Container(
      //                 alignment: Alignment.center,
      //                 decoration: BoxDecoration(
      //                     gradient: const LinearGradient(
      //                       colors: [
      //                         AppColors.color1,
      //                         AppColors.color2,
      //                       ],
      //                       begin: Alignment.bottomLeft,
      //                       end: Alignment.topRight,
      //                     ),
      //                     borderRadius: BorderRadius.circular(15)),
      //                 height: 50,
      //                 width: Get.width,
      //                 child: Text(
      //                   'add_medicine_plus'.tr,
      //                   style: Theme.of(context).textTheme.bodyLarge!.apply(
      //                       fontWeightDelta: 1, color: AppColors.WHITE, fontSizeDelta: 5),
      //                 ),
      //               )),
      //         ),
      //         controller.isLoaded.value
      //         // ?Text("data")
      //             ?Container(
      //           height: Get.height - 215,
      //           child: ListView.builder(
      //             controller: controller.allMedicineScrollController,
      //             itemCount: controller.medicineAllData!.data!.data1!.length,
      //             itemBuilder: (context, index) {
      //               return InkWell(
      //                 // onTap: () async {
      //                 // if (pharmacyMedicineController
      //                 //     .processedIndices
      //                 //     .contains(int.parse(
      //                 // pharmacyMedicineController
      //                 //     .mostUsedMedicineList[index].id
      //                 //     .toString()))) {
      //                 // return pharmacyMedicineController
      //                 //     .showToastMessage(
      //                 // msg: 'already_added'.tr);
      //                 // }
      //                 // // Add the index to the processed set
      //                 // pharmacyMedicineController.processedIndices
      //                 //     .add(int.parse(pharmacyMedicineController
      //                 //     .mostUsedMedicineList[index].id
      //                 //     .toString()));
      //                 //
      //                 // pharmacyMedicineController.itemcount.value =
      //                 // pharmacyMedicineController
      //                 //     .itemcount.value +
      //                 // 1;
      //                 // pharmacyMedicineController
      //                 //     .mostUsedMedicineCheak[index] ==
      //                 // true
      //                 // ? pharmacyMedicineController.cnt.value--
      //                 //     : pharmacyMedicineController.cnt.value++;
      //                 // pharmacyMedicineController
      //                 //     .mostUsedMedicineCheak[index] =
      //                 // !pharmacyMedicineController
      //                 //     .mostUsedMedicineCheak[index];
      //                 //
      //                 // List<CartMedicine> cartData =
      //                 // await Get.find<DBHelperCart>()
      //                 //     .getCartList();
      //                 // bool? st = false;
      //                 // if (cartData.isNotEmpty &&
      //                 // cartData.first.pId !=
      //                 // int.parse(
      //                 // pharmacyMedicineController.id)) {
      //                 // st = await medicineCartDialog();
      //                 // if (st ?? false) {
      //                 // await Get.find<DBHelperCart>()
      //                 //     .truncateTable();
      //                 // } else {
      //                 // st = false;
      //                 // }
      //                 // } else {
      //                 // st = true;
      //                 // }
      //                 // if (st ?? false) {
      //                 // {
      //                 // for (int i = 0;
      //                 // i <
      //                 // pharmacyMedicineController
      //                 //     .mostUsedMedicineList.length;
      //                 // i++) {
      //                 // if (pharmacyMedicineController
      //                 //     .mostUsedMedicineCheak[i]) {
      //                 // await DBHelperCart().save(
      //                 // CartMedicine(
      //                 // price:
      //                 // "${pharmacyMedicineController.mostUsedMedicineList[i].price}",
      //                 // name: pharmacyMedicineController
      //                 //     .mostUsedMedicineList[i].name,
      //                 // mId: pharmacyMedicineController
      //                 //     .mostUsedMedicineList[i].id,
      //                 // description:
      //                 // pharmacyMedicineController
      //                 //     .mostUsedMedicineList[i]
      //                 //     .description,
      //                 // image: pharmacyMedicineController
      //                 //     .mostUsedMedicineList[i]
      //                 //     .image,
      //                 // pId: int.parse(
      //                 // pharmacyMedicineController
      //                 //     .id),
      //                 // ),
      //                 // );
      //                 // }
      //                 // }
      //                 // // await Get.toNamed(Routes.viewCartMedicineScreen);
      //                 // pharmacyMedicineController
      //                 //     .mostUsedMedicineCheak.value =
      //                 // List.filled(
      //                 // pharmacyMedicineController
      //                 //     .mostUsedMedicineList.length,
      //                 // false);
      //                 // Get.delete<ViewCartController>();
      //                 // pharmacyMedicineController
      //                 //     .getCartLength();
      //                 // }
      //                 // }
      //                 // },
      //                 child: Container(
      //                   margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      //                   decoration: BoxDecoration(
      //                     color: AppColors.WHITE,
      //                     borderRadius: BorderRadius.circular(12),
      //                   ),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: [
      //                       const SizedBox(
      //                         width: 12,
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(vertical: 12.0),
      //                         child: Container(
      //                           width: 90,
      //                           height: 95,
      //                           decoration: BoxDecoration(
      //                             border: Border.all(
      //                               color: AppColors.greyShade3,
      //                             ),
      //                             borderRadius: BorderRadius.circular(12),
      //                           ),
      //                           child: Container(
      //                             width: 60,
      //                             height: 60,
      //                             margin: const EdgeInsets.symmetric(
      //                                 vertical: 0, horizontal: 0),
      //                             child: controller.medicineAllData!.data!.data1![index].image ==
      //                                 "null"
      //                                 ? Container(
      //                               alignment: Alignment.center,
      //                               decoration: BoxDecoration(
      //                                 borderRadius: BorderRadius.circular(12),
      //                                 color: Color(0xFFEEEEEE),
      //                               ),
      //                               child: Opacity(
      //                                 opacity: 0.60,
      //                                 child: ClipRRect(
      //                                   borderRadius:
      //                                   BorderRadius.circular(12),
      //                                   child: Image.asset(
      //                                     AppImages.medicine1,
      //                                     fit: BoxFit.contain,
      //                                     height: 50,
      //                                     width: 50,
      //                                   ),
      //                                 ),
      //                               ),
      //                             )
      //                                 : ClipRRect(
      //                               borderRadius: BorderRadius.circular(12),
      //                               child: Image.network(
      //                                 width: 40,
      //                                 height: 40,
      //                                 fit: BoxFit.cover,
      //                                 "${Apis.medicineImage}${controller.medicineAllData!.data!.data1![index].image}",
      //                                 errorBuilder:
      //                                     (context, error, stackTrace) {
      //                                   return Image.asset(
      //                                     AppImages.medicine1,
      //                                   );
      //                                 },
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       const SizedBox(width: 10),
      //                       Expanded(
      //                         child: Padding(
      //                           padding: const EdgeInsets.symmetric(
      //                             vertical: 12.0,
      //                           ),
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Row(
      //                                 children: [
      //                                   Expanded(
      //                                     flex: 10,
      //                                     child: Text(
      //                                       controller.medicineAllData!.data!.data1![index].name ??
      //                                           "",
      //                                       maxLines: 1,
      //                                       overflow: TextOverflow.ellipsis,
      //                                       style: TextStyle(
      //                                         fontSize: 15,
      //                                         fontFamily: AppFontStyleTextStrings.medium,
      //                                         color: AppColors.reportTextColor,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                   Spacer(),
      //                                 ],
      //                               ),
      //                               const SizedBox(height: 4),
      //                               Text(
      //                                 (double.parse(controller.medicineAllData!.data!.data1![index]
      //                                     .price!.toString())
      //                                     .toStringAsFixed(1)).toString() +
      //                                     CURRENCY,
      //                                 maxLines: 2,
      //                                 style: TextStyle(
      //                                   fontFamily: AppFontStyleTextStrings.medium,
      //                                   fontSize: 15,
      //                                   color: AppColors.grey,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: EdgeInsets.only(right: 12.0),
      //                         child: Column(
      //                           children: [
      //                             InkWell(
      //                                 onTap: () {
      //
      //                                 },
      //                                 child: Icon(Icons.edit)),
      //                             SizedBox(height: 5,),
      //                             InkWell(
      //                                 onTap: () {
      //
      //                                 },
      //                                 child: Icon(Icons.delete)),
      //                           ],
      //                         ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         )
      //             : Center(
      //           child: CircularProgressIndicator(
      //             valueColor: AlwaysStoppedAnimation(Theme.of(context).hintColor),
      //           ),
      //         )
      //       ],
      //     );
      //   }),
      // ),
    );
  }
}
