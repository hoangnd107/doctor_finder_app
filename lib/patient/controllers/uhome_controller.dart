import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:carousel_slider/carousel_slider.dart' ;

import '../../common/utils/video_call_imports.dart';
import '../../doctor/model/city_data_model.dart';

class UserHomeController extends GetxController {
  Future<bool> dialogPop() async {
    StorageService.removeData(key: LocalStorageKeys.callSessionCS);
    return true;
  }

  ScrollController scrollController2 = ScrollController();
  ScrollController scrollController = ScrollController();

  RxList<SpecialityData> list = <SpecialityData>[].obs;

  final CarouselSliderController sliderController = CarouselSliderController();

  RxList<BannerList> bannerList = <BannerList>[].obs;
  RxInt current = 0.obs;

  RxList<Appointment> appointmentList = <Appointment>[].obs;

  PageController pageController = PageController();

  SearchDoctorClass? searchDoctorClass;
  TextEditingController textController = TextEditingController();
  RxString nextUrl = "".obs;
  RxString searchKeyword = "".obs;
  RxList<SDoctorData> newData = <SDoctorData>[].obs;
  RxBool isSearching = false.obs;
  RxBool isSearchDataLoaded = false.obs;
  RxBool isLoadingMore = false.obs;

  RxString userId = "".obs;
  RxBool isLoggedIn = false.obs;
  RxBool isDataLoaded = false.obs;
  RxBool isErrorInLoading = false.obs;

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

