import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';
import 'package:http/http.dart'as http;

customDialog({
  required String s1,
  required String s2,
  TextStyle? s1style,
  TextStyle? s2style,
  TextStyle? s3style,
  VoidCallback? onPressed,
  bool dismiss = true,
}) {
  Get.dialog(
    AlertDialog(
      title: Text(
        s1,
        style: s1style ??
            const TextStyle(fontFamily: AppFontStyleTextStrings.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s2,
            maxLines: 3,
            style: s2style ??
                const TextStyle(
                  fontFamily: AppFontStyleTextStrings.regular,
                  fontSize: 14,
                ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: onPressed ??
              () {
                Get.back();
              },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(Get.context!).primaryColor,
          ),
          child: Text(
            'ok_btn'.tr,
            style: s3style ??
                const TextStyle(
                  fontFamily: AppFontStyleTextStrings.medium,
                  color: AppColors.BLACK,
                ),
          ),
        ),
      ],
    ),
    barrierDismissible: dismiss,
  );
}

void customDialog01({
  required String s1,
  required String s2,
  TextStyle? s1style,
  TextStyle? s2style,
  TextStyle? s3style,
  VoidCallback? onPressed,
  bool dismiss = true,
}) {
  Get.dialog(
    AlertDialog(
      title: Text(
        s1,
        style: s1style ??
            const TextStyle(fontFamily: AppFontStyleTextStrings.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s2,
            maxLines: 3,
            style: s2style ??
                const TextStyle(
                  fontFamily: AppFontStyleTextStrings.regular,
                  fontSize: 14,
                ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: onPressed ??
                  () {
                print("OK button pressed");
                Get.back();
              },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(Get.context!).primaryColor,
          ),
          child: Text(
            'ok_btn'.tr,
            style: s3style ??
                const TextStyle(
                  fontFamily: AppFontStyleTextStrings.medium,
                  color: AppColors.BLACK,
                ),
          ),
        ),
      ],
    ),
    barrierDismissible: dismiss,
  );
}

