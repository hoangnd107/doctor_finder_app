import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';
import 'package:videocalling_medical/doctor/model/medicine_data_model.dart';
import 'package:dio/dio.dart' as dio;

import '../utils/doctor_imports.dart';

class DMoreInfoController extends GetxController {
  List<String> optionList = [
    'change_password_str'.tr,
    'subscription_str'.tr,
    'bank_details'.tr,
    'income_report_str'.tr,
    'logout_title'.tr
  ];
  List<String> optionList2 = [
    'change_password_str'.tr,
    'income_report_str'.tr,
    'logout_title'.tr
  ];

  RxString doctorId = "".obs;
  RxString medicineId = "".obs;
  RxString imagePath = "".obs;
  RxBool isErrorInLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isPharmacy = false.obs;
  RxBool isEdit = false.obs;

  DoctorProfileWithRating? doctorProfileWithRating;
  MedicineAllData1? medicineAllData;

  ScrollController allMedicineScrollController = ScrollController();

  File? sImage;
  RxBool sImageSelected = false.obs;
  RxBool isSuccessful = false.obs;
  String? base64image;

  fetchDoctorDetails() async {
    isErrorInLoading.value = false;
    isLoaded.value = false;
    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/doctordetail?doctor_id=${doctorId.value}&type=1"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading.value = true;
    });
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      doctorProfileWithRating = DoctorProfileWithRating.fromJson(jsonResponse);
      isLoaded.value = true;
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  fetchPharmacyDetails() async {
    isErrorInLoading.value = false;
    isLoaded.value = false;
    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/doctordetail?pharmacy_id=${doctorId.value}&type=2"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading.value = true;
    });
    print(response.request!.url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      doctorProfileWithRating = DoctorProfileWithRating.fromJson(jsonResponse);
      isLoaded.value = true;
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  fetchPharmacyMedicineDetails() async {
    isErrorInLoading.value = false;
    isLoaded.value = false;
    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/pharmacy_medicines?pharmacy_id=${doctorId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading.value = true;
    });

    print(response.request!.url);
    // print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      medicineAllData = MedicineAllData1.fromJson(jsonResponse);
      isLoaded.value = true;
      isLoaded.value = true;
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  Widget buildRatingStars(double avgRating) {
    int rating = avgRating?.toInt() ?? 1;
    List<Widget> stars = List.generate(5, (index) {
      return Padding(
        padding: const EdgeInsets.only(right: 2),
        child: Image.asset(
          index < rating ? AppImages.starFill : AppImages.starNoFill,
          height: 15,
          width: 15,
        ),
      );
    });
    return Row(children: stars);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    isPharmacy.value =
        StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy) ?? false;

    doctorId.value = StorageService.readData(key: LocalStorageKeys.userId) ?? "";

    if (isPharmacy.value) {
      await fetchPharmacyMedicineDetails();
      await fetchPharmacyDetails();
    } else {
      await fetchDoctorDetails();
    }

    if (isEdit.value == true) {
      getMedicineData(int.parse(medicineId.value));
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController aboutUsController = TextEditingController();

  Widget step1({required BuildContext context}) {
    sImage = null;
    print("${Apis.medicineImage}${imagePath.value}");
    return Obx(() {
      return Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.hs,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      ///image
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(
                            color: Theme.of(context).primaryColorDark.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(65),
                            child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 800),
                                child: (sImageSelected.value && sImage != null)
                                    ? Image.file(
                                        sImage!,
                                        height: 130,
                                        width: 130,
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl:
                                            ("${Apis.medicineImage}${imagePath.value}"),
                                        height: 130,
                                        width: 130,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Image.asset(
                                          AppImages.medicine1,
                                          // Replace with your asset path
                                          height: 130,
                                          width: 130,
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: (context, url, error) => Image.asset(
                                          AppImages.medicine1,
                                          // Replace with your asset path
                                          height: 130,
                                          width: 130,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                          ),
                        ),
                      ),
                      Container(
                        height: 135,
                        width: 135,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                getImage();
                              },
                              child: Image.asset(
                                AppImages.editYellowBg,
                                height: 35,
                                width: 35,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    EditDetailFormField2(
                      labelText: 'name_hint'.tr,
                      // errorText: 'enter_name'.tr,
                      controller: nameController,
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          print("isNameError");
                          // isNameError.value = false;
                        }
                        update();
                      },
                    ),
                    3.hs,
                    EditDetailFormField2(
                      prefixText: CURRENCY,
                      keyboardType: TextInputType.number,
                      labelText: 'Medicine Price'.tr,
                      // errorText: 'common_textfield_error'.tr ,
                      controller: feeController,
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          print("isPriceError");

                          // isFeeError.value = false;
                        }
                        update();
                      },
                    ),
                    3.hs,
                    EditDetailFormField2(
                      labelText: 'Description'.tr,
                      controller: aboutUsController,
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          print("isAboutUsError");
                          // isAboutUsError.value = false;
                        }
                        update();
                      },
                    ),
                  ],
                ),
              ),
              CustomButton(
                onTap: () {
                  isEdit.value == false ? uploadMedicineData() : editMedicineData();
                },
                btnText: 'add_medicine_str'.tr,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                textStyle: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: Theme.of(context).scaffoldBackgroundColor, fontSizeDelta: 2),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

    if (pickedFile != null) {
      sImageSelected.value = false;
      sImage = File(pickedFile.path);
      base64image = base64Encode(sImage!.readAsBytesSync());
      sImageSelected.value = true;
    }
  }

  uploadMedicineData() async {
    await Future.delayed(Duration.zero);
    customDialog1(s1: 'reporting_dialog1'.tr, s2: 'while_saving_changes'.tr);
    print(sImage);
    if (sImage == null) {
      final response =
          await post(Uri.parse("${Apis.ServerAddress}/api/add_pharmacy_medicine"), body: {
        "medicine_id": 0,
        "pharmacy_id": doctorId.value,
        "name": nameController.text,
        "price": feeController.text,
        "description": aboutUsController.text,
      }).timeout(const Duration(seconds: Apis.timeOut)).catchError(
        (e) {
          Get.back();
          messageDialog('error'.tr, 'unable_to_load_data'.tr);
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'].toString() == "1") {
          Get.back();
          isSuccessful.value = true;
          messageDialog('success'.tr, 'profile_update_successfully'.tr);
        } else {
          Get.back();
          messageDialog('error'.tr, jsonResponse['register']);
        }
      }
    } else {
      Dio d = Dio();

      var formData = dio.FormData.fromMap({
        "medicine_id": 0,
        "pharmacy_id": doctorId.value,
        "name": nameController.text,
        "price": feeController.text,
        "description": aboutUsController.text,
        'upload_image': await dio.MultipartFile.fromFile(sImage!.path,
            filename: sImage!.path.split("/").last),
      });
      var response = await d
          .post("${Apis.ServerAddress}/api/add_pharmacy_medicine", data: formData)
          .timeout(const Duration(seconds: Apis.timeOut))
          .catchError((e) {
        Get.back();
        messageDialog('error'.tr, 'unable_to_load_data'.tr);
      });

      print(response.data);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.data);
        if (jsonResponse['status'].toString() == "1") {
          Get.back();
          isSuccessful.value = true;
          messageDialog('success'.tr, 'profile_update_successfully'.tr);
        } else {
          Get.back();
          messageDialog('error'.tr, response.data['register'].toString());
        }
      }
    }

    if (sImage != null) {
      Dio().close();
    }
  }

  editMedicineData() async {
    await Future.delayed(Duration.zero);
    customDialog1(s1: 'reporting_dialog1'.tr, s2: 'while_saving_changes'.tr);
    print(sImage);
    print(medicineId.value);
    if (sImage == null) {
      final response = await post(
          Uri.parse(
              "${Apis.ServerAddress}/api/add_pharmacy_medicine?medicine_id=${medicineId.value}"),
          body: {
            "medicine_id": medicineId.value,
            "pharmacy_id": doctorId.value,
            "name": nameController.text,
            "price": feeController.text,
            "description": aboutUsController.text,
          }).timeout(const Duration(seconds: Apis.timeOut)).catchError(
        (e) {
          Get.back();
          messageDialog('error'.tr, 'unable_to_load_data'.tr);
        },
      );
      print(response.request!.url);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'].toString() == "1") {
          Get.back();
          isSuccessful.value = true;
          messageDialog('success'.tr, 'profile_update_successfully'.tr);
        } else {
          Get.back();
          messageDialog('error'.tr, jsonResponse['register']);
        }
      }
    } else {
      Dio d = Dio();

      var formData = dio.FormData.fromMap({
        "medicine_id": medicineId.value,
        "pharmacy_id": doctorId.value,
        "name": nameController.text,
        "price": feeController.text,
        "description": aboutUsController.text,
        'upload_image': await dio.MultipartFile.fromFile(sImage!.path,
            filename: sImage!.path.split("/").last),
      });
      var response = await d
          .post(
              "${Apis.ServerAddress}/api/add_pharmacy_medicine?medicine_id:${medicineId.value}",
              data: formData)
          .timeout(const Duration(seconds: Apis.timeOut))
          .catchError((e) {
        Get.back();
        messageDialog('error'.tr, 'unable_to_load_data'.tr);
      });

      print(response.data);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.data);
        if (jsonResponse['status'].toString() == "1") {
          Get.back();
          isSuccessful.value = true;
          messageDialog('success'.tr, 'profile_update_successfully'.tr);
        } else {
          Get.back();
          messageDialog('error'.tr, response.data['register'].toString());
        }
      }
    }

    if (sImage != null) {
      Dio().close();
    }
  }

  getMedicineData(medicine_id) async {
    isEdit.value = true;
    medicineId.value = medicine_id;
    await Future.delayed(Duration.zero);

    final response = await post(
        Uri.parse("${Apis.ServerAddress}/api/medicines_detail?medicine_id=$medicine_id"));

    print(response.body);
    print(response.request!.url);
    final jsonResponse = jsonDecode(response.body);

    nameController.text = jsonResponse["data"]['name'].toString();
    feeController.text = jsonResponse["data"]['price'].toString();
    aboutUsController.text = jsonResponse["data"]['description'].toString();
    imagePath.value = jsonResponse["data"]['image'].toString();
    print(nameController.text);
    print(feeController.text);
    print(aboutUsController.text);
    print(imagePath.value);
  }

  messageDialog(String s1, String s2) {
    customDialog(
      s1: s1,
      s2: s2,
      onPressed: () {
        if (isSuccessful.value) {
          // future = fetchDoctorProfileDetails();
          // future2 = fetchDoctorSchedule();
          // index.value = 0;
          Get.offAllNamed(Routes.doctorTabScreen);
        } else {
          Get.back();
        }
      },
    );
  }
}
