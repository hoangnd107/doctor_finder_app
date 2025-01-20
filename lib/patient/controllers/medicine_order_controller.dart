import 'dart:developer';
import 'dart:ffi';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_rx/get_rx.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:videocalling_medical/patient/screens/uhome_screen.dart';
import '../../common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';


class MedicineOrderController extends GetxController {
  int type = Get.arguments['type'];
  RxInt medicine = 0.obs;
  RxDouble price = (0.0).obs;
  RxString mrp = ('').obs;
  RxString tax = ('').obs;
  RxString delivery = ('').obs;
  RxString imgPath = "".obs;
  File? sImage;
RxString pid = ''.obs;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RxBool isNameError = false.obs;
  RxBool isPhoneError = false.obs;

  RxBool isDataLoaded = false.obs;

  RxString phoneErrorText = "".obs;
  Map<String, dynamic>? paymentIntent;

  AddressModel? a;

  RxList<CartMedicine> cartList = <CartMedicine>[].obs;
  RxList<int> qlist = <int>[].obs;
String server = Apis.ServerAddress;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dateController = TextEditingController(text: convertDate(dateTime: date));
    timeController = TextEditingController(text: convertTime(time: time));
    phoneController.text = StorageService.readData(key: LocalStorageKeys.phone);
    if (type == 1) {
      medicine.value = Get.arguments['total_medicine'];
      price.value = Get.arguments['total_price'];
      qlist.value = Get.arguments['qlist'];
      mrp.value = Get.arguments['mrp'].toString();
      tax.value = Get.arguments['tax'].toString();
      delivery.value = Get.arguments['delivery'].toString();
    } else {
      imgPath.value = Get.arguments['imgPath'];
      pid.value = Get.arguments["pid"].toString();
    }
    getAddress();
  }

  getAddress() async {
    isDataLoaded.value = false;
    a = null;
    List<AddressModel> aList = await Get.find<DBHelperCart>().getAddressList();
    if (aList.length == 1) {
      a = aList.first;
    } else if (aList.isNotEmpty) {
      for (var e in aList) {
        if (e.defaultAddress == 1) {
          a = e;
          break;
        }
      }

      a ??= aList.first;
    }
    isDataLoaded.value = true;
  }

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  convertDate({required DateTime dateTime}) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  convertTime({required TimeOfDay time}) {
    return DateFormat('hh:mm a').format(DateTime(DateTime.now().year,
        DateTime.now().month, DateTime.now().day, time.hour, time.minute));
  }


  processPayment({required BuildContext context}) async {
      bottomSheet(context: context);
  }

  orderMedicine() async {
     String tax_pr = "${StorageService.readData(
        key: LocalStorageKeys
            .tax) ??
        "0"}" ?? "0";
     String deliveryCharge ="${StorageService.readData(
        key: LocalStorageKeys
            .deliverycharges) ??
        "0"}" ?? "0";

    customDialog1(
      s1: 'loading'.tr,
      s2: 'order_medicine_dialog_title'.tr,
    );
    cartList.value = await Get.find<DBHelperCart>().getCartList();
    // print(cartList[0].name.toString());
    // print(cartList[0].pId.toString());
    // print(cartList[0].mId.toString());
    // print(cartList[0].id.toString());
    // print("${int.tryParse(cartList[0].price ?? '0') ?? double.tryParse(cartList[0].price ?? '0.0'
    // )}");
    // print(cartList[0].image.toString());
    // print(cartList[0].description.toString())
    log(cartList.toString(), name: 'Cart List');
