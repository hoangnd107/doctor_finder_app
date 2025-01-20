import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/model/medicine_data_model.dart';

import '../utils/doctor_imports.dart';

class PharmacyEditMedicineController extends GetxController {


  RxString doctorId = "".obs;
  RxBool isErrorInLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isPharmacy = false.obs;

  DoctorProfileWithRating? doctorProfileWithRating;
  MedicineAllData1? medicineAllData;

  ScrollController allMedicineScrollController = ScrollController();


    @override
    void onInit() {
      // TODO: implement onInit
      super.onInit();
      isPharmacy.value =
          StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy) ?? false;

      doctorId.value =
          StorageService.readData(key: LocalStorageKeys.userId) ?? "";

      print(isPharmacy.value);
      print(doctorId.value);
      // fetchPharmacyDetails();
    }

// Widget step1({required BuildContext context}) {
//   return Obx(() => Container(
//     padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
//     child: SingleChildScrollView(
//       child: Column(
//         children: [
//           20.hs,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     height: 140,
//                     width: 140,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(70),
//                       border: Border.all(
//                         color: Theme.of(context).primaryColorDark.withOpacity(0.4),
//                         width: 1,
//                       ),
//                     ),
//                     child: Center(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(65),
//                         child: AnimatedSwitcher(
//                             duration: const Duration(milliseconds: 800),
//                             child: (sImageSelected.value && sImage != null)
//                                 ? Image.file(
//                               sImage!,
//                               height: 130,
//                               width: 130,
//                               fit: BoxFit.cover,
//                             )
//                                 : CachedNetworkImage(
//                               imageUrl: doctorProfileDetails!.data!.image!
//                                   .toString()
//                                   .contains(Apis.doctorImagePath)
//                                   ? doctorProfileDetails!.data!.image!.toString()
//                                   : ("${Apis.doctorImagePath}${doctorProfileDetails!.data!.image.toString()}"),
//                               height: 130,
//                               width: 130,
//                               fit: BoxFit.cover,
//                               placeholder: (context, url) => Transform.scale(
//                                   scale: 3.1,
//                                   child: Icon(
//                                     Icons.account_circle,
//                                     color: Theme.of(context).primaryColorDark.withOpacity(0.3),
//                                     size: 50,
//                                   )),
//                               errorWidget: (context, url, error) => Transform.scale(
//                                   scale: 3.1,
//                                   child: Icon(
//                                     Icons.account_circle,
//                                     color: Theme.of(context).primaryColorDark.withOpacity(0.3),
//                                     size: 50,
//                                   )),
//                             )),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 135,
//                     width: 135,
//                     child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: InkWell(
//                           onTap: () {
//                             // getImage();
//                           },
//                           child: Image.asset(
//                             AppImages.editYellowBg,
//                             height: 35,
//                             width: 35,
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Obx(() => EditDetailFormField1(
//                   labelText: 'name_hint'.tr,
//                   errorText: isNameError.value ? 'enter_name'.tr : null,
//                   controller: nameController,
//                   onChanged: (val) {
//                     if (val.isNotEmpty) {
//                       isNameError.value = false;
//                     }
//                     update();
//                   },
//                 )),
//                 3.hs,
//                 Obx(() => EditDetailFormField1(
//                   labelText: 'phone_number'.tr,
//                   errorText: isPhoneError.value ? 'enter_number'.tr : null,
//                   controller: phoneController,
//                   onChanged: (val) {
//                     if (val.isNotEmpty) {
//                       isPhoneError.value = false;
//                     }
//                     update();
//                   },
//                 )),
//                 if(isPharmacy.value == false)
//                   25.hs,
//                 if(isPharmacy.value == false)
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                           color: !isDepartmentError.value
//                               ? Theme.of(context).primaryColorDark.withOpacity(0.4)
//                               : AppColors.RED700,
//                           width: 1),
//                     ),
//                     child: departmentList.isEmpty
//                         ? Container()
//                         : ListenableBuilder(
//                       listenable: selectedValue,
//                       builder: (context, child) {
//                         return DropdownButton(
//                           hint: Text('select_department_hint'.tr),
//                           items: departmentList.map((x) {
//                             return DropdownMenuItem(
//                               value: x,
//                               child: Text(
//                                 x,
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                             );
//                           }).toList(),
//                           value: selectedValue.value,
//                           onTap: () {
//                             isDepartmentError.value = false;
//                           },
//                           onChanged: (val) {
//                             if (val == null) return;
//                             selectedValue.value = val;
//                           },
//                           isExpanded: true,
//                           underline: Container(),
//                           icon: Image.asset(
//                             AppImages.dropdownIcon,
//                             height: 15,
//                             width: 15,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 3.hs,
//                 Obx(() => EditDetailFormField1(
//                   labelText: 'working_time'.tr,
//                   errorText: isWorkingTimeError.value ? 'working_error'.tr : null,
//                   controller: worktimeController,
//                   onChanged: (val) {
//                     if (val.isNotEmpty) {
//                       isWorkingTimeError.value = false;
//                     }
//                     update();
//                   },
//                 )),
//                 if(isPharmacy.value == false)
//                   3.hs,
//                 if(isPharmacy.value == false)
//                   Obx(() => EditDetailFormField1(
//                     prefixText: CURRENCY,
//                     keyboardType: TextInputType.number,
//                     labelText: 'consultation_fee'.tr,
//                     errorText: isFeeError.value ? 'common_textfield_error'.tr : null,
//                     controller: feeController,
//                     onChanged: (val) {
//                       if (val.isNotEmpty) {
//                         isFeeError.value = false;
//                       }
//                       update();
//                     },
//                   )),
//                 3.hs,
//                 Obx(() => EditDetailFormField(
//                   labelText: 'about'.tr,
//                   errorText: isAboutUsError.value ? 'about_us_error'.tr : null,
//                   controller: aboutUsController,
//                   maxLines: 5,
//                   onChanged: (val) {
//                     if (val.isNotEmpty) {
//                       isAboutUsError.value = false;
//                     }
//                     update();
//                   },
//                 )),
//                 3.hs,
//                 Obx(() => EditDetailFormField(
//                   labelText: 'services'.tr,
//                   errorText: isAboutUsError.value ? 'services_error'.tr : null,
//                   controller: serviceController,
//                   maxLines: 5,
//                   onChanged: (val) {
//                     if (val.isNotEmpty) {
//                       isServiceError.value = false;
//                     }
//                     update();
//                   },
//                 )),
//                 if(isPharmacy.value == false)
//                   3.hs,
//                 if(isPharmacy.value == false)
//                   Obx(() => EditDetailFormField(
//                     labelText: 'health_care_str'.tr,
//                     errorText: isHealthCareError.value ? 'common_textfield_error'.tr : null,
//                     controller: healthcareController,
//                     maxLines: 3,
//                     onChanged: (val) {
//                       if (val.isNotEmpty) {
//                         isHealthCareError.value = false;
//                       }
//                       update();
//                     },
//                   )),
//                 if(isPharmacy.value == false)
//                   100.hs,
//                 if(isPharmacy.value == true)
//                   20.hs
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   ));
// }



  }
