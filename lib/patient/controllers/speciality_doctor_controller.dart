import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class SpecialityDoctorController extends GetxController {
  String id = Get.arguments['id'];
  String name = Get.arguments['name'];

  RxBool isErrorInNearby = false.obs;
  RxBool isNearbyLoading = true.obs;
  RxList<DoctorData> doctorList = <DoctorData>[].obs;
  RxBool isLoadingMore = false.obs;
  RxString nextUrl = "".obs;
  double? lat;
  double? long;
  RxBool isErrorInLoading = false.obs;
  SpecialityDoctorsClass? specialityDoctorsClass;
  ScrollController scrollController = ScrollController();
  var selected_city_name = "".obs;  // Observable variable

  void getLocationStart({String? cityId}) async {
    isNearbyLoading.value = true;
    isErrorInLoading.value = false;
    if (Platform.isAndroid) {
      if (latitude.isEmpty) {
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((value) async {
          final response = await get(Uri.parse(
                  "${Apis.ServerAddress}/api/getlistofdoctorbyspecialty?department_id=$id&lat=${value.latitude}&lon=${value.longitude}&city_id=${cityId ?? 0  }"))
              .timeout(const Duration(seconds: Apis.timeOut))
              .catchError((e) {
            isErrorInLoading.value = true;
          });

          // print("profile1234567890");
          print(response.request!.url);
          if (response.statusCode == 200) {
            final jsonResponse = jsonDecode(response.body);

            lat = value.latitude;
            long = value.longitude;
            specialityDoctorsClass = SpecialityDoctorsClass.fromJson(jsonResponse);
            if (specialityDoctorsClass!.data != null) {
              nextUrl.value = specialityDoctorsClass!.data!.nextPageUrl!;
              doctorList.addAll(specialityDoctorsClass!.data!.doctorData!);
            }
            isNearbyLoading.value = false;
          } else {
            isErrorInLoading.value = true;
          }
          Client().close();
        }).catchError((e) {
          customDialog(
            s1: 'error'.tr,
            s2: 'unable_to_load_data'.tr,
            s2style: Theme.of(Get.context!).textTheme.bodyLarge,
            s1style: Theme.of(Get.context!).textTheme.bodyLarge,
            s3style: Theme.of(Get.context!).textTheme.bodyLarge,
          );

          isErrorInLoading.value = true;
          isErrorInNearby.value = true;
        });
      } else {
        final response = await get(Uri.parse(
                "${Apis.ServerAddress}/api/getlistofdoctorbyspecialty?department_id=$id&lat=$latitude&lon=$longitude&city_id=${cityId ?? 0  }"))
            .timeout(const Duration(seconds: Apis.timeOut))
            .catchError((e) {
          isErrorInLoading.value = true;
        });
        print("profile1234567890");
        print(response.request!.url);
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          specialityDoctorsClass = SpecialityDoctorsClass.fromJson(jsonResponse);
          if (specialityDoctorsClass!.data != null) {
            nextUrl.value = specialityDoctorsClass!.data!.nextPageUrl!;
            doctorList.addAll(specialityDoctorsClass!.data!.doctorData!);
          }
          lat = double.parse(latitude);
          long = double.parse(longitude);
          isNearbyLoading.value = false;
        } else {
          isErrorInLoading.value = true;
        }
        Client().close();
      }
    } else {
      final response = await get(Uri.parse(
              "${Apis.ServerAddress}/api/getlistofdoctorbyspecialty?department_id=$id&lat=${0.0}&lon=${0.0}&city_id=${cityId ?? 0  }"))
          .timeout(const Duration(seconds: Apis.timeOut));
      print("profile1234567890");
      print(response.request!.url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        lat = 0.0;
        long = 0.0;
        specialityDoctorsClass = SpecialityDoctorsClass.fromJson(jsonResponse);

        if (specialityDoctorsClass!.data != null) {
          nextUrl.value = specialityDoctorsClass!.data!.nextPageUrl!;

          doctorList.addAll(specialityDoctorsClass!.data!.doctorData!);
        }
        isNearbyLoading.value = false;
      } else {
        isErrorInLoading.value = true;
      }
      Client().close();
    }
  }

  loadMoreFunc(city) async {
    if (nextUrl.value != "null") {
      isLoadingMore.value = true;
      update();
      final response =
          await get(Uri.parse("${nextUrl.value}&department_id=$id&lat=$lat&lon=$long&city=${city ?? 0}"));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        specialityDoctorsClass = SpecialityDoctorsClass.fromJson(jsonResponse);
        nextUrl.value = specialityDoctorsClass!.data?.nextPageUrl ?? "null";

        doctorList.addAll(specialityDoctorsClass!.data!.doctorData!);
        isLoadingMore.value = false;
        isNearbyLoading.value = false;
      } else {
        isLoadingMore.value = false;
      }
    }
    Client().close();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    String selected_city ="${StorageService.readData(
        key: LocalStorageKeys
            .sortCityId) ??
        "0"}";
    selected_city_name.value ="${StorageService.readData(
        key: LocalStorageKeys
            .sortCityName) ??
        "not"}";


    getLocationStart(cityId: selected_city);

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !isLoadingMore.value) {
        loadMoreFunc(selected_city);
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }
}