customDialog1({
  required String s1,
  required String s2,
  TextStyle? s1style,
  TextStyle? s2style,
}) {
  Get.dialog(AlertDialog(
    title: Text(
      s1,
      style: s1style ??
          const TextStyle(
            fontFamily: AppFontStyleTextStrings.regular,
          ),
    ),
    content: Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              s2,
              style: s2style ??
                  const TextStyle(
                    fontFamily: AppFontStyleTextStrings.regular,
                    fontSize: 12,
                  ),
            ),
          )
        ],
      ),
    ),
  ));
}

  customDialog2({
    required String s1,
    required String s2,
    TextStyle? s1style,
    TextStyle? s2style,
    TextStyle? s3style,
    required VoidCallback onPressedYes,
    required VoidCallback onPressedNo,
  }) {
    Get.dialog(AlertDialog(
      title: Text(
        s1,
        style:
            s1style ?? const TextStyle(fontFamily: AppFontStyleTextStrings.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s2,
            maxLines: 3,
            style: s2style ??
                const TextStyle(
                  fontSize: 14,
                  fontFamily: AppFontStyleTextStrings.regular,
                ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: onPressedYes,
          child: Text('yes_btn'.tr),
        ),
        TextButton(
          onPressed: onPressedNo,
          child: Text('no_btn'.tr),
        ),
      ],
    ));
  }

class CustomDialogWithTextField extends StatefulWidget {
  final String s1;
  final String s2;
  final String deliveryCharge;
  final String tax;
  final TextStyle? s1style;
  final TextStyle? s2style;
  final VoidCallback onPressedOk;
  final VoidCallback onPressedCancel;
  final TextEditingController textController;

  const CustomDialogWithTextField({
    Key? key,
    required this.s1,
    required this.s2,
    required this.deliveryCharge,
    required this.tax,
    this.s1style,
    this.s2style,
    required this.onPressedOk,
    required this.onPressedCancel,
    required this.textController,
  }) : super(key: key);

  @override
  _CustomDialogWithTextFieldState createState() => _CustomDialogWithTextFieldState();
}

class _CustomDialogWithTextFieldState extends State<CustomDialogWithTextField> {
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    widget.textController.clear();
    return AlertDialog(
      title: Text(
        widget.s1,
        // fontFamily:
        // AppFontStyleTextStrings.regular,
        style: widget.s1style ?? const TextStyle(     fontFamily:
        AppFontStyleTextStrings.regular, fontWeight: FontWeight.bold),
      ),
      // content: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       widget.s2,
      //       maxLines: 3,
      //       style: widget.s2style ?? const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
      //     ),
      //     const SizedBox(height: 20),
      //     TextField(
      //       controller: widget.textController,
      //       cursorColor: AppColors.grey, // Set the cursor color to grey
      //       decoration: InputDecoration(
      //         hintStyle: TextStyle(
      //           color: AppColors.grey
      //         ),
      //         hintText: 'Enter medicine price',
      //         errorText: errorMessage,
      //         border: const UnderlineInputBorder(), // Default border
      //         focusedBorder: UnderlineInputBorder( // Border when the TextField is focused
      //           borderSide: BorderSide(color: Colors.grey), // Set the border color to grey
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      elevation: 0,
      titlePadding:  EdgeInsets.all(12),
      actionsPadding: EdgeInsets.only(right: 12,left: 12,bottom: 10,top: 0),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
             bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.s2,
                maxLines: 3,
                style: widget.s2style ?? const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: widget.textController,
                cursorColor: AppColors.grey,
                keyboardType: TextInputType.number,// Set the cursor color to grey
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: AppColors.grey
                  ),
                  hintText: 'medicine_hint'.tr,
                  errorText: errorMessage,
                  border: const UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                ),
              )
            ],
          ),
        ),

        Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    Text(
                      "${'delivery_charges'.tr} ",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily:
                        AppFontStyleTextStrings
                            .regular,
                        fontSize: 14,
                        color: AppColors.grey,
                      ),
                    ),
                    Spacer(),
                    Text(
                        "+${widget.deliveryCharge}$CURRENCY",
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(
                          fontWeightDelta: 2,
                          fontSizeDelta: 2,
                        )
                    ),
                  ],
                ),
                5.hs,
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    Text(
                      "${'tax'.tr} ",
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily:
                        AppFontStyleTextStrings
                            .regular,
                        fontSize: 14,
                        color: AppColors.grey,
                      ),
                    ),
                    Spacer(),
                    Text(
                        "+${widget.tax}%",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(
                          fontWeightDelta: 2,
                          fontSizeDelta: 2,
                        )
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        8.hs,
        Row(
          children: [
            Expanded(
              child: InkWell(
                  onTap: () async {
                    // changeOrderStatus(1);
                    if (widget.textController.text.isEmpty) {
                      setState(() {
                        errorMessage = 'empty_price'.tr;
                      });
                    } else {
                      setState(() {
                        errorMessage = null;
                      });
                      widget.onPressedOk(); // Proceed with the OK action
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.color1,
                            AppColors.color2,
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        // border: Border.all(width: 2,
                        //   color: AppColors.greyShade3,
                        // ),
                        borderRadius:
                        BorderRadius.circular(15)),
                    height: 50,
                    width: 54,
                    child: Text(
                      'send_btn'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(
                        fontWeightDelta: 1,
                        color: AppColors.WHITE,
                        fontSizeDelta: 1.5,
                      ),
                    ),)),
            ),
            SizedBox(width: 8,),
            Expanded(
              child: InkWell(
                  onTap: () async {
                    widget.onPressedCancel();
                    // changeOrderStatus(6);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.color1,
                            AppColors.color2,
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius:
                        BorderRadius.circular(15)),
                    height: 50,
                    width: 54,
                    child: Text(
                      'btn_cancel'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(
                        fontWeightDelta: 1,
                        fontSizeDelta: 1.5,
                        color: AppColors.WHITE,
                      ),

                    ),)),
            ),

          ],
        ),
      ],
    );
  }
}



logoutDialog(
    {required String s1, required String s2, required VoidCallback onPressed}) {
  Get.dialog(AlertDialog(
    title: Text(
      s1,
      style: const TextStyle(fontFamily: AppFontStyleTextStrings.black),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s2,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: AppFontStyleTextStrings.regular,
          ),
        )
      ],
    ),
    actions: [
      TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(Get.context!).hintColor,
        ),
        child: AppTextWidgets.mediumTextWithColor(
          text: 'yes_btn'.tr,
          color: AppColors.BLACK,
        ),
      ),
    ],
  ));
}

errorDialog({required String message}) {
  Get.dialog(AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Icon(
          Icons.error,
          size: 80,
          color: AppColors.RED,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          message.toString(),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  ));
}


Future<void> registerUser(String appId, String secret, String userId) async {
  final url = 'https://api.zegocloud.com/v1/users/register';

  final response = await http.post(
    Uri.parse(url),
    headers: {
        'Content-Type': 'application/json',
      'appId': "1432439908",
      'secret': secret,
    },
    body: json.encode({
      'userId': userId,
    }),
  );

  if (response.statusCode == 200) {
    print('User registered successfully: ${response.body}');
  } else {
    print('Failed to register user: ${response.statusCode} ${response.body}');
  }
}


