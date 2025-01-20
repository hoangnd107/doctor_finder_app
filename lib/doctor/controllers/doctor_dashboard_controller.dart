import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';

import '../utils/doctor_imports.dart';

class DoctorDashboardController extends GetxController {
  DoctorPastAppointmentsClass? doctorAppointmentsClass;
  PharmacyOrderClass? pharmacyorderdetail;
  DoctorProfileWithRating? doctorProfileWithRating;

  RxString doctorId = "".obs;
  RxString pharmacyId = "".obs;

  RxBool isAppointmentAvailable = false.obs;
  RxBool isOrderAvailable = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isErrorInLoading = false.obs;

  RxBool isErrorInProfileLoading = false.obs;
  RxBool isProfileLoaded = false.obs;
  RxBool isPharmacy = false.obs;

  final incomingCallManager = Get.put(IncomingManageController());

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

  fetchDoctorAppointment() async {
    isAppointmentAvailable.value = false;
    isLoaded.value = false;
    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/doctoruappointment?doctor_id=${doctorId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading.value = true;
    });
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'].toString() == "1") {
        doctorAppointmentsClass =
            DoctorPastAppointmentsClass.fromJson(jsonResponse);
        isLoaded.value = true;
        isAppointmentAvailable.value = true;
      } else {
        isLoaded.value = true;
        isAppointmentAvailable.value = false;
      }
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  fetchDoctorDetails() async {
    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/doctordetail?type=1&doctor_id=${doctorId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      try {
        if (jsonResponse['success'].toString() == "1") {
          doctorProfileWithRating =
              DoctorProfileWithRating.fromJson(jsonResponse);

          print("${StorageService.readData(
              key: LocalStorageKeys
                  .isLoggedInAsPharmacy)}");

if("${StorageService.readData(
    key: LocalStorageKeys
        .isLoggedInAsPharmacy)}" == false) {
  if (doctorProfileWithRating!.data!.isSubscription == "0") {
    Get.toNamed(Routes.chooseYourPlanScreen, arguments: {
      'doctorUrl': doctorProfileWithRating!.data!.image.toString()
    });
  }
}
          isProfileLoaded.value = true;
        } else {
          isErrorInProfileLoading.value = true;
        }
      } catch (E) {
        isErrorInProfileLoading.value = true;
      }
    } else {
      isErrorInProfileLoading.value = true;
    }
    Client().close();
  }

  fetchPharmacyDetails() async {
    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/doctordetail?type=2&pharmacy_id=${pharmacyId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut));
    print(response.request!.url);
    log(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      try {
        if (jsonResponse['success'].toString() == "1") {
          doctorProfileWithRating =
              DoctorProfileWithRating.fromJson(jsonResponse);

          print("${StorageService.readData(
              key: LocalStorageKeys
                  .isLoggedInAsPharmacy)}");


          isProfileLoaded.value = true;
        } else {
          isErrorInProfileLoading.value = true;
        }
      } catch (E) {
        isErrorInProfileLoading.value = true;
      }
    } else {
      isErrorInProfileLoading.value = true;
    }
    Client().close();
  }

  ///if pass type then show only pending orders

  fetchPharmacyOrder() async {
    isOrderAvailable.value = false;
    isLoaded.value = false;
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/get_pharmacy_order_list?pharmacy_id=${pharmacyId.value}&type=1"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading.value = true;
    });
    print(response.request!.url);
    log(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'].toString() == "1") {
        pharmacyorderdetail =
            PharmacyOrderClass.fromJson(jsonResponse);
        print(pharmacyorderdetail!.msg.toString());
        isLoaded.value = true;
        isOrderAvailable.value = true;
        print(isOrderAvailable.value);
      } else {
        isLoaded.value = true;
        isOrderAvailable.value = false;
      }
    }
    else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  Future<bool> dialogPop() async {
    StorageService.removeData(key: LocalStorageKeys.callSessionCS);
    return true;
  }

  dialog() {
    return Get.defaultDialog(
      onWillPop: dialogPop,
      barrierDismissible: true,
      title: 'call_accept_dialog_title'.tr,
      content: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                'call_accept_dialog_subtitle'.tr,
                style: Theme.of(Get.context!).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    );
  }

  onRefresh() async {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      fetchDoctorAppointment();
    });
    refreshController.refreshCompleted();
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isPharmacy.value = StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy) ?? false;
    doctorId.value =
        StorageService.readData(key: LocalStorageKeys.userId) ?? "";
    pharmacyId.value =
        StorageService.readData(key: LocalStorageKeys.userId) ?? "";
    if(isPharmacy.value){
      fetchPharmacyOrder();
      fetchPharmacyDetails();
    }else{
    fetchDoctorAppointment();
    fetchDoctorDetails();
    }
    if (StorageService.readData(key: LocalStorageKeys.callSessionCS) != null) {
      dialog();
    }
  }
}