  final incomingCallManager = Get.put(IncomingManageController());
  String? selected_city;
  String? selected_city_N;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
getCity();
    selected_city ="${StorageService.readData(
        key: LocalStorageKeys
            .sortCityId) ??
        "0"}";
    selected_city ="${StorageService.readData(
        key: LocalStorageKeys
            .sortCityName) ??
        ""}";

    isLoggedIn.value =
        StorageService.readData(key: LocalStorageKeys.isLoggedIn) ?? false;
    userId.value = StorageService.readData(key: LocalStorageKeys.userId) ?? "";
    if (isLoggedIn.value) {
      call_3in1_api();
    } else if (varSpecialityList.isEmpty && varBannerList.isEmpty) {
      call_3in1_api();
    } else {
      list.clear();
      bannerList.clear();
      list.value = varSpecialityList;
      bannerList.value = varBannerList;
      isDataLoaded.value = true;
      if (Platform.isAndroid) {
        _getLocationStart();
      } else {
        _getLocationStartIOS();
      }
    }

    if (StorageService.readData(key: LocalStorageKeys.callSessionCS) != null) {
      dialog();
    }


    scrollController2.addListener(() {
      if (scrollController2.position.pixels ==
          scrollController2.position.maxScrollExtent) {
        loadMoreNearbyDoctorData();
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreFunc();
      }
    });
  }


  RxBool isCatLoading = false.obs;
  RxBool isErrorInLoading1 = false.obs;
  RxString dropdownValue = "Surat".obs;
  int profile = 0;
  cityData? citydata;
  Rx<int> selectedCityIndex = Rx<int>(-1);

  getCity() async {
    isCatLoading.value = true;
    print(Uri.parse("${Apis.ServerAddress}/api/get_city"));
    final response = await get(Uri.parse("${Apis.ServerAddress}/api/get_city")).catchError((e) {
      isErrorInLoading1.value = true;
    });

    print(response.request);
    print('categories list :- ${response.body}');

    try {
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        citydata = cityData.fromJson(jsonResponse);

        print("profile123456");
        print(profile);
        if (profile.toString() == "0" || profile.toString() == null) {
          dropdownValue.value = "Select City";
        } else {
          dropdownValue.value = citydata!.data![profile - 1].cityName.toString();
        }
        isCatLoading.value = false;
      }
    } catch (e) {
      isErrorInLoading1.value = true;
    }
  }


  RxBool isErrorInLoadDoctorData = false.obs;
  RxBool isDoctorDataLoaded = false.obs;
  RxString nextUrlDoctor = "".obs;

  RxList<NearbyData> list2 = <NearbyData>[].obs;
  NearbyDoctorsClass? nearbyDoctorsClass;

  RxString lat = "".obs;
  RxString lon = "".obs;

  void _getLocationStart() async {
    isErrorInLoadDoctorData.value = false;
    isDoctorDataLoaded.value = false;
    var status = await Permission.location.status;
    if (status.isDenied) {
      await [
        Permission.location,
      ].request();
    }
    status = await Permission.location.status;

    if (status.isGranted) {
      if (Platform.isAndroid) {
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
            // ?.requestPermission();
      }
      if (longitude.isEmpty || latitude.isEmpty) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        latitude = position.latitude.toString();
        longitude = position.longitude.toString();

        callApi(latitude: position.latitude, longitude: position.longitude,cityId: selected_city);

      } else {
        callApi(
            latitude: double.parse(latitude),
            longitude: double.parse(longitude),cityId: selected_city);
      }
    } else if (status.isPermanentlyDenied) {
      messageDialog('permission_not_granted'.tr, "permission_not".tr);
      isErrorInLoadDoctorData.value = true;
      return;
    } else if (status.isDenied) {
      messageDialog('permission_not_granted'.tr, "permission_not".tr);
      isErrorInLoadDoctorData.value = true;
    }
  }

  void _getLocationStartIOS() async {
    isErrorInLoadDoctorData.value = false;
    isDoctorDataLoaded.value = false;

    LocationPermission status = await Geolocator.requestPermission();

    if (status == LocationPermission.denied) {
      status = await Geolocator.requestPermission();
    }
    status = await Geolocator.requestPermission();

    if (status == LocationPermission.whileInUse ||
        status == LocationPermission.always) {
      if (Platform.isAndroid) {
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      }
      if (longitude.isEmpty || latitude.isEmpty) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        callApi(latitude: position.latitude, longitude: position.longitude,cityId:selected_city );
      } else {
        callApi(
            latitude: double.parse(latitude),
            longitude: double.parse(longitude),cityId: selected_city);
      }
    } else if (status == LocationPermission.deniedForever) {
      messageDialog('permission_not_granted'.tr, "permission_not".tr);
      isErrorInLoadDoctorData.value = true;
      return;
    } else if (status == LocationPermission.denied) {
      messageDialog('permission_not_granted'.tr, "permission_not".tr);
      isErrorInLoadDoctorData.value = true;
    }
  }

  callApi({double? latitude, double? longitude, String? cityId}) async {

    final response = await get(Uri.parse(
            "${Apis.ServerAddress}/api/nearbydoctor?type=1&lat=$latitude&lon=$longitude&city_id=${cityId ?? 0}"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoadDoctorData.value = true;
      messageDialog('error'.tr, 'unable_to_load_data'.tr);
    });

print("response.request!.url");
print(response.request!.url);

log(response.body);
    if (response.statusCode == 200 &&
        jsonDecode(response.body)['status'] == 1) {
      list2.clear();
      lat.value = latitude.toString();
      lon.value = longitude.toString();
      final jsonResponse = jsonDecode(response.body);
      nearbyDoctorsClass = NearbyDoctorsClass.fromJson(jsonResponse);

      list2.addAll(nearbyDoctorsClass!.data!.nearbyData!);
      nextUrlDoctor.value = nearbyDoctorsClass!.data!.nextPageUrl ?? "null";
      isDoctorDataLoaded.value = true;
    } else {
      isErrorInLoadDoctorData.value = true;
      messageDialog('error'.tr, 'unable_to_load_data'.tr);
    }
  }

  messageDialog(String s1, String s2) {
    customDialog(
      s1: s1,
      s2: s2,
      onPressed: () async {
        if (Platform.isAndroid) {
          var status = await Permission.location.status;
          if (!status.isGranted && s1 == 'permission_not_granted'.tr) {
            Map<Permission, PermissionStatus> statuses = await [
              Permission.location,
            ].request();

            if (statuses[Permission.location]!.isGranted) {
              _getLocationStart();
            }
          }
        } else {
          LocationPermission status = await Geolocator.requestPermission();
          if (!(status == LocationPermission.whileInUse ||
                  status == LocationPermission.always) &&
              s1 == 'permission_not_granted'.tr) {
            status = await Geolocator.requestPermission();

            if ((status == LocationPermission.whileInUse ||
                status == LocationPermission.always)) {
              _getLocationStart();
            }
          }
        }

        Get.back();
      },
    );
  }

  loadMoreNearbyDoctorData({String? cityId}) async {
    if (nextUrlDoctor.value.isEmpty || nextUrlDoctor.value == "null") return;
    if (nextUrlDoctor.value != "null") {
      final response = await get(Uri.parse(
              "${nextUrlDoctor.value}&type=1&lat=${lat.value}&lon=${lon.value}&city_id=${cityId ?? 0}"))
          .timeout(const Duration(seconds: Apis.timeOut));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        nearbyDoctorsClass = NearbyDoctorsClass.fromJson(jsonResponse);
        nextUrlDoctor.value = nearbyDoctorsClass!.data!.nextPageUrl ?? "null";
        list2.addAll(nearbyDoctorsClass!.data!.nearbyData!);
      }
    }
  }

  call_3in1_api() async {
    String Uri1 = isLoggedIn.value
        ? "${Apis.ServerAddress}/api/data_list?user_id=${userId.value}"
        : "${Apis.ServerAddress}/api/data_list";

    final response = await get(Uri.parse(Uri1))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading.value = true;
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      HomeScreenData call_all_api = HomeScreenData.fromJson(responseData);
      if (!listEquals(call_all_api.data!.speciality!, list) &&
          !listEquals(call_all_api.data!.banner!, bannerList)) {
        list.clear();
        bannerList.clear();
        bannerList.value = call_all_api.data!.banner ?? [];
        list.value = call_all_api.data!.speciality ?? [];
      }
      varSpecialityList.clear();
      varBannerList.clear();
      varSpecialityList.addAll(list);
      varBannerList.addAll(bannerList);

      appointmentList.addAll(call_all_api.data!.appointment!);

      isDataLoaded.value = true;
    } else {
      isErrorInLoading.value = true;
    }

    if (Platform.isAndroid) {
      _getLocationStart();
    } else {
      _getLocationStartIOS();
    }
  }

  loadMoreFunc() async {
    if (nextUrl.value == "null") {
      return;
    }
    isLoadingMore.value = true;
    final response =
        await get(Uri.parse("${nextUrl.value}&term=${searchKeyword.value}"))
            .timeout(const Duration(seconds: Apis.timeOut));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      searchDoctorClass = SearchDoctorClass.fromJson(jsonResponse);
      newData.addAll(searchDoctorClass?.data?.doctorData ?? []);
      isLoadingMore.value = false;
      nextUrl.value = searchDoctorClass!.data!.nextPageUrl ?? "null";
    }
  }

  onChanged(String value) async {
    if (value.isEmpty) {
      newData.clear();
      isSearching.value = false;
      pageController.previousPage(
        duration: const Duration(milliseconds: 850),
        curve: Curves.linear,
      );
    } else {
      if (!isSearching.value) {
        isSearching.value = true;
        pageController.nextPage(
          duration: const Duration(milliseconds: 850),
          curve: Curves.linear,
        );
        await Future.delayed(const Duration(milliseconds: 850));
      }
      isSearchDataLoaded.value = false;
      final response = await get(
              Uri.parse("${Apis.ServerAddress}/api/searchdoctor?term=$value"))
          .timeout(const Duration(seconds: Apis.timeOut))
          .catchError((e) {
        isSearchDataLoaded.value = true;
      });
      if (response.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(response.body);
          searchDoctorClass = SearchDoctorClass.fromJson(jsonResponse);
          newData.clear();
          newData.addAll(searchDoctorClass!.data!.doctorData!);
          nextUrl.value = searchDoctorClass!.data!.nextPageUrl.toString();
          isSearchDataLoaded.value = true;
        } catch (e) {
          isSearchDataLoaded.value = true;
        }
      } else {
        isSearchDataLoaded.value = true;
      }
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController2.dispose();
    scrollController.dispose();
  }
}
