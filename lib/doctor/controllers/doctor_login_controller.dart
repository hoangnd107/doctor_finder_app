import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';

class DoctorLoginController extends GetxController {
  RxString emailAddress = "".obs;
  RxString pass = "".obs;
  RxBool isPhoneNumberError = false.obs;
  RxBool isPasswordError = false.obs;
  RxString passErrorText = "".obs;
  RxString token = "".obs;
  RxString selectedValue = ''.obs;
  ValueNotifier<String?> selectedValue1 = ValueNotifier(null);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  getToken() async {
    if (StorageService.readData(key: LocalStorageKeys.isTokenExist) == null) {
      firebaseMessaging.getToken().then((value) {
        if (value == null) return;
        token.value = value;
      });
      print("token=====>>");
      print(token.value);
    } else {
      token.value = StorageService.readData(key: LocalStorageKeys.token);
      print("token=====>>");
      print(token.value);
    }
  }

  storeToken() async {
    customDialog1(s1: 'login_dialog_title'.tr, s2: 'login_dialog_description'.tr);
    if (token.value.isEmpty) {
      await getToken();
      print("token=====>>");
      print(token.value);
    }
    print("token=====>>");
    print(token.value);
    final response = await post(Uri.parse("${Apis.ServerAddress}/api/savetoken"), body: {
      "token": token.value,
      "type": "1",
    }).timeout(const Duration(seconds: Apis.timeOut)).catchError((e) {
      Get.back();
      customDialog(s1: 'error'.tr, s2: 'unable_to_save_token'.tr);
    });
    if (response.statusCode == 200) {
      Get.back();
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'].toString() == "1") {
        StorageService.writeBoolData(
          key: LocalStorageKeys.isTokenExist,
          value: true,
        );
        StorageService.writeStringData(
          key: LocalStorageKeys.token,
          value: token.value,
        );
        loginInto();
      }
    } else {
      Get.back();
      customDialog(s1: 'error'.tr, s2: response.body.toString());
    }
  }

  loginInto() async {
    if (GetUtils.isEmail(emailAddress.value) == false) {
      isPhoneNumberError.value = true;
    } else if (pass.value.isEmpty || pass.value.length < PASS_LENGTH) {
      isPasswordError.value = true;
      passErrorText.value = 'enter_6_characters'.tr;
    } else if (StorageService.readData(key: LocalStorageKeys.isTokenExist) == null) {
      storeToken();
    } else {
      customDialog1(s1: 'login_dialog_title'.tr, s2: 'login_dialog_description'.tr);
      String url = "${Apis.ServerAddress}/api/doctorlogin";
      var response = await post(Uri.parse(url), body: {
        'email': emailAddress.value,
        'password': pass.value,
        'token': token.value,
        "type": "1"
      }).timeout(const Duration(seconds: Apis.timeOut));

      print(response.request!.url);

      try {
        var jsonResponse = await jsonDecode(response.body);
        if (jsonResponse['success'].toString() == "0") {
          Get.back();
          isPasswordError.value = true;
          passErrorText.value = 'either_mobile_number_is_incorrect'.tr;
        } else {
          Get.back();
          customDialog1(
            s1: 'creating_account_f'.tr,
            s2: 'creating_account1_f'.tr,
            s1style: Theme.of(Get.context!).textTheme.bodyLarge,
            s2style: Theme.of(Get.context!).textTheme.bodyMedium,
          );

          FirebaseDatabase.instance
              .ref()
              .child('100${jsonResponse['register']['doctor_id']}')
              .update({
            "name": jsonResponse['register']['name'],
            "image": jsonResponse['register']['profile_pic'],
          }).then((value) async {
            FirebaseDatabase.instance
                .ref()
                .child("100${jsonResponse['register']['doctor_id']}")
                .child("TokenList")
                .set({
              "device": token.value,
            }).then((value) {
              StorageService.writeBoolData(
                key: LocalStorageKeys.isLoggedInAsDoctor,
                value: true,
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.userIdWithAscii,
                value: ("100${jsonResponse['register']['doctor_id']}"),
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.userId,
                value: jsonResponse['register']['doctor_id'].toString(),
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.name,
                value: jsonResponse['register']['name'],
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.phone,
                value: jsonResponse['register']['phone'] == null
                    ? ""
                    : jsonResponse['register']['phone'].toString(),
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.email,
                value: jsonResponse['register']['email'],
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.callerImage,
                value: jsonResponse['register']['profile_pic'].toString(),
              );

              if (jsonResponse['register']['connectycube_user_id'].runtimeType !=
                  String) {
                CubeUser user = CubeUser(
                  id: jsonResponse['register']['connectycube_user_id'],
                  login: jsonResponse['register']['login_id'],
                  fullName:
                      jsonResponse['register']['name'].toString().replaceAll(" ", ""),
                  password: jsonResponse['register']['connectycube_password'].toString(),
                );
                ConnectyCubeSessionService.loginToCC(
                  user,
                  onTap: () {
                    Get.offAllNamed(Routes.doctorTabScreen);
                    changeNotifier.updateString("Done");
                  },
                );
              } else {
                Get.back();
                customDialog(s1: 'error'.tr, s2: 'error3'.tr);
              }
            }).catchError((error) {
              Get.back();
              messageDialog('error_f'.tr, 'firebase_not_add'.tr);
            });
          }).catchError((error) {
            Get.back();
            messageDialog('error_f'.tr, 'firebase_not_add'.tr);
          });
        }
      } catch (e) {
        Get.back();
        messageDialog('error_s'.tr, 'unable_to_load_data'.tr,);
      }
    }
  }
  messageDialog(String s1, String s2) {
    customDialog(
      s1: s1,
      s2: s2,
      s1style: Theme.of(Get.context!).textTheme.bodyLarge,
      s2style: Theme.of(Get.context!).textTheme.bodyLarge,
      s3style: Theme.of(Get.context!).textTheme.bodyLarge,
    );
  }

  loginIntopharmacy() async {
    if (GetUtils.isEmail(emailAddress.value) == false) {
      isPhoneNumberError.value = true;
    } else if (pass.value.isEmpty || pass.value.length < PASS_LENGTH) {
      isPasswordError.value = true;
      passErrorText.value = 'enter_6_characters'.tr;
    } else if (StorageService.readData(key: LocalStorageKeys.isTokenExist) == null) {
      storeToken();
    } else {
      customDialog1(s1: 'login_dialog_title'.tr, s2: 'login_dialog_description'.tr);
      String url = "${Apis.ServerAddress}/api/doctorlogin";
      var response = await post(Uri.parse(url), body: {
        'email': emailAddress.value,
        'password': pass.value,
        'token': token.value,
        "type": "2"
      }).timeout(const Duration(seconds: Apis.timeOut));

      print(response.request!.url);
      log(response.body);

      try {
        var jsonResponse = await jsonDecode(response.body);
        if (jsonResponse['success'].toString() == "0") {
          Get.back();
          isPasswordError.value = true;
          passErrorText.value = 'either_mobile_number_is_incorrect'.tr;
        } else {
          customDialog1(
            s1: 'creating_account_f'.tr,
            s2: 'creating_account1_f'.tr,
            s1style: Theme.of(Get.context!).textTheme.bodyLarge,
            s2style: Theme.of(Get.context!).textTheme.bodyMedium,
          );
          FirebaseDatabase.instance
              .ref()
              .child('127${jsonResponse['register']['doctor_id']}')
              .update({
            "name": jsonResponse['register']['name'],
            "image": jsonResponse['register']['profile_pic'],
          }).then((value) async {
            FirebaseDatabase.instance
                .ref()
                .child('127${jsonResponse['register']['doctor_id']}')
                .child("TokenList")
                .set({
              "device": token.value,
            }).then((value) {
              print("pharmacy get success");

              StorageService.writeBoolData(
                key: LocalStorageKeys.isLoggedInAsPharmacy,
                value: true,
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.userIdWithAscii,
                value: ("127${jsonResponse['register']['doctor_id']}"),
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.userId,
                value: jsonResponse['register']['doctor_id'].toString(),
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.name,
                value: jsonResponse['register']['name'],
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.phone,
                value: jsonResponse['register']['phone'] == null
                    ? ""
                    : jsonResponse['register']['phone'].toString(),
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.email,
                value: jsonResponse['register']['email'],
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.callerImage,
                value: jsonResponse['register']['profile_pic'].toString(),
              );

              // Get.offAllNamed(Routes.doctorTabScreen);
              emailAddress.value = "";
              email.clear();
              password.clear();
              pass.value = "";

              Get.offAllNamed(Routes.doctorTabScreen);

              changeNotifier.updateString("Done");
              if (jsonResponse['register']['connectycube_user_id'].runtimeType !=
                  String) {
              } else {
                Get.back();
                customDialog(s1: 'error'.tr, s2: 'error3'.tr);
              }
            }).catchError((error) {
              Get.back();
              messageDialog('error_f'.tr, 'firebase_not_add'.tr);
            });
          }).catchError((error) {
            Get.back();
            messageDialog('error_f'.tr, 'firebase_not_add'.tr);
          });
        }
      } catch (e) {
        Get.back();
        customDialog(s1: 'error_s'.tr, s2: 'unable_to_load_data'.tr);
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
  }
}
///
// import 'package:videocalling_medical/common/utils/app_imports.dart';
// import 'package:videocalling_medical/common/utils/video_call_imports.dart';
//
// class DoctorLoginController extends GetxController {
//   RxString emailAddress = "".obs;
//   RxString pass = "".obs;
//   RxBool isPhoneNumberError = false.obs;
//   RxBool isPasswordError = false.obs;
//   RxString passErrorText = "".obs;
//   RxString token = "".obs;
//   RxString selectedValue = ''.obs;
//
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//
//   getToken() async {
//     if (StorageService.readData(key: LocalStorageKeys.isTokenExist) == null) {
//       firebaseMessaging.getToken().then((value) {
//         if (value == null) return;
//         token.value = value;
//       });
//       print("token=====>>");
//       print(token.value);
//     } else {
//       token.value = StorageService.readData(key: LocalStorageKeys.token);
//       print("token=====>>");
//       print(token.value);
//     }
//   }
//
//   storeToken() async {
//     customDialog1(
//         s1: 'login_dialog_title'.tr, s2: 'login_dialog_description'.tr);
//     if (token.value.isEmpty) {
//       await getToken();
//     }
//     print("token=====>>");
//     print(token.value);
//     final response =
//     await post(Uri.parse("${Apis.ServerAddress}/api/savetoken"), body: {
//       "token": token.value,
//       "type": "1",
//     }).timeout(const Duration(seconds: Apis.timeOut)).catchError((e) {
//       Get.back();
//       customDialog(s1: 'error'.tr, s2: 'unable_to_save_token'.tr);
//     });
//     if (response.statusCode == 200) {
//       Get.back();
//       final jsonResponse = jsonDecode(response.body);
//       if (jsonResponse['success'].toString() == "1") {
//         StorageService.writeBoolData(
//           key: LocalStorageKeys.isTokenExist,
//           value: true,
//         );
//         StorageService.writeStringData(
//           key: LocalStorageKeys.token,
//           value: token.value,
//         );
//         loginInto();
//       }
//     } else {
//       Get.back();
//       customDialog(s1: 'error'.tr, s2: response.body.toString());
//     }
//   }
//
//   loginInto() async {
//     if (GetUtils.isEmail(emailAddress.value) == false) {
//       isPhoneNumberError.value = true;
//     } else if (pass.value.isEmpty || pass.value.length < PASS_LENGTH) {
//       isPasswordError.value = true;
//       passErrorText.value = 'enter_6_characters'.tr;
//     } else if (StorageService.readData(key: LocalStorageKeys.isTokenExist) ==
//         null) {
//       storeToken();
//     } else {
//       customDialog1(
//           s1: 'login_dialog_title'.tr, s2: 'login_dialog_description'.tr);
//       String url = "${Apis.ServerAddress}/api/doctorlogin";
//       var response = await post(Uri.parse(url), body: {
//         'email': emailAddress.value,
//         'password': pass.value,
//         'token': token.value,
//       }).timeout(const Duration(seconds: Apis.timeOut));
//
//       try {
//         var jsonResponse = await jsonDecode(response.body);
//         if (jsonResponse['success'].toString() == "0") {
//           Get.back();
//           isPasswordError.value = true;
//           passErrorText.value = 'either_mobile_number_is_incorrect'.tr;
//         } else {
//           FirebaseDatabase.instance
//               .ref()
//               .child('100${jsonResponse['register']['doctor_id']}')
//               .update({
//             "name": jsonResponse['register']['name'],
//             "image": jsonResponse['register']['profile_pic'],
//           }).then((value) async {
//             FirebaseDatabase.instance
//                 .ref()
//                 .child("100${jsonResponse['register']['doctor_id']}")
//                 .child("TokenList")
//                 .set({
//               "device": token.value,
//             }).then((value) {
//               StorageService.writeBoolData(
//                 key: LocalStorageKeys.isLoggedInAsDoctor,
//                 value: true,
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.userIdWithAscii,
//                 value: ("100${jsonResponse['register']['doctor_id']}"),
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.userId,
//                 value: jsonResponse['register']['doctor_id'].toString(),
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.name,
//                 value: jsonResponse['register']['name'],
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.phone,
//                 value: jsonResponse['register']['phone'] == null
//                     ? ""
//                     : jsonResponse['register']['phone'].toString(),
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.email,
//                 value: jsonResponse['register']['email'],
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.callerImage,
//                 value: jsonResponse['register']['profile_pic'].toString(),
//               );
//
//               if (jsonResponse['register']['connectycube_user_id']
//                   .runtimeType !=
//                   String) {
//                 CubeUser user = CubeUser(
//                   id: jsonResponse['register']['connectycube_user_id'],
//                   login: jsonResponse['register']['login_id'],
//                   fullName: jsonResponse['register']['name']
//                       .toString()
//                       .replaceAll(" ", ""),
//                   password: jsonResponse['register']['connectycube_password']
//                       .toString(),
//                 );
//                 ConnectyCubeSessionService.loginToCC(
//                   user,
//                   onTap: () {
//                     Get.offAllNamed(Routes.doctorTabScreen);
//                     changeNotifier.updateString("Done");
//                   },
//                 );
//               } else {
//                 Get.back();
//                 customDialog(s1: 'error'.tr, s2: 'error3'.tr);
//               }
//             });
//           });
//         }
//       } catch (e) {
//         Get.back();
//         customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
//       }
//     }
//   }
//
//   @override
//   void onInit() {
//     TODO: implement onInit
    // super.onInit();
    // getToken();
  // }
// }
