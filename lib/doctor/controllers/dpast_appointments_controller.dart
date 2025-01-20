import 'dart:developer';

import 'package:videocalling_medical/common/utils/app_imports.dart';

import '../utils/doctor_imports.dart';

class DoctorPastAppointmentsController extends GetxController {
  DoctorPastAppointmentsClass? doctorPastAppointmentsClass;
  PharmacyOrderClass? pharmacyorderdetail;

  RxString doctorId = "".obs;
  RxString nextUrl = "".obs;

  RxBool isAppointmentAvailable = false.obs;
  RxBool isOrderAvailable = false.obs;
  RxBool isErrorInLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isPharmacy = false.obs;

  RxList<DoctorAppointmentData> list = <DoctorAppointmentData>[].obs;
  List<DoctorAppointmentData> list2 = [];

  ScrollController scrollController = ScrollController();

  fetchPastAppointments() async {
    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/doctorpastappointment?doctor_id=${doctorId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'].toString() == "1") {
        doctorPastAppointmentsClass = DoctorPastAppointmentsClass.fromJson(jsonResponse);
        nextUrl.value = doctorPastAppointmentsClass!.data!.nextPageUrl!;
        list.addAll(doctorPastAppointmentsClass!.data!.doctorAppointmentData!);
        isAppointmentAvailable.value = true;
        isLoaded.value = true;
      } else {
        isLoaded.value = true;
        isAppointmentAvailable.value = false;
      }
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  fetchPastOrder() async {
    // https://demo.freaktemplate.com/bookappointment/api/get_pharmacy_order_list?pharmacy_id=166
    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/get_pharmacy_order_list?pharmacy_id=${doctorId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut));
    print(response.request!.url);
    log(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'].toString() == "1") {
        pharmacyorderdetail = PharmacyOrderClass.fromJson(jsonResponse);
        print(pharmacyorderdetail!.msg.toString());
        isLoaded.value = true;
        isOrderAvailable.value = true;
        print(isOrderAvailable.value);
      } else {
        isLoaded.value = true;
        isOrderAvailable.value = false;
      }
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  loadMore() async {
    if (nextUrl.value != "null") {
      final response =
          await get(Uri.parse("${nextUrl.value}&doctor_id=${doctorId.value}"))
              .timeout(const Duration(seconds: Apis.timeOut));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'].toString() == "1") {
          doctorPastAppointmentsClass =
              DoctorPastAppointmentsClass.fromJson(jsonResponse);
          nextUrl.value = doctorPastAppointmentsClass!.data!.nextPageUrl!;
          list2.clear();
          list2.addAll(doctorPastAppointmentsClass!.data!.doctorAppointmentData!);
          isLoadingMore.value = false;
        }
      }
      Client().close();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    doctorId.value = StorageService.readData(key: LocalStorageKeys.userId) ?? "";
    isPharmacy.value =
        StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy) ?? false;

    if (isPharmacy.value) {
      fetchPastOrder();
    } else {
      fetchPastAppointments();
    }
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        await loadMore();
        list.addAll(list2);
      }
    });
  }
}