double subtotal = 0.0;
String tax_value = '';

    String testJson = "{";
    for (int i = 0; i < cartList.length; i++) {

      int quantity = qlist[i];
      double price = double.tryParse(cartList[i].price ?? '0') ?? 0.0;
      double itemTotal = quantity * price;
      subtotal += itemTotal;
      tax_value =double.parse("${((subtotal+int.parse(deliveryCharge))*int.parse(tax_pr.toString()))/100}").toStringAsFixed(2);

      testJson +=
          "\"${cartList[i].mId}\":{\"pharmacy_id\":${cartList[i].pId
          },\"id\":${cartList[i].mId
          },\"title\":\"${cartList[i].name
          }\",\"quantity\":\"${qlist[i]
          }\",\"price\":${int.tryParse(cartList[i].price ?? '0') ?? double.tryParse(cartList[i].price ?? '0.0'
              )}}${(cartList.length - 1) != i ? ',' : ''}";
    }
    testJson += "}";
    log(testJson.toString());

    var response = await post(

      Uri.parse("${Apis.ServerAddress}/api/medicine_order"),

      body: {
        "user_id": "${StorageService.readData(key: LocalStorageKeys.userId)}",
        "pharmacy_id": "${cartList.first.pId}",
        "phoneno": phoneController.text,
        "total": "${(price.value % 2 == 0
            ?  price.value.toStringAsFixed(1)
            : price.value.toStringAsFixed(1))
        }",
        "product_json": testJson,
        "payment_type": "COD",
        "tax":tax_value.toString(),
        "tax_pr":tax_pr,
        "delivery_charge":deliveryCharge,
        "address": "${a!.address}",
        "message": nameController.text,
      },
    ).timeout(const Duration(seconds: Apis.timeOut));

    if (response.statusCode == 200) {
      Get.back();
      if (jsonDecode(response.body)['status'].toString() == "1") {
        customDialog(
          s1: 'success_str'.tr,
          s2: jsonDecode(response.body)['msg'],
          onPressed: () async {
            await Get.find<DBHelperCart>().truncateTable();
            Navigator.of(Get.context!).popUntil((route) => route.isFirst);
            Get.offAllNamed(Routes.userTabScreen);
          },
        );
      } else {
        customDialog(s1: 'error'.tr, s2: jsonDecode(response.body)['msg']);
      }
    } else {
      Get.back();
      customDialog(s1: 'error'.tr, s2: response.reasonPhrase ?? "");
    }
    Client().close();

  }
  orderMedicineonline({required String tid, required String type}) async {

     String tax_pr = "${StorageService.readData(
        key: LocalStorageKeys
            .tax) ??
        "0"}" ?? "0";
     String deliveryCharge ="${StorageService.readData(
        key: LocalStorageKeys
            .deliverycharges) ??
        "0"}" ?? "0";

    customDialog1(
      s1: 'loading'.tr,
      s2: 'order_medicine_dialog_title'.tr,
    );
    cartList.value = await Get.find<DBHelperCart>().getCartList();
    // print(cartList[0].name.toString());
    // print(cartList[0].pId.toString());
    // print(cartList[0].mId.toString());
    // print(cartList[0].id.toString());
    // print("${int.tryParse(cartList[0].price ?? '0') ?? double.tryParse(cartList[0].price ?? '0.0'
    // )}");
    // print(cartList[0].image.toString());
    // print(cartList[0].description.toString());
    log(cartList.toString(), name: 'Cart List');