callOptionDialog({required int callId, required int uid}) {
  Get.dialog(AlertDialog(
    title: Text('call_dialog_title'.tr),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: Get.width / 4,
                child: InkWell(
                  // onTap: () async {
                  //   Get.back();
                  //   CallManager.instance.startNewCall(
                  //       Get.context!, CallType.AUDIO_CALL, {callId}, uid: uid);
                  // },
                  onTap: () async {
                    var microphoneStatus = await Permission.microphone.status;
                    if ( !microphoneStatus.isGranted) {
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.microphone,
                      ].request();
                      microphoneStatus = statuses[Permission.microphone]!;
                      if (!microphoneStatus.isGranted) {
                        Get.snackbar(
                          'PermissionsRequired'.tr,
                          'audiocalldetail'.tr,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                    }

                    Get.back();
                    CallManager.instance.startNewCall(
                        Get.context!, CallType.AUDIO_CALL, {callId}, uid: uid);
                  },

                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.color1,
                                AppColors.color2,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          height: 50,
                          width: Get.width / 4,
                        ),
                      ),
                      const Center(
                        child: Icon(
                          Icons.call,
                          color: AppColors.WHITE,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: Get.width / 4,
                child: InkWell(

                  // onTap: () async {
                  //   Get.back();
                  //   CallManager.instance.startNewCall(
                  //       Get.context!, CallType.VIDEO_CALL, {callId}, uid: uid);
                  // },

                  onTap: () async {
                    var cameraStatus = await Permission.camera.status;
                    var microphoneStatus = await Permission.microphone.status;
                    if (!cameraStatus.isGranted || !microphoneStatus.isGranted) {
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.camera,
                        Permission.microphone,
                      ].request();
                      cameraStatus = statuses[Permission.camera]!;
                      microphoneStatus = statuses[Permission.microphone]!;
                      if (!cameraStatus.isGranted || !microphoneStatus.isGranted) {
                        Get.snackbar(
                          'PermissionsRequired'.tr,
                          'videocalldetail'.tr,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                    }
                    Get.back();
                    CallManager.instance.startNewCall(
                        Get.context!, CallType.VIDEO_CALL, {callId}, uid: uid);

                  },

                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.color1,
                                AppColors.color2,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          width: Get.width / 4,
                          height: 50,
                        ),
                      ),
                      const Center(
                        child: Icon(
                          Icons.video_call,
                          color: AppColors.WHITE,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  ));
}

uploadMediaOptionDialog({
  required VoidCallback onTap,
  required VoidCallback onTap1,
}) {
  Get.dialog(AlertDialog(
    title: Text('media_upload_title'.tr),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: Get.width / 4,
                child: InkWell(
                  onTap: onTap,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.color1,
                                  AppColors.color2,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                            height: 50,
                            width: Get.width / 4),
                      ),
                      const Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.WHITE,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: Get.width / 4,
                child: InkWell(
                  onTap: onTap1,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.color1,
                                AppColors.color2,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          width: Get.width / 4,
                          height: 50,
                        ),
                      ),
                      const Center(
                        child: Icon(
                          Icons.file_present,
                          color: AppColors.WHITE,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  ));
}

unSendMessageDialog({
  required VoidCallback onTap,
}) {
  Get.dialog(
    barrierColor: AppColors.chatUnSendBarrierColor,
    AlertDialog(
      backgroundColor: AppColors.WHITE,
      elevation: 0,
      title: Text(
        'remove_msg_title'.tr,
        style: const TextStyle(
          fontFamily: AppFontStyleTextStrings.regular,
          color: AppColors.BLACK,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'remove_msg_subtitle'.tr,
            style: TextStyle(
              fontFamily: AppFontStyleTextStrings.regular,
              fontSize: 13,
              color: AppColors.RED800,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.grey.withOpacity(0.3),
                    ),
                    child: Center(
                      child: AppTextWidgets.blackText(
                        text: 'cancel'.tr,
                        color: AppColors.BLACK,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.grey,
                    ),
                    child: Center(
                      child: AppTextWidgets.blackText(
                        text: 'remove'.tr,
                        color: AppColors.WHITE,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

medicineCartDialog() async {
  return await Get.dialog(
    AlertDialog(
      backgroundColor: AppColors.WHITE,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      title: Text(
        'cart_exist_text'.tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: AppFontStyleTextStrings.regular,
          color: AppColors.BLACK,
          fontSize: 24,
        ),
      ),
      content: Text(
        'cart_exist_text1'.tr,
        style: const TextStyle(
          color: AppColors.BLACK,
          fontSize: 18,
          fontFamily: AppFontStyleTextStrings.regular,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.back(result: false);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.color1,
                        AppColors.color2,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(8.71),
                  ),
                  child: AppTextWidgets.regularText(
                    text: 'no_btn'.tr,
                    color: AppColors.WHITE,
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  Get.back(result: true);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.color1,
                        AppColors.color2,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(8.71),
                  ),
                  child: Text(
                    'yes_btn'.tr,
                    maxLines: 1,
                    style: const TextStyle(
                      color: AppColors.WHITE,
                      fontSize: 18,
                      fontFamily: AppFontStyleTextStrings.regular,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
