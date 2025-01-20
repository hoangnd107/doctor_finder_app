import 'dart:developer';

import 'package:videocalling_medical/common/utils/app_imports.dart';

import '../model/pharmacy_order_model.dart';

class UserPastAppointmentsController extends GetxController {

  RxList<AppointmentData> list = <AppointmentData>[].obs;
  // String? userId = StorageService.readData(key: LocalStorageKeys.userId) ?? "";
  String? userId ;

  RxBool isAppointmentExist = false.obs;
  RxBool isErrorInLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isLoaded = false.obs;

  String nextUrl = "";
  String? time1;
  DateTime? datetime1;
  RxList<String> ampm1 = <String>[].obs;
  UserAppointmentsClass? userAppointmentsClass;
  ScrollController scrollController = ScrollController();

  fetchUpcomingAppointments() async {
    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/userspastappointment?user_id=$userId"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading.value = true;
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'].toString() == "1") {
        isAppointmentExist.value = true;
        userAppointmentsClass = UserAppointmentsClass.fromJson(jsonResponse);
        list.addAll(userAppointmentsClass!.data!.appointmentData!);
        nextUrl = userAppointmentsClass!.data!.nextPageUrl!;
        update();
      } else {
        isAppointmentExist.value = false;
        update();
      }
    }
    isLoaded.value = true;
    update();
  }

  PharmacyOrder pharmacyOrder = PharmacyOrder();
  RxList<orderdata> orderlist = <orderdata>[].obs;

  fetchPharmacyorder() async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/get_user_order_list?user_id=${userId ?? 0}"))
        .timeout(const Duration(seconds: Apis.timeOut));
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      print(jsonResponse);
      print(jsonResponse['status'].toString());


      if (jsonResponse['status'].toString() == "1") {

        pharmacyOrder = PharmacyOrder.fromJson(jsonResponse);

        print(response.request!.url);
        orderlist.addAll(pharmacyOrder.data as Iterable<orderdata>);
        for (int i = 0; i < orderlist.length; i++) {
          String? createdAt = orderlist[i].createdAt;
          if (createdAt != null) {
            String time1 = "${createdAt.substring(0, 19)}";
            DateTime datetime1 = DateTime.parse(time1).toLocal();
            String ampm = datetime1.hour < 12 ? 'AM' : 'PM';
            ampm1.value.add(ampm);
          }
        }
        print(orderlist.length);
      }
      else {
        // isLoaded.value = true;
        // isAppointmentAvailable.value = false;
      }
    }

    else {
      // isErrorInLoading.value = true;
    }
    Client().close();
  }


// Global or class-level variable to store AM/PM values



  // timeset() {
  //   List<String> ampm1 = [];
  //
  //   for (int i = 0; i < orderlist.length; i++) {
  //     String? createdAt = orderlist[i].createdAt;
  //     if (createdAt != null) {
  //       String time1 = "${createdAt.substring(0, 19)}"; // Use only date and time part
  //       DateTime datetime1 = DateTime.parse(time1).toLocal(); // Parse and convert to local time
  //
  //       // Determine AM/PM
  //       String ampm = datetime1.hour < 12 ? 'AM' : 'PM';
  //
  //       ampm1.add(ampm);
  //
  //       // Print the result for the current timestamp
  //       print('Timestamp ${i + 1}: ${datetime1} is $ampm');
  //     }
  //   }
  //
  //   // Print all AM/PM values
  //   print('All AM/PM values: $ampm1');
  // }


  loadMore() async {
    if (nextUrl != "null") {
      final response = await get(Uri.parse("$nextUrl&user_id=$userId"))
          .timeout(const Duration(seconds: Apis.timeOut));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'].toString() == "1") {
          userAppointmentsClass = UserAppointmentsClass.fromJson(jsonResponse);
          list.addAll(userAppointmentsClass!.data!.appointmentData!);
          nextUrl = userAppointmentsClass!.data!.nextPageUrl!;
        }
      }
    }
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    userId = StorageService.readData(key: LocalStorageKeys.userId) ?? "";
    fetchUpcomingAppointments();
    await fetchPharmacyorder();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }
}