double subtotal = 0.0;
String tax_value = '';

    String testJson = "{";
    for (int i = 0; i < cartList.length; i++) {

      int quantity = qlist[i];
      double price = double.tryParse(cartList[i].price ?? '0') ?? 0.0;
      double itemTotal = quantity * price;
      subtotal += itemTotal;
      tax_value ="${((subtotal+int.parse(deliveryCharge))*int.parse(tax_pr.toString()))/100}";

      testJson +=
          "\"${cartList[i].mId}\":{\"pharmacy_id\":${cartList[i].pId
          },\"id\":${cartList[i].mId
          },\"title\":\"${cartList[i].name
          }\",\"quantity\":\"${qlist[i]
          }\",\"price\":${int.tryParse(cartList[i].price ?? '0') ?? double.tryParse(cartList[i].price ?? '0.0'
              )}}${(cartList.length - 1) != i ? ',' : ''}";
    }
    testJson += "}";
    log(testJson.toString());

    var response = await post(

      Uri.parse("${Apis.ServerAddress}/api/medicine_order"),

      body: {
        "user_id": "${StorageService.readData(key: LocalStorageKeys.userId)}",
        "pharmacy_id": "${cartList.first.pId}",
        "phoneno": phoneController.text,
        "transaction_id": tid,
        "total": "${(price.value % 2 == 0
            ?  price.value.toStringAsFixed(1)
            : price.value.toStringAsFixed(1))
        }",
        "product_json": testJson,
        "payment_type": type,
        "tax":tax_value.toString(),
        "tax_pr":tax_pr,
        "delivery_charge":deliveryCharge,
        "address": "${a!.address}",
        "message": nameController.text,
      },
    ).timeout(const Duration(seconds: Apis.timeOut));



    if (response.statusCode == 200) {
      Get.back();
      if (jsonDecode(response.body)['status'].toString() == "1") {
        customDialog(
          s1: 'success_str'.tr,
          s2: jsonDecode(response.body)['msg'],
          onPressed: () async {
            await Get.find<DBHelperCart>().truncateTable();
            Navigator.of(Get.context!).popUntil((route) => route.isFirst);
            Get.offAllNamed(Routes.userTabScreen);
          },
        );
      } else {
        customDialog(s1: 'error'.tr, s2: jsonDecode(response.body)['msg']);
      }
    } else {
      Get.back();
      customDialog(s1: 'error'.tr, s2: response.reasonPhrase ?? "");
    }
    Client().close();

  }

  orderPrescription() async {
    Dio d = Dio();
    var formData = dio.FormData.fromMap({
      "user_id": "${StorageService.readData(key: LocalStorageKeys.userId)}",
      "pharmacy_id": "$pid",
      "phoneno": phoneController.text,
      "address": "${a!.address}",
      "message": nameController.text,
      'prescription_file': await dio.MultipartFile.fromFile(imgPath.value, filename: imgPath.value.split("/").last),
    });
    var response = await d
        .post("${Apis.ServerAddress}/api/prescription_order", data: formData)
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      Get.back();
      // messageDialog('error'.tr, 'unable_to_load_data'.tr);
    });
    print(response.statusCode);
    log(response.toString());

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.data);
      // Get.back();

        customDialog(
          s1: 'success_str'.tr,
          s2: 'success_prescription'.tr,
          onPressed: () async {
            await Get.find<DBHelperCart>().truncateTable();
            Navigator.of(Get.context!).popUntil((route) => route.isFirst);
            Get.offAllNamed(Routes.userTabScreen);
          },
        );
      // else {
      //   customDialog(s1: 'error'.tr, s2: jsonDecode(jsonResponse.body)['msg']);
      // }
    }
  }

  RxInt selectedPaymentMethod = 2.obs;

  bottomSheet({required BuildContext context}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: AppColors.transparentColor,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.WHITE,
                      borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      15.hs,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            AppTextWidgets.boldTextWithColor(
                              text: ("${(price.value % 2 == 0
                                  ?  price.value.toStringAsFixed(1)
                                  : price.value.toStringAsFixed(1))
                              }$CURRENCY"),
                              color: AppColors.AMBER,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                      5.hs,
                      Divider(
                        color: AppColors.grey,
                        thickness: 0.7,
                      ),
                      5.hs,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AppTextWidgets.semiBoldText(
                          text: 'select_a_payment_method'.tr.toUpperCase(),
                          color: AppColors.LIGHT_GREY_TEXT,
                          size: 12,
                        ),
                      ),
                      5.hs,
                      Container(
                        height: Get.height * 0.45,
                        child: ListView(
                          children: [
                            paymentMethodCardTile(
                                title: 'method1_title'.tr,
                                explanation: 'method1_description'.tr,
                                index: 2,
                                setState: setState),
                            Divider(
                              color: AppColors.grey,
                              thickness: 0.7,
                            ),
                            paymentMethodCardTile(
                                title: 'method2_title'.tr,
                                explanation: 'common_description'.trParams(
                                    {'type': 'appointment_fee_small'.tr}),
                                index: 3,
                                setState: setState),
                            Divider(
                              color: AppColors.grey,
                              thickness: 0.7,
                            ),
                            paymentMethodCardTile(
                                title: 'method6_title'.tr,
                                explanation: 'common_description'.trParams(
                                    {'type': 'appointment_fee_small'.tr}),
                                index: 8,
                                setState: setState),
                            Divider(
                              color: AppColors.grey,
                              thickness: 0.7,
                            ),
                            // paymentMethodCardTile(
                            //     title: 'method4_title'.tr,
                            //     explanation: 'common_description'.tr,
                            //     index: 5,
                            //     setState: setState),
                            // Divider(
                            //   color: AppColors.grey,
                            //   thickness: 0.7,
                            // ),
                            paymentMethodCardTile(
                                title: 'method5_title'.tr,
                                explanation: 'common_description'.trParams(
                                    {'type': 'appointment_fee_small'.tr}),
                                index: 6,
                                setState: setState),
                            Divider(
                              color: AppColors.grey,
                              thickness: 0.7,
                            ),
                            paymentMethodCardTile(
                                title: 'method7_title'.tr,
                                explanation: 'common_description'.trParams(
                                    {'type': 'appointment_fee_small'.tr}),
                                index: 7,
                                setState: setState),
                            Divider(
                              color: AppColors.grey,
                              thickness: 0.7,
                            ),
                            paymentMethodCardTile(
                                title: 'method3_title'.tr,
                                explanation: 'common_description'.trParams(
                                    {'type': 'appointment_fee_small'.tr}),
                                index: 4,
                                setState: setState),
                            Divider(
                              color: AppColors.grey,
                              thickness: 0.7,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => CustomButton(
                    onTap: () async {
                      print("object");
                      print("object ${selectedPaymentMethod.value}");
                      // Get.back();
                      if (selectedPaymentMethod.value == 2) {
                        orderMedicine();
                      }
                      else if (selectedPaymentMethod.value == 8)
                      {
//                         print("stripe");
// print(
//
//      double.parse((price.value % 2 == 0
//     ?  price.value.toStringAsFixed(1)
//         : price.value.toStringAsFixed(1)) * 100).toString(),
// );                        // paymentIntent =
//                         // await (String amount, String currency) async {
//                         //   Map<String, dynamic> body = {
//                         //     // ((int.parse(amount)) * 100).toString()
//                         //     'amount': int.parse((price.value % 2 == 0
//                         //   ?  price.value.toStringAsFixed(1)
//                         //       : price.value.toStringAsFixed(1)) * 100).toString(),
//                         //     'currency': currency,
//                         //     'payment_method_types[]': 'card',
//                         //   };
//                         //   print(body.toString());
//                         //   var response = await http.post(
//                         //     Uri.parse(
//                         //         'https://api.stripe.com/v1/payment_intents'),
//                         //     headers: {
//                         //       'Authorization': 'Bearer $stripeSecretKey',
//                         //       'Content-Type':
//                         //       'application/x-www-form-urlencoded'
//                         //     },
//                         //     body: body,
//                         //   );
//                         //   return jsonDecode(response.body.toString());
//                         // }
//                         ("${(price.value % 2 == 0
//                             ?  price.value.toStringAsFixed(1)
//                             : price.value.toStringAsFixed(1))
//                         }", CURRENCY_CODE);
//                         // print("paymentIntent $paymentIntent");
//                         /
                        ///
                        // paymentIntent =
                        // await (String amount, String currency) async {
                        //
                        //   Map<String, dynamic> body = {
                        //     'amount': ((int.parse("123.0")) * 100).toString(),
                        //     'currency': currency,
                        //     'payment_method_types[]': 'card',
                        //   };
                        //
                        //   var response = await http.post(
                        //     Uri.parse(
                        //         'https://api.stripe.com/v1/payment_intents'),
                        //     headers: {
                        //       'Authorization': 'Bearer $stripeSecretKey',
                        //       'Content-Type':
                        //       'application/x-www-form-urlencoded'
                        //     },
                        //     body: body,
                        //   );
                        //   return jsonDecode(response.body.toString());
                        // }("123.0", CURRENCY_CODE);
                        ///
                        paymentIntent = await (String amountString, String currency) async {
                          // Convert the amount string to a double
                          double amountDouble = double.parse(amountString);

                          // Convert the amount to the smallest currency unit (e.g., cents for USD)
                          int amountInCents = (amountDouble * 100).toInt();

                          Map<String, dynamic> body = {
                            'amount': amountInCents.toString(), // Convert integer to string
                            'currency': currency,
                            'payment_method_types[]': 'card',
                          };

                          var response = await http.post(
                            Uri.parse('https://api.stripe.com/v1/payment_intents'),
                            headers: {
                              'Authorization': 'Bearer $stripeSecretKey',
                              'Content-Type': 'application/x-www-form-urlencoded'
                            },
                            body: body,
                          );

                          return jsonDecode(response.body);
                        }
                        ("${(price.value % 2 == 0
                            ?  price.value.toStringAsFixed(1)
                            : price.value.toStringAsFixed(1))
                        }", CURRENCY_CODE);

                        http.Client().close();
                        await Stripe.instance.initPaymentSheet(
                          paymentSheetParameters: SetupPaymentSheetParameters(
                            paymentIntentClientSecret:
                            paymentIntent!['client_secret'],
                            merchantDisplayName: 'Doctor Finder',
                          ),
                        );
                        displayPaymentSheet();
                      }
                      else {
                        bookAppointment(
                          amount:("${(price.value % 2 == 0
                              ?  price.value.toStringAsFixed(1)
                              : price.value.toStringAsFixed(1))
                          }") ,
                          type: selectedPaymentMethod.value.toString(),
                        );
                      }
                    },
                    btnText: selectedPaymentMethod.value == 2
                        ? 'make_an_appointment'.tr
                        : 'process_payment'.tr,
                  ),
                )
              ],
            );
          });
        });
  }

  displayPaymentSheet() async {
    print("object1");
    try {
      await Stripe.instance.presentPaymentSheet();
      customDialog(
        s1: 'success'.tr,
        s2: 'payment_success'.tr,
        dismiss: false,
        onPressed: () {
          Get.back();
          orderMedicine();
          // bookAppointment(type: "stripe", tId: paymentIntent!['id']);
          paymentIntent = null;
        },
      );
    } on StripeException catch (e) {
      customDialog(s1: 'fail'.tr, s2: "${'fail_description'.tr}\n$e");
    } catch (e) {
      customDialog(s1: 'fail'.tr, s2: "${'fail_description'.tr}\n$e");
    }
  }

  paymentMethodCardTile(
      {required String title,
        required String explanation,
        required int index,
        required StateSetter setState}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: InkWell(
          onTap: () {
            print( selectedPaymentMethod.value );
            setState(() {

              selectedPaymentMethod.value = index;
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.LIGHT_GREY_TEXT),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: selectedPaymentMethod.value == index
                        ? AppColors.AMBER
                        : AppColors.transparentColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidgets.mediumTextWithSize(
                      text: title,
                      size: 18,
                    ),
                    AppTextWidgets.blackText(
                      text: explanation,
                      color: AppColors.LIGHT_GREY_TEXT,
                      size: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  /// type 3 is paystack,
  /// type 6 is braintree,
  /// type 7 is razorpay,
  /// type 4 is rave,
  /// if payment success then call orderMedicine() function to add order

  bookAppointment({
    String? tId,
    String? amount,
    String? type,
  }) async
  {
    ///paystack
    if(type.toString() == "3"){
      print("order payment type is paystack");
      print(amount);
      String paymentLink = "${Apis.paystack(amount: amount)}";
      print(paymentLink);

      Get.toNamed(Routes.inAppWebViewScreen, arguments: {
        'url': paymentLink,
        'isDoctor': 04,
        'appointmentId':0.toString(),
      })?.then((result) {
        if (result["status"] == 'success') {
          print("order sucess");
          print(result);
          // isAppointmentMadeSuccessfully.value = true;
          customDialog01(
            s1: 'success'.tr,
            s2: 'appointment_made_success'.tr,
            onPressed: () {
              print("ok");
              print("${result["tid"]}");
              orderMedicineonline(tid: result['tid'],type: "paystack");
              Get.offAll(UserHomeScreen());
              // Get.back();
              // Get.back();
              // Get.back();
              // Get.to(MedicineOrderScreen());
              // Get.toNamed(
              //   Routes.uAppointmentDetailScreen,
              //   arguments: {
              //     'id': AppointmentId.value,
              //   },
              // );
            },
          );
          print("${result["tid"]}");
          orderMedicineonline(tid: result['tid'],type: "paystack");
        } else if (result["status"] == 'fail') {
          print("result===>> $result");
          // messageDialog('fail'.tr, 'fail_description'.tr);
        }
      });
    }
    ///braintree
    else if(type.toString() == "6"){
      print("order payment type is braintree");
      print(amount);

      String paymentLink = "${Apis.braintree(amount: amount)}";
      print(paymentLink);

      Get.toNamed(Routes.inAppWebViewScreen, arguments: {
        'url': paymentLink,
        'isDoctor': 04,
        'appointmentId':0.toString(),
      })?.then((result) {
        if (result["status"] == 'success') {
          print("order sucess");
          print(result);
          // isAppointmentMadeSuccessfully.value = true;
          customDialog01(
            s1: 'success'.tr,
            s2: 'appointment_made_success'.tr,
            onPressed: () {
              print("ok");
              print("${result["tid"]}");
              orderMedicineonline(tid: result['tid'],type: "braintree");
              Get.offAll(UserHomeScreen());
              // Get.back();
              // Get.back();
              // Get.back();
              // Get.to(MedicineOrderScreen());
              // Get.toNamed(
              //   Routes.uAppointmentDetailScreen,
              //   arguments: {
              //     'id': AppointmentId.value,
              //   },
              // );
            },
          );
          print("${result["tid"]}");
          orderMedicineonline(tid: result['tid'],type: "braintree");
        } else if (result["status"] == 'fail') {
          print("result===>> $result");
          // messageDialog('fail'.tr, 'fail_description'.tr);
        }
      });
    }
    ///razorpay
    else if(type.toString() == "7"){
      print("order payment type is razorpay");
      print(amount);
      String paymentLink = "${Apis.razorpay(amount: amount)}";
      print(paymentLink);

      Get.toNamed(Routes.inAppWebViewScreen, arguments: {
        'url': paymentLink,
        'isDoctor': 04,
        'appointmentId':0.toString(),
      })?.then((result) {
        if (result["status"] == 'success') {
          print("order sucess");
          print(result);
          // isAppointmentMadeSuccessfully.value = true;
          customDialog01(
            s1: 'success'.tr,
            s2: 'appointment_made_success'.tr,
            // dismiss: false,
            onPressed: () {
              print("ok");
              print("${result["tid"]}");
              orderMedicineonline(tid: result['tid'],type: "razorpay");
              Get.offAll(UserHomeScreen());
              // Get.back();
              // Get.back();
              // Get.back();
              // Get.to(MedicineOrderScreen());
              // Get.toNamed(
              //   Routes.uAppointmentDetailScreen,
              //   arguments: {
              //     'id': AppointmentId.value,
              //   },
              // );
            },
          );
          print("${result["tid"]}");
          orderMedicineonline(tid: result['tid'],type: "razorpay");

        } else if (result["status"] == 'fail') {
          print("result===>> $result");
          // messageDialog('fail'.tr, 'fail_description'.tr);
        }
      });
    }
    ///rave
    else if(type.toString() == "4"){
      RxString userId = ''.obs;
      userId.value = StorageService.readData(key: LocalStorageKeys.userId) ?? "";

      print("order payment type is rave");
      print(amount);
      String paymentLink = "${Apis.rave(amount: amount,uid: userId.value)}";
      print(paymentLink);

      Get.toNamed(Routes.inAppWebViewScreen, arguments: {
        'url': paymentLink,
        'isDoctor': 04,
        'appointmentId':0.toString(),
      })?.then((result) {
        if (result["status"] == 'success') {
          print("order sucess");
          print(result);
          // isAppointmentMadeSuccessfully.value = true;
          customDialog01(
            s1: 'success'.tr,
            s2: 'appointment_made_success'.tr,
            // dismiss: false,
            onPressed: () {
              print("ok");
              print("${result["tid"]}");
              orderMedicineonline(tid: result['tid'],type: "rave");
              Get.offAll(UserHomeScreen());
              // Get.back();
              // Get.back();
              // Get.back();
              // Get.to(MedicineOrderScreen());
              // Get.toNamed(
              //   Routes.uAppointmentDetailScreen,
              //   arguments: {
              //     'id': AppointmentId.value,
              //   },
              // );
            },
          );
          print("${result["tid"]}");
          orderMedicineonline(tid: result['tid'],type: "rave");

        } else if (result["status"] == 'fail') {
          print("result===>> $result");
          // messageDialog('fail'.tr, 'fail_description'.tr);
        }
      });

    }
    else{
      print("order payment type is not perfect");

    }

  //   customDialog1(s1: 'reporting_dialog1'.tr, s2: 'appoint_make_dialog'.tr);
  //
  //   String url = "${Apis.ServerAddress}/api";
  //
  //   String testJson = "{";
  //   for (int i = 0; i < cartList.length; i++) {
  //     testJson +=
  //     "\"${cartList[i].mId}\":{\"pharmacy_id\":${cartList[i].pId},\"id\":${cartList[i].mId},\"title\":\"${cartList[i].name}\",\"quantity\":\"${i + 1}\",\"price\":${int.tryParse(cartList[i].price ?? '0') ?? double.tryParse(cartList[i].price ?? '0.0')}}${(cartList.length - 1) != i ? ',' : ''}";
  //   }
  //   testJson += "}";
  //   Map mm = {};
  //
  //   if (type == 'stripe') {
  //
  //     mm = {
  //       "user_id": "${StorageService.readData(key: LocalStorageKeys.userId)}",
  //       "pharmacy_id": "${cartList.first.pId}",
  //       "phoneno": phoneController.text,
  //       "total": "${(price.value % 2 == 0
  //           ?  price.value.toStringAsFixed(1)
  //           : price.value.toStringAsFixed(1))
  //       }",
  //       "product_json": testJson,
  //       "payment_type": "COD",
  //       "address": "${a!.address}",
  //       "message": nameController.text,
  //       "stripe_payment_id": tId
  //     };
  //   }
  //   else {
  //     mm = {
  //       "user_id": "${StorageService.readData(key: LocalStorageKeys.userId)}",
  //       "pharmacy_id": "${cartList.first.pId}",
  //       "phoneno": phoneController.text,
  //       "total": "${(price.value % 2 == 0
  //           ?  price.value.toStringAsFixed(1)
  //           : price.value.toStringAsFixed(1))
  //       }",
  //       "product_json": testJson,
  //       "payment_type": "COD",
  //       "address": "${a!.address}",
  //       "message": nameController.text,
  //     };
  //   }
  //
  //   final response = await post(Uri.parse(url), body: mm);
  //
  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(response.body);
  //
  //     if (jsonResponse["success"].toString() == "1") {
  //       Get.back();
  //       // AppointmentId.value = jsonResponse['data'].toString();
  //       // if (type == 'online') {
  //       //   String? paymentLink;
  //       //
  //       //   if (selectedPaymentMethod.value == 3) {
  //       //     paymentLink =
  //       //     '${Apis.ServerAddress}/paystack-payment?id=$AppointmentId&type=1';
  //       //   }
  //       //   else if (selectedPaymentMethod.value == 4) {
  //       //     paymentLink =
  //       //     '${Apis.ServerAddress}/rave-payment?id=$AppointmentId&type=1';
  //       //   } else if (selectedPaymentMethod.value == 5) {
  //       //     paymentLink =
  //       //     '${Apis.ServerAddress}/paytm-payment?id=$AppointmentId&type=1';
  //       //   } else if (selectedPaymentMethod.value == 6) {
  //       //     paymentLink =
  //       //     '${Apis.ServerAddress}/braintree_payment?id=$AppointmentId&type=1';
  //       //   } else if (selectedPaymentMethod.value == 7) {
  //       //     paymentLink =
  //       //     '${Apis.ServerAddress}/pay_razorpay?id=$AppointmentId&type=1';
  //       //   } else if (selectedPaymentMethod.value == 8) {
  //       //     paymentLink =
  //       //     '${Apis.ServerAddress}/stripe-payment?id=$AppointmentId&type=1';
  //       //   } else {
  //       //     messageDialog('fail'.tr, 'fail_description'.tr);
  //       //   }
  //       //
  //       //   Get.toNamed(Routes.inAppWebViewScreen, arguments: {
  //       //     'url': paymentLink,
  //       //     'isDoctor': 1,
  //       //     'appointmentId': AppointmentId.value,
  //       //   })?.then((result) {
  //       //     if (result == 'success') {
  //       //       isAppointmentMadeSuccessfully.value = true;
  //       //       customDialog(
  //       //         s1: 'success'.tr,
  //       //         s2: 'appointment_made_success'.tr,
  //       //         dismiss: false,
  //       //         onPressed: () {
  //       //           Get.back();
  //       //           Get.back();
  //       //           Get.back();
  //       //           Get.toNamed(
  //       //             Routes.uAppointmentDetailScreen,
  //       //             arguments: {
  //       //               'id': AppointmentId.value,
  //       //             },
  //       //           );
  //       //         },
  //       //       );
  //       //     } else if (result == 'fail') {
  //       //       messageDialog('fail'.tr, 'fail_description'.tr);
  //       //     }
  //       //   });
  //       // }
  //       // else if (type == 'stripe') {
  //       //   customDialog(
  //       //       s1: 'success'.tr,
  //       //       s2: 'appointment_made_success'.tr,
  //       //       onPressed: () {
  //       //         Get.back();
  //       //         Get.back();
  //       //         Get.back();
  //       //         Get.toNamed(
  //       //           Routes.uAppointmentDetailScreen,
  //       //           arguments: {
  //       //             'id': AppointmentId.value,
  //       //           },
  //       //         );
  //       //       },
  //       //       dismiss: false);
  //     } else  {
  //       // isAppointmentMadeSuccessfully.value = true;
  //       customDialog(
  //         dismiss: false,
  //         s1: 'success'.tr,
  //         s2: 'appointment_made_success'.tr,
  //         onPressed: () {
  //           Get.back();
  //           Get.back();
  //           Get.back();
  //           // Get.toNamed(
  //           //   Routes.uAppointmentDetailScreen,
  //           //   arguments: {
  //           //     'id': AppointmentId.value,
  //           //   },
  //           // );
  //         },
  //       );
  //     }
  //
  //    if (jsonResponse["success"].toString() == "3") {
  //     Get.back();
  //     customDialog(
  //       s1: 'error'.tr,
  //       s2: jsonResponse['register'],
  //       // onPressed: () async {
  //       //   try {
  //       //     CallManager.instance.destroy();
  //       //     CubeChatConnection.instance.destroy();
  //       //     await PushNotificationsManager.instance.unsubscribe();
  //       //     await SharedPrefs.deleteUserData();
  //       //     await signOut();
  //       //
  //       //     CubeChatConnection.instance.logout();
  //       //   } catch (e) {}
  //       //   await SharedPreferences.getInstance().then((pref) {
  //       //     pref.clear();
  //       //     pref.setString("isBack", "1");
  //       //   });
  //       //   StorageService.writeBoolData(
  //       //     key: LocalStorageKeys.isLoggedInAsDoctor,
  //       //     value: false,
  //       //   );
  //       //   StorageService.writeBoolData(
  //       //     key: LocalStorageKeys.isLoggedIn,
  //       //     value: false,
  //       //   );
  //       //   await Get.toNamed(Routes.loginUserScreen, arguments: {
  //       //     "isBack": false,
  //       //   });
  //       // },
  //     );
  //   } else {
  //     Get.back();
  //     // messageDialog('error'.tr, jsonResponse['register']);
  //   }
  // }
    }
  }
