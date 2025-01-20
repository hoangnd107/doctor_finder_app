import 'package:videocalling_medical/common/utils/app_imports.dart';

import '../utils/doctor_imports.dart';

class DAllAppointmentsController extends GetxController {
  DoctorPastAppointmentsClass? doctorPastAppointmentsClass;
  RxString userId = "".obs;
  RxBool isAppointmentAvailable = false.obs;
  RxString nextUrl = "".obs;
  RxBool isOrderAvailable = false.obs;

  RxBool isLoadingMore = false.obs;
  RxList<DoctorAppointmentData> list = <DoctorAppointmentData>[].obs;
  List<DoctorAppointmentData> list2 = [];
  ScrollController scrollController = ScrollController();
  RxBool isLoaded = false.obs;
  RxBool isErrorInLoading = false.obs;

  RxBool isPharmacy = false.obs;

  fetchPastAppointments() async {

    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/doctoruappointment?doctor_id=${userId.value}"));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] == "1") {
        isLoaded.value = true;
        isAppointmentAvailable.value = true;
        doctorPastAppointmentsClass =
            DoctorPastAppointmentsClass.fromJson(jsonResponse);
        nextUrl.value = doctorPastAppointmentsClass!.data!.nextPageUrl!;
        list.addAll(doctorPastAppointmentsClass!.data!.doctorAppointmentData!);
      } else {
        isLoaded.value = true;
        isAppointmentAvailable.value = false;
      }
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  PharmacyOrderClass? pharmacyorderdetail;

  fetchPastOrder() async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/get_pharmacy_order_list?pharmacy_id=${userId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut));
    print(response.request!.url);
    // log(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'].toString() == "1") {
        pharmacyorderdetail = PharmacyOrderClass.fromJson(jsonResponse);
        isLoaded.value = true;
        isOrderAvailable.value = true;
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
          await get(Uri.parse("${nextUrl.value}&doctor_id=${userId.value}"));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == "1") {
          isLoadingMore.value = false;
          doctorPastAppointmentsClass =
              DoctorPastAppointmentsClass.fromJson(jsonResponse);
          nextUrl.value = doctorPastAppointmentsClass!.data!.nextPageUrl!;
          list2.clear();
          list2.addAll(
              doctorPastAppointmentsClass!.data!.doctorAppointmentData!);
          list.addAll(list2);
        }
      }
      Client().close();
    }
  }

  @override
  void onClose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId.value = StorageService.readData(key: LocalStorageKeys.userId) ?? "";
    isPharmacy.value = StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy) ?? false;

    isPharmacy.value
    ?fetchPastOrder()
    :fetchPastAppointments();

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await loadMore();
      }
    });
  }
}
