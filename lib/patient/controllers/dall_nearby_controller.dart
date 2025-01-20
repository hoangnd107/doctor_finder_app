import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class DAllNearbyController extends GetxController {
  int page = Get.arguments['page'];
  RxBool isErrorInNearby = false.obs;
  RxBool isNearbyLoading = true.obs;
  RxList<NearbyData> list = <NearbyData>[].obs;
  RxBool isLoadingMore = false.obs;
  RxString nextUrl = "".obs;
  RxBool isErrorInLoading = false.obs;
  RxString lat = "".obs;
  RxString lon = "".obs;
  NearbyDoctorsClass? nearbyDoctorsClass;
  ScrollController scrollController = ScrollController();

  RxList<PData> list1 = <PData>[].obs;
  PharmacyData? pharmacyData;
  String? selected_city;
  // String selected_city_name = "";
  var selected_city_name = "".obs;  // Observable variable

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    selected_city ="${StorageService.readData(
        key: LocalStorageKeys
            .sortCityId) ??
        "0"}";
    selected_city_name.value ="${StorageService.readData(
        key: LocalStorageKeys
            .sortCityName) ??
        "not"}";
    print("sortCityName");
    print("${StorageService.readData(key: LocalStorageKeys.sortCityName,)}");
    print(selected_city_name);


    if (page == 1) {
      // print("profile123456");
      _getLocationStart();
    } else {
      callPharmacyApi(cityId: selected_city);
    }


// print("${StorageService.readData(
//     key: LocalStorageKeys
//         .sortCityId) ??
//     "0"}");

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page == 1) {
          loadMoreFunc();
        } else {
          loadMorePharmacyData();
        }
      }
    });
  }

  callPharmacyApi({String? cityId}) async {
    final response =
        await get(Uri.parse("${Apis.ServerAddress}/api/nearbydoctor?type=2&city_id=${cityId ?? 0}"))
            .timeout(const Duration(seconds: Apis.timeOut))
            .catchError((e) {
      isErrorInNearby.value = true;
      customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
    });
    if (response.statusCode == 200 &&
        jsonDecode(response.body)['status'] == 1) {
      final jsonResponse = jsonDecode(response.body);
      pharmacyData = PharmacyData.fromJson(jsonResponse);
      list1.addAll(pharmacyData!.data!.pharmacyData!);
      nextUrl.value = pharmacyData!.data!.nextPageUrl!;
      isNearbyLoading.value = false;
    } else {
      isErrorInNearby.value = true;
      customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

  loadMoreFunc() async {
    if (nextUrl.value != "null") {
      isLoadingMore.value = true;
      final response =
          await get(Uri.parse("${nextUrl.value}&type=1&lat=$lat&lon=$lon"))
              .timeout(const Duration(seconds: Apis.timeOut));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        nearbyDoctorsClass = NearbyDoctorsClass.fromJson(jsonResponse);

        nextUrl.value = nearbyDoctorsClass?.data?.nextPageUrl ?? "null";
        list.addAll(nearbyDoctorsClass!.data!.nearbyData!);
        isLoadingMore.value = false;
      }
    }
  }

  loadMorePharmacyData() async {
    if (nextUrl.value != "null") {
      isLoadingMore.value = true;
      final response = await get(Uri.parse("${nextUrl.value}&type=2"))
          .timeout(const Duration(seconds: Apis.timeOut));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        pharmacyData = PharmacyData.fromJson(jsonResponse);
        nextUrl.value = pharmacyData!.data!.nextPageUrl!;
        list1.addAll(pharmacyData!.data!.pharmacyData!);
        isLoadingMore.value = false;
      }
    }
  }

  callApi({double? latitude, double? longitude, String? cityId}) async {

    print("profile123456call api function");

    final response = await get(Uri.parse(
        // Platform.isIOS
    // ?        "${Apis.ServerAddress}/api/nearbydoctor?type=1&lat=${0.0}&lon=${0.0}&city_id=${cityId ?? 0}"
    //         :

        "${Apis.ServerAddress}/api/nearbydoctor?type=1&lat=$latitude&lon=$longitude&city_id=${cityId ?? 0}"))

        // .timeout(const Duration(seconds: Apis.timeOut))
        // .catchError((e) {
      // isErrorInNearby.value = true;
      // customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
    // }
    ;

    print("response.request!.url");
    // print(response.request!.url);

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonResponse['status'] == 1) {

      isNearbyLoading.value = false;

      nearbyDoctorsClass = NearbyDoctorsClass.fromJson(jsonResponse);
      list.addAll(nearbyDoctorsClass!.data!.nearbyData!);
      lat.value = latitude.toString();
      lon.value = longitude.toString();
      nextUrl.value = nearbyDoctorsClass!.data!.nextPageUrl!;
    }

    else {
      isErrorInNearby.value = true;
      customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
    }

  }

  void _getLocationStart() async {
    isErrorInNearby.value = false;
    isNearbyLoading.value = true;
    if (Platform.isIOS) {
      callApi(latitude: 0.0, longitude: 0.0,cityId: selected_city);
    } else {
      // Position? position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.high);

      callApi(latitude:double.parse(latitude.toString()), longitude:double.parse(longitude.toString()),cityId: selected_city);
    }
  }
}
