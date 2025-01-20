import 'package:videocalling_medical/common/screens/Pharmacy_home.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';

class DoctorRegisterController extends GetxController {
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
  RxString error = "".obs;
  RxBool passwordVisible = true.obs;
  RxBool passwordVisible1 = true.obs;
  final formKey = GlobalKey<FormState>();
  RxBool isPharmacy = false.obs;

  storeToken() async {
    customDialog1(s1: 'creating_account'.tr, s2: 'creating_account1'.tr);
    if (token.value.isEmpty) {
      await getToken();
    }
    final response = await post(Uri.parse("${Apis.ServerAddress}/api/savetoken"), body: {
      "token": token.value,
      "type": "1",
    }).timeout(const Duration(seconds: Apis.timeOut)).catchError((e) {
      Get.back();
      customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
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
        registerUser();
      }
    } else {
      Get.back();
      customDialog(s1: 'error'.tr, s2: response.body.toString());
    }
  }

  registerUser() async {
    if (name.value.isEmpty) {
      isNameError.value = true;
      update();
    } else if (phoneNumber.value.length < PHONE_LENGTH) {
      isPhoneNumberError.value = true;
      phnNumberError.value = 'valid_mobile_number'.tr;
      update();
    } else if (GetUtils.isEmail(email.value) == false) {
      isEmailError.value = true;
      update();
    } else if (password.value != confirmPassword.value || password.value.length == 0) {
      isPassError.value = true;
      update();
    } else if (StorageService.readData(key: LocalStorageKeys.isTokenExist) == null) {
      storeToken();
    } else {
      customDialog1(s1: 'creating_account'.tr, s2: 'creating_account1'.tr);

      String url = "${Apis.ServerAddress}/api/doctorregister";

      var response = await post(Uri.parse(url), body: {
        'name': name.value,
        'email': email.value,
        'phone': phoneNumber.value,
        'password': password.value,
        'token': token.value,
        'type': '1'
      }).timeout(const Duration(seconds: Apis.timeOut)).catchError((e) {
        Get.back();
        customDialog(s1: 'error_s'.tr, s2: 'unable_to_load_data'.tr);
      });
      Client().close();
      try {
        var jsonResponse = await jsonDecode(response.body);
        if (jsonResponse['success'].toString() == "0") {
          Get.back();
          error.value = jsonResponse['register'];
          customDialog(s1: 'error_s'.tr, s2: error.value);
        } else {
          customDialog1(
            s1: 'creating_account_f'.tr,
            s2: 'creating_account1_f'.tr,
          );

          FirebaseDatabase.instance
              .ref()
              .child('100${jsonResponse['register']['user_id']}')
              .update({
            "name": jsonResponse['register']['name'],
            "image": jsonResponse['register']['image'],
          }).then((value) async {
            FirebaseDatabase.instance
                .ref()
                .child("100${jsonResponse['register']['user_id']}")
                .child("TokenList")
                .set({
              "device": token.value,
            }).then((value) {
              StorageService.writeBoolData(
                key: LocalStorageKeys.isLoggedInAsDoctor,
                value: true,
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.userId,
                value: jsonResponse['register']['user_id'].toString(),
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.name,
                value: jsonResponse['register']['name'],
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.email,
                value: jsonResponse['register']['email'],
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.phone,
                value: jsonResponse['register']['phone'].toString(),
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.userIdWithAscii,
                value: ('100${jsonResponse['register']['user_id']}'),
              );
              callConnectyCubeRegisterApi(
                id: jsonResponse['register']['user_id'].toString(),
              );
              Get.back();
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
        customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
      }
      Client().close();
    }
  }

  registerUserPharmacy() async {
    if (name.value.isEmpty) {
      isNameError.value = true;
      update();
    } else if (phoneNumber.value.length < PHONE_LENGTH) {
      isPhoneNumberError.value = true;
      phnNumberError.value = 'valid_mobile_number'.tr;
      update();
    } else if (GetUtils.isEmail(email.value) == false) {
      isEmailError.value = true;
      update();
    } else if (password.value != confirmPassword.value || password.value.length == 0) {
      isPassError.value = true;
      update();
    } else if (StorageService.readData(key: LocalStorageKeys.isTokenExist) == null) {
      storeToken();
    } else {
      customDialog1(s1: 'creating_account'.tr, s2: 'creating_account1'.tr);
      String url = "${Apis.ServerAddress}/api/doctorregister";
      var response = await post(Uri.parse(url), body: {
        'name': name.value,
        'email': email.value,
        'phone': phoneNumber.value,
        'password': password.value,
        'token': token.value,
        'type': "2"
      }).timeout(const Duration(seconds: Apis.timeOut)).catchError((e) {
        Get.back();
        customDialog(s1: 'error_s'.tr, s2: 'unable_to_load_data'.tr);
      });
      print(response.request!.url);
      log(response.body);
      Client().close();
      try {
        var jsonResponse = await jsonDecode(response.body);
        if (jsonResponse['success'].toString() == "0") {
          Get.back();
          error.value = jsonResponse['register'];
          customDialog(s1: 'error_s'.tr, s2: error.value);
        } else {
          customDialog1(
            s1: 'creating_account_f'.tr,
            s2: 'creating_account1_f'.tr,
          );

          FirebaseDatabase.instance
              .ref()
              .child('127${jsonResponse['register']['user_id']}')
              .update({
            "name": jsonResponse['register']['name'],
            "image": jsonResponse['register']['image'],
          }).then((value) async {
            FirebaseDatabase.instance
                .ref()
                .child("127${jsonResponse['register']['user_id']}")
                .child("TokenList")
                .set({
              "device": token.value,
            }).then((value) {
              StorageService.writeBoolData(
                key: LocalStorageKeys.isLoggedInAsPharmacy,
                value: true,
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.userId,
                value: jsonResponse['register']['user_id'].toString(),
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.name,
                value: jsonResponse['register']['name'],
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.email,
                value: jsonResponse['register']['email'],
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.phone,
                value: jsonResponse['register']['phone'].toString(),
              );
              StorageService.writeStringData(
                key: LocalStorageKeys.userIdWithAscii,
                value: ('127${jsonResponse['register']['user_id']}'),
              );
              Get.offAllNamed(Routes.doctorTabScreen);
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
      Client().close();
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

  callConnectyCubeRegisterApi({required String id}) async {
    try {
      // customDialog1(
      //   s1: 'creating_account_c'.tr,
      //   s2: 'creating_account1_c'.tr,
      //   s1style: Theme.of(Get.context!).textTheme.bodyLarge,
      //   s2style: Theme.of(Get.context!).textTheme.bodyMedium,
      // );
      var response = await post(
        Uri.parse('${Apis.ServerAddress}/api/connectycube_register'),
        body: {
          'type': '2',
          'doctor_id': id,
        },
      );
      print(response.request!.url);
      print(response.body);
      print(response.statusCode);

      Client().close();

      if (response.statusCode == 200 && jsonDecode(response.body)['status'].toString() == '1') {
        var jsonResponse = jsonDecode(response.body);
        ConnectyCubeSessionService.loginToCC(
          CubeUser(
            id: jsonResponse['data']['connectycube_user_id'],
            login: jsonResponse['data']['login_id'],
            fullName: "John smith 1".replaceAll(" ", ""),
            password: "123456",
          ),
          onTap: () {
            Future.delayed(const Duration(seconds: 3)).then(
              (value) {
                Get.offAllNamed(
                  Routes.chooseYourPlanScreen,
                  arguments: {
                    'doctorUrl': "",
                  },
                );
                changeNotifier.updateString("Done");
              },
            );
          },
        );
      } else {
        Future.delayed(const Duration(seconds: 3)).then(
          (value) {
            Get.offAllNamed(
              Routes.chooseYourPlanScreen,
              arguments: {
                'doctorUrl': "",
              },
            );
          },
        );
      }
    } catch (e) {
      Future.delayed(const Duration(seconds: 3)).then(
        (value) {
          Get.offAllNamed(
            Routes.chooseYourPlanScreen,
            arguments: {
              'doctorUrl': "",
            },
          );
        },
      );
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
    getToken();
    isPharmacy.value = Get.arguments["isPharmacy"];
  }
}

///
// import 'package:videocalling_medical/common/utils/app_imports.dart';
// import 'package:videocalling_medical/common/utils/video_call_imports.dart';
//
// class DoctorRegisterController extends GetxController {
//   RxString name = "".obs;
//   RxString phoneNumber = "".obs;
//   RxString email = "".obs;
//   RxString password = "".obs;
//   RxString confirmPassword = "".obs;
//   RxString phnNumberError = "".obs;
//   RxBool isPhoneNumberError = false.obs;
//   RxBool isNameError = false.obs;
//   RxBool isEmailError = false.obs;
//   RxBool isPassError = false.obs;
//   RxString token = "".obs;
//   RxString error = "".obs;
//   RxBool passwordVisible = true.obs;
//   RxBool passwordVisible1 = true.obs;
//   RxBool isPharmacy = false.obs;
//
//   final formKey = GlobalKey<FormState>();
//
//   storeToken() async {
//     customDialog1(s1: 'creating_account'.tr, s2: 'creating_account1'.tr);
//     if (token.value.isEmpty) {
//       await getToken();
//     }
//     final response =
//     await post(Uri.parse("${Apis.ServerAddress}/api/savetoken"), body: {
//       "token": token.value,
//       "type": "1",
//     }).timeout(const Duration(seconds: Apis.timeOut)).catchError((e) {
//       Get.back();
//       customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
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
//         registerUser();
//       }
//     } else {
//       Get.back();
//       customDialog(s1: 'error'.tr, s2: response.body.toString());
//     }
//   }
//
//   registerUser() async {
//     if (name.value.isEmpty) {
//       isNameError.value = true;
//       update();
//     } else if (phoneNumber.value.length < PHONE_LENGTH) {
//       isPhoneNumberError.value = true;
//       phnNumberError.value = 'valid_mobile_number'.tr;
//       update();
//     } else if (GetUtils.isEmail(email.value) == false) {
//       isEmailError.value = true;
//       update();
//     } else if (password.value != confirmPassword.value ||
//         password.value.length == 0) {
//       isPassError.value = true;
//       update();
//     } else if (StorageService.readData(key: LocalStorageKeys.isTokenExist) ==
//         null) {
//       storeToken();
//     } else {
//       customDialog1(s1: 'creating_account'.tr, s2: 'creating_account1'.tr);
//       String url =
//           "${Apis.ServerAddress}/api/doctorregister?name=${name.value}&email=${email
//           .value}&phone=${phoneNumber.value}&password=${password.value}&token=${token
//           .value}";
//
//       var response = await post(Uri.parse(url), body: {
//         'name': name.value,
//         'email': email.value,
//         'phone': phoneNumber.value,
//         'password': password.value,
//         'token': token.value
//       }).timeout(const Duration(seconds: Apis.timeOut)).catchError((e) {
//         Get.back();
//         customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
//       });
//
//       print(response.statusCode);
//       print(response.body);
//       print(response.request!.url);
//
//
//       try {
//         var jsonResponse = await jsonDecode(response.body);
//         if (jsonResponse['success'].toString() == "0") {
//           Get.back();
//           error.value = jsonResponse['register'];
//           customDialog(s1: 'error'.tr, s2: error.value);
//         } else {
//           FirebaseDatabase.instance
//               .ref()
//               .child('100${jsonResponse['register']['user_id']}')
//               .update({
//             "name": jsonResponse['register']['name'],
//             "image": jsonResponse['register']['image'],
//           }).then((value) async {
//             FirebaseDatabase.instance
//                 .ref()
//                 .child("100${jsonResponse['register']['user_id']}")
//                 .child("TokenList")
//                 .set({
//               "device": token.value,
//             }).then((value) {
//               StorageService.writeBoolData(
//                 key: LocalStorageKeys.isLoggedInAsDoctor,
//                 value: true,
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.userId,
//                 value: jsonResponse['register']['user_id'].toString(),
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.name,
//                 value: jsonResponse['register']['name'],
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.email,
//                 value: jsonResponse['register']['email'],
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.phone,
//                 value: jsonResponse['register']['phone'].toString(),
//               );
//               StorageService.writeStringData(
//                 key: LocalStorageKeys.userIdWithAscii,
//                 value: ('100${jsonResponse['register']['doctor_id']}'),
//               );
//               callConnectyCubeRegisterApi(
//                 id: jsonResponse['register']['user_id'].toString(),
//               );
//               Get.back();
//             });
//           });
//         }
//       } catch (e) {
//         Get.back();
//         customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
//       }
//       Client().close();
//     }
//   }
//
//   callConnectyCubeRegisterApi({required String id}) async {
//     print("login to cc");
//     try {
//       customDialog1(
//         s1: 'creating_account'.tr,
//         s2: 'creating_account1'.tr,
//       );
//       var response = await post(
//         Uri.parse('${Apis.ServerAddress}/api/connectycube_register'),
//         body: {
//           'type': '2',
//           'doctor_id': id,
//         },
//       );
//
//       print(response.request!.url);
//       print(response.body);
//       print(response.statusCode);
//
//       Client().close();
//
//       if (response.statusCode == 200 &&
//           jsonDecode(response.body)['status'].toString() == '1') {
//         var jsonResponse = jsonDecode(response.body);
//         ConnectyCubeSessionService.loginToCC(
//           CubeUser(
//             id: jsonResponse['data']['connectycube_user_id'],
//             login: jsonResponse['data']['login_id'],
//             fullName: "John smith 1".replaceAll(" ", ""),
//             password: "123456",
//           ),
//           onTap: () {
//             Future.delayed(const Duration(seconds: 3)).then(
//                   (value) {
//                 Get.offAllNamed(
//                   Routes.chooseYourPlanScreen,
//                   arguments: {
//                     'doctorUrl': "",
//                   },
//                 );
//                 changeNotifier.updateString("Done");
//               },
//             );
//           },
//         );
//       } else {
//         Future.delayed(const Duration(seconds: 3)).then(
//               (value) {
//             Get.offAllNamed(
//               Routes.chooseYourPlanScreen,
//               arguments: {
//                 'doctorUrl': "",
//               },
//             );
//           },
//         );
//       }
//     } catch (e) {
//       Future.delayed(const Duration(seconds: 3)).then(
//             (value) {
//           Get.offAllNamed(
//             Routes.chooseYourPlanScreen,
//             arguments: {
//               'doctorUrl': "",
//             },
//           );
//         },
//       );
//     }
//   }
//
//   getToken() async {
//     if (StorageService.readData(key: LocalStorageKeys.isTokenExist) == null) {
//       firebaseMessaging.getToken().then((value) {
//         if (value == null) return;
//         token.value = value;
//       });
//     } else {
//       token.value = StorageService.readData(key: LocalStorageKeys.token);
//     }
//   }
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     getToken();
//   }
// }
