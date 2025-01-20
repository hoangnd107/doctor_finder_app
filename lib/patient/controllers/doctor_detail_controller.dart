import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

import '../../doctor/utils/doctor_imports.dart';

class DoctorDetailController extends GetxController {
  DoctorDetailsClass? doctorDetailsClass;
  String id = Get.arguments['id'];
  int page = Get.arguments['type'];
  RxBool isLoading = true.obs;
  RxBool isLoggedIn = false.obs;
  RxBool isErrorInLoading = false.obs;

  File? image;

  RxBool loggedIn = false.obs;

  checkLogin() {
    isLoggedIn.value =
        StorageService.readData(key: LocalStorageKeys.isLoggedIn) ?? false;
  }

  fetchDoctorDetails() async {
    isLoading.value = true;

    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/viewdoctor?type=$page&doctor_id=${id}"))
        .catchError((e) {
      isErrorInLoading.value = true;
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      doctorDetailsClass = DoctorDetailsClass.fromJson(jsonResponse);
      isLoading.value = false;
    }
  }

  fetchPharmacyDetails() async {
    isLoading.value = true;

    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/viewdoctor?type=$page&pharmacy_id=${id}"))
        .catchError((e) {
      isErrorInLoading.value = true;
    });
    print(response.request!.url);
    log(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      doctorDetailsClass = DoctorDetailsClass.fromJson(jsonResponse);
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkLogin();
    if (page == 1) {
      fetchDoctorDetails();
    } else {
      fetchPharmacyDetails();
    }
  }

  processPayment() async {
    if (isLoggedIn.value) {
      Get.toNamed(Routes.makeAppointmentScreen, arguments: {
        'id': id,
        'name': doctorDetailsClass!.data!.name ?? "",
        'consultationFee': doctorDetailsClass!.data!.consultationFee,
      });
    } else {
      Get.toNamed(Routes.loginUserScreen, arguments: {
        "isBack": true,
      })?.then((value) {
        if (value ?? false) {
          isLoggedIn.value = true;
          Get.toNamed(Routes.makeAppointmentScreen, arguments: {
            'id': id,
            'name': doctorDetailsClass!.data!.name ?? "",
            'consultationFee': doctorDetailsClass!.data!.consultationFee,
          });
        }
      });
    }
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  showUploadRecipeSheet() {
    image = null;
    Get.bottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: AppColors.transparentColor, StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.WHITE,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: AppTextWidgets.boldTextWithColor(
                    text: 'upload_prescription'.tr,
                    color: AppColors.BLACK,
                    size: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Stack(
                    children: [
                      image == null
                          ? DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.all(6),
                              dashPattern: const [5, 3, 5, 3],
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: InkWell(
                                  onTap: () async {
                                    final pickedFile = await picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 25);

                                    if (pickedFile != null) {
                                      setState(() {
                                        image = File(pickedFile.path);
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 180,
                                    width: double.maxFinite,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 50,
                                            color: AppColors.AMBER_NORMAL,
                                          ),
                                          Text(
                                            'choose_gallery'.tr,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                height: 170,
                                fit: BoxFit.cover,
                                width: double.maxFinite,
                              ),
                            ),
                      Positioned.fill(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.AMBER_NORMAL,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        final pickedFile =
                                            await picker.pickImage(
                                                source: ImageSource.camera,
                                                imageQuality: 25);

                                        if (pickedFile != null) {
                                          setState(() {
                                            image = File(pickedFile.path);
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: AppColors.WHITE,
                                      ),
                                      iconSize: 20,
                                      constraints: const BoxConstraints(
                                          maxHeight: 40, maxWidth: 40),
                                    ),
                                  ],
                                ),
                              ),
                              image == null
                                  ? const SizedBox()
                                  : Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.AMBER_NORMAL,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              final pickedFile =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                      imageQuality: 25);

                                              if (pickedFile != null) {
                                                setState(() {
                                                  image = File(pickedFile.path);
                                                });
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.photo,
                                              color: AppColors.WHITE,
                                            ),
                                            iconSize: 20,
                                            constraints: const BoxConstraints(
                                                maxHeight: 40, maxWidth: 40),
                                          ),
                                        ],
                                      ),
                                    ),
                              image == null
                                  ? const SizedBox()
                                  : Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.AMBER_NORMAL,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await Get.toNamed(
                                                  Routes.dMyPhotoViewerScreen,
                                                  arguments: {
                                                    'imagePath': image!.path,
                                                    'isFromFile': true,
                                                  });
                                              Get.delete<
                                                  DMyPhotoViewController>();
                                            },
                                            icon: const Icon(
                                              Icons.open_in_full,
                                              color: AppColors.WHITE,
                                            ),
                                            iconSize: 20,
                                            constraints: const BoxConstraints(
                                                maxHeight: 40, maxWidth: 40),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: image == null
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Container(
                            height: 50,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  image = null;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppColors.LIGHT_GREY_TEXT
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                  Center(
                                    child: Text('cancel'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .apply(
                                                color: AppColors.BLACK,
                                                fontSizeDelta: 2)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: SizedBox(
                    height: 50,
                    child: InkWell(
                      onTap: () async {
                        print(doctorDetailsClass!.data!.id);
                        if (image != null) {
                          Get.back();
                          if (isLoggedIn.value) {
                            await Get.toNamed(Routes.medicineOrderScreen,
                                arguments: {
                                  'type': 2,
                                  'imgPath': image?.path ?? "",
                                  "pid": doctorDetailsClass!.data!.id
                                });
                            Get.delete<ViewCartController>();
                          } else {
                            Get.toNamed(Routes.loginUserScreen, arguments: {
                              "isBack": true,
                            })?.then((value) async {
                              if (value ?? false) {
                                checkLogin();
                                await Get.toNamed(Routes.medicineOrderScreen,
                                    arguments: {
                                      'type': 2,
                                      'imgPath': image?.path ?? "",
                                    "pid": doctorDetailsClass!.data!.id

                                    });
                                Get.delete<ViewCartController>();
                              }
                            });
                          }
                        } else {
                          Get.back();
                        }
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
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
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Center(
                            child: Text(
                              image != null
                                  ? isLoggedIn.value
                                      ? 'proceed_order'.tr
                                      : 'login_to_proceed_order'.tr
                                  : 'cancel'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    fontSizeDelta: 2,
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
