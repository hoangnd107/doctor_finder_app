import 'package:videocalling_medical/common/utils/app_imports.dart';

import 'package:dio/dio.dart' as dio;

class UserEditController extends GetxController {
  RxString name = "".obs;
  RxString phoneNumber = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxString confirmPassword = "".obs;
  RxString phnNumberError = "".obs;
  RxBool isPhoneNumberError = false.obs;
  RxBool isNameError = false.obs;
  RxBool isEmailError = false.obs;
  RxBool isPassError = false.obs;
  RxString token = "".obs;
  String error = "";
  String? base64image;
  File? image;
  RxBool isImageSelected = false.obs;
  RxString userId = "".obs;
  String profileImage = "";

  RxBool isLoaded = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  Future getImage() async {
    isImageSelected.value = false;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      isImageSelected.value = true;
      base64image = base64Encode(image!.readAsBytesSync());
      update();
    }
  }

  registerUser() async {
    if (name.isEmpty) {
      isNameError.value = true;
    } else if (phoneNumber.isEmpty || phoneNumber.value.length < PHONE_LENGTH) {
      isPhoneNumberError.value = true;
      phnNumberError.value = 'valid_mobile_number'.tr;
    } else if (GetUtils.isEmail(email.value) == false) {
      isEmailError.value = true;
    } else if (password != confirmPassword || password.value.length == 0) {
      isPassError.value = true;
    } else {
      customDialog1(s1: 'edit_dialog1'.tr, s2: 'edit_dialog2'.tr);
      String url = "${Apis.ServerAddress}/api/usereditprofile";

      if (image == null) {
        var response = await post(Uri.parse(url), body: {
          'id': userId.value,
          'name': name.value,
          'email': email.value,
          'phone': phoneNumber.value,
          'password': password.value,
          'token': token.value,
        }).timeout(const Duration(seconds: Apis.timeOut));

        var jsonResponse = await jsonDecode(response.body);

        if (jsonResponse['success'] == "0") {
          Get.back();
          error = jsonResponse['register'];
          customDialog(s1: 'error'.tr, s2: error);
        } else {
          StorageService.writeBoolData(
            key: LocalStorageKeys.isLoggedIn,
            value: true,
          );
          StorageService.writeStringData(
            key: LocalStorageKeys.userId,
            value: userId.value,
          );
          StorageService.writeStringData(
            key: LocalStorageKeys.name,
            value: name.value,
          );
          StorageService.writeStringData(
            key: LocalStorageKeys.phone,
            value: phoneNumber.value,
          );
          StorageService.writeStringData(
            key: LocalStorageKeys.email,
            value: email.value,
          );
          StorageService.writeStringData(
            key: LocalStorageKeys.password,
            value: password.value,
          );
          Get.back();
          Get.back();
        }
      } else {
        var d = dio.Dio();

        var formData = dio.FormData.fromMap({
          'id': userId.value,
          'name': name.value,
          'email': email.value,
          'phone': phoneNumber.value,
          'password': password.value,
          'token': token.value,
          'image': await dio.MultipartFile.fromFile(image!.path, filename: '${image!.path.split("/").last}'),
        });
        var response = await d.post(url, data: formData);

        var jsonResponse = await jsonDecode(response.data);

        if (jsonResponse['success'] == 0) {
          Get.back();
          error = jsonResponse['register'];
          customDialog(s1: 'error'.tr, s2: error);
        } else {
          StorageService.writeBoolData(
            key: LocalStorageKeys.isLoggedIn,
            value: true,
          );
          StorageService.writeStringData(
              key: LocalStorageKeys.profileImage,
              value: (Apis.userImagePath + "${jsonResponse['data']['profile_pic']}"));
          StorageService.writeStringData(
            key: LocalStorageKeys.userId,
            value: userId.value,
          );
          StorageService.writeStringData(
            key: LocalStorageKeys.name,
            value: name.value,
          );
          StorageService.writeStringData(
            key: LocalStorageKeys.phone,
            value: phoneNumber.value,
          );
          StorageService.writeStringData(
            key: LocalStorageKeys.email,
            value: email.value,
          );
          StorageService.writeStringData(
            key: LocalStorageKeys.password,
            value: password.value,
          );
          Get.back();
          Get.back();
        }
      }
    }
  }

  updateUser() async {
    customDialog1(s1: 'edit_dialog1'.tr, s2: 'edit_dialog2'.tr);
    String url = "${Apis.ServerAddress}/api/usereditprofile";

    if (image == null) {
      print("image not select");
    } else {
      var d = dio.Dio();
      var formData = dio.FormData.fromMap({
        'id': userId.value,
        'name': name.value,
        'email': email.value,
        'phone': phoneNumber.value,
        'password': password.value,
        'token': token.value,
        'image': await dio.MultipartFile.fromFile(image!.path, filename: '${image!.path.split("/").last}'),
      });
      print("formData=====> ${formData.toString()}");

      var response = await d.post(url, data: formData);

      var jsonResponse = await jsonDecode(response.data);

      if (jsonResponse['success'] == 0) {
        Get.back();
        error = jsonResponse['register'];
        customDialog(s1: 'error'.tr, s2: error);
      } else {
        StorageService.writeBoolData(
          key: LocalStorageKeys.isLoggedIn,
          value: true,
        );
        StorageService.writeStringData(
            key: LocalStorageKeys.profileImage, value: (Apis.userImagePath + "${jsonResponse['data']['profile_pic']}"));
        StorageService.writeStringData(
          key: LocalStorageKeys.userId,
          value: userId.value,
        );
        StorageService.writeStringData(
          key: LocalStorageKeys.name,
          value: name.value,
        );
        StorageService.writeStringData(
          key: LocalStorageKeys.phone,
          value: phoneNumber.value,
        );
        StorageService.writeStringData(
          key: LocalStorageKeys.email,
          value: email.value,
        );
        StorageService.writeStringData(
          key: LocalStorageKeys.password,
          value: password.value,
        );
        Get.offAllNamed(Routes.userTabScreen);
      }
    }
  }

  getToken() async {
    if (StorageService.readData(key: LocalStorageKeys.isTokenExist) == null) {
      firebaseMessaging.getToken().then((value) {
        if (value == null) return;
        token.value = value;
      });
    } else {
      token.value = StorageService.readData(key: LocalStorageKeys.token);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId.value = StorageService.readData(key: LocalStorageKeys.userId) ?? "";
    nameController.text = name.value = StorageService.readData(key: LocalStorageKeys.name) ?? "";
    phoneController.text = phoneNumber.value = StorageService.readData(key: LocalStorageKeys.phone) ?? "";
    emailController.text = email.value = StorageService.readData(key: LocalStorageKeys.email) ?? "";
    passController.text = confirmController.text =
        password.value = confirmPassword.value = StorageService.readData(key: LocalStorageKeys.password) ?? "";
    profileImage = StorageService.readData(key: LocalStorageKeys.profileImage) ?? "";
    isLoaded.value = false;
    update();
    getToken();
  }
}
