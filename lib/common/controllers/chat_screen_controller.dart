import 'package:videocalling_medical/common/utils/app_imports.dart';

// class ChatController extends GetxController {
//   String userName = Get.arguments['userName'];
//   String uid = Get.arguments['uid'];
//   bool isUser = Get.arguments['isUser'];
//
//   ScrollController lvScrollCtrl = ScrollController();
//   TextEditingController textEditingController = TextEditingController();
//
//   RxString myUid = "".obs;
//   RxString senderName = "".obs;
//   RxBool isKeyboard = false.obs;
//   RxBool isEmojiKeyboard = false.obs;
//   RxBool isSeenStatusExist = false.obs;
//   RxInt messageCount = 0.obs;
//   RxBool isFirstMessage = false.obs;
//   RxString channelId = "".obs;
//   RxBool showButton = false.obs;
//   RxString globalMessage = "".obs;
//   RxBool showDate = false.obs;
//   RxInt perPage = 20.obs;
//   RxInt requestStatus = 0.obs;
//   RxString message = "".obs;
//   RxBool isLoading = false.obs;
//   RxBool showLoadingIndicator = false.obs;
//   RxString lastMessageUid = "".obs;
//
//   TextField? textField;
//   RxBool isFileUploading = false.obs;
//   RxDouble uploadingProgress = 0.0.obs;
//
//   Uint8List? image;
//   Map<String, UploadItem> _tasks = {};
//
//   Uint8List? fileThumbnail;
//   List<String> monthsList = [
//     'month_full_1'.tr,
//     'month_full_2'.tr,
//     'month_full_3'.tr,
//     'month_full_4'.tr,
//     'month_full_5'.tr,
//     'month_full_6'.tr,
//     'month_full_7'.tr,
//     'month_full_8'.tr,
//     'month_full_9'.tr,
//     'month_full_10'.tr,
//     'month_full_11'.tr,
//     'month_full_12'.tr
//   ];
//
//   Map<String, StreamSubscription> _progressSubscription = {};
//   Map<String, StreamSubscription> _resultSubscription = {};
//
//   List<String> tokensList = [];
//   DatabaseReference? seenRef;
//   var seenRefListner;
//   var checkSeenRefListner;
//   late StreamSubscription<bool> keyboardSubscription;
//   late FocusNode myFocusNode;
//   File? _image;
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     var keyboardVisibilityController = KeyboardVisibilityController();
//
//     keyboardSubscription =
//         keyboardVisibilityController.onChange.listen((bool isKeybord) {
//       this.isKeyboard.value = isKeybord;
//
//       if (isKeybord && isEmojiKeyboard.value) {
//         isEmojiKeyboard.value = false;
//       }
//     });
//
//     myFocusNode = FocusNode();
//
//     myUid.value =
//         StorageService.readData(key: LocalStorageKeys.userIdWithAscii) ?? "";
//     senderName.value =
//         StorageService.readData(key: LocalStorageKeys.name) ?? "";
//
//     loadUserProfile();
//     getMyUid();
//     checkSeenStatus();
//     markAsSeen();
//     lvScrollCtrl.addListener(() {
//       if (lvScrollCtrl.position.maxScrollExtent ==
//           lvScrollCtrl.position.pixels) {
//         showLoadingIndicator.value = true;
//         perPage.value += 20;
//       }
//     });
//
//     SharedPreferences.getInstance().then((value) {
//       value.remove("payload");
//       value.commit();
//     });
//   }
//
//   Future getImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       _image = File(pickedFile.path);
//
//       uploadFileToServer(
//           File(_image!.path).readAsBytesSync(), "jpg", "file", _image!.path);
//     }
//   }
//
//   loadUserProfile() async {
//     DatabaseReference starCountRef =
//         FirebaseDatabase.instance.ref(uid).child("TokenList");
//     starCountRef.once().then((DatabaseEvent event) {
//       final data = event.snapshot.value;
//       if (data != null) {
//         Map<dynamic, dynamic>.from(data as Map).forEach((key, values) {
//           tokensList.add(data[key]);
//         });
//       }
//     });
//
//     DatabaseReference starCountRef2 =
//         FirebaseDatabase.instance.ref(myUid.value).child("chatlist").child(uid);
//
//     starCountRef2.once().then((DatabaseEvent event) {
//       if (event.snapshot.value != null) {
//         final snapshot = event.snapshot.value as Map;
//         if (snapshot['status'] == 0) {
//           requestStatus.value = 2;
//         } else {
//           requestStatus.value = snapshot['status'] ?? 1;
//         }
//         update();
//       } else {
//         requestStatus.value = 1;
//         update();
//       }
//     });
//   }
//
//   uploadDataWithBackgroundService(String taskId, result) async {
//     CollectionReference collectionReference = FirebaseFirestore.instance
//         .collection("Chats")
//         .doc(channelId.value)
//         .collection("All Chat");
//
//     await collectionReference.doc(taskId.toString()).update({
//       "msg": jsonDecode(result.response)['data'],
//       "time": DateTime.now().toString(),
//       "uid": myUid.value,
//       "type": jsonDecode(result.response)['data'].toString().contains(".jpg")
//           ? 1
//           : 2,
//     });
//
//     if (isFirstMessage.value) {
//       DatabaseReference dbRef = FirebaseDatabase.instance
//           .ref(myUid.value)
//           .child("chatlist")
//           .child(uid);
//
//       await dbRef.set({
//         "time": DateTime.now().toString(),
//         "last_msg": jsonDecode(result.response)['data'],
//         "type": jsonDecode(result.response)['data'].toString().contains(".jpg")
//             ? 1
//             : 2,
//         "messageCount": 0,
//         "status": 1,
//         "channelId": channelId.value
//       });
//
//       DatabaseReference dbRef2 = FirebaseDatabase.instance
//           .ref(uid)
//           .child("chatlist")
//           .child(myUid.value);
//
//       await dbRef2.once().then((DatabaseEvent event) {
//         final snapshot = event.snapshot.value as Map;
//
//         dbRef2.set({
//           "time": DateTime.now().toString(),
//           "last_msg": jsonDecode(result.response)['data'],
//           "type":
//               jsonDecode(result.response)['data'].toString().contains(".jpg")
//                   ? 1
//                   : 2,
//           "messageCount":
//               event.snapshot.value == null ? 1 : snapshot['messageCount'] + 1,
//           "status": 0,
//           "channelId": channelId.value
//         });
//       });
//       isFirstMessage.value = false;
//     } else {
//       DatabaseReference dbRef = FirebaseDatabase.instance
//           .ref(myUid.value)
//           .child("chatlist")
//           .child(uid);
//       await dbRef.update({
//         "time": DateTime.now().toString(),
//         "last_msg": jsonDecode(result.response)['data'],
//         "type": jsonDecode(result.response)['data'].toString().contains(".jpg")
//             ? 1
//             : 2,
//         "messageCount": 0,
//         "channelId": channelId.value
//       });
//
//       DatabaseReference dbRef2 = FirebaseDatabase.instance
//           .ref(uid)
//           .child("chatlist")
//           .child(myUid.value);
//
//       await dbRef2.once().then((DatabaseEvent event) {
//         final snapshot = event.snapshot.value as Map;
//
//         dbRef2.update({
//           "time": DateTime.now().toString(),
//           "last_msg": jsonDecode(result.response)['data'],
//           "type":
//               jsonDecode(result.response)['data'].toString().contains(".jpg")
//                   ? 1
//                   : 2,
//           "messageCount": snapshot.isEmpty ? 1 : snapshot['messageCount'] + 1,
//           "channelId": channelId.value
//         });
//       });
//     }
//
//     for (int i = 0; i < tokensList.length; i++) {
//       sendNotification(senderName.value, "Shared a file", tokensList[i]);
//     }
//
//     _progressSubscription['$taskId']?.cancel();
//     _resultSubscription['$taskId']?.cancel();
//   }
//
//   getMyUid() async {
//     if (uid.compareTo(myUid.value) < 0) {
//       channelId.value = (uid + myUid.value);
//     } else {
//       channelId.value = myUid.value + uid;
//     }
//   }
//
//   Timer markTypingAsZerotimer = Timer(const Duration(seconds: 1), () {});
//
//   void markAsTyping() {
//     DatabaseReference db = FirebaseDatabase.instance.ref();
//     db.child(uid).child("chatlist").child(myUid.value).update(
//       {"typingTime": 1},
//     );
//
//     db
//         .child(uid)
//         .child("chatlist")
//         .child(myUid.value)
//         .child("typingTime")
//         .onValue
//         .listen((event) {
//       markTypingAsZerotimer.cancel();
//       if (event.snapshot.value == 1) {
//         markTypingAsZerotimer = Timer(const Duration(seconds: 1), () {
//           db.child(uid).child("chatlist").child(myUid.value).update(
//             {"typingTime": 0},
//           );
//         });
//       }
//     });
//   }
//
//   Future<bool> onBackPress() {
//     if (isEmojiKeyboard.value) {
//       isEmojiKeyboard.value = false;
//     } else {
//       Get.back();
//     }
//     return Future.value(false);
//   }
//
//   void sendMessage(int type) async {
//     Get.focusScope?.unfocus();
//     String msg = message.value;
//     message.value = "";
//     showButton.value = false;
//     isSeenStatusExist.value = false;
//
//     textEditingController = TextEditingController(text: "");
//     await FirebaseFirestore.instance
//         .collection("Chats")
//         .doc(channelId.value)
//         .collection("All Chat")
//         .add({
//       "msg": msg,
//       "time": DateTime.now().toString(),
//       "uid": myUid.value,
//       "type": type,
//     });
//
//     if (isFirstMessage.value) {
//       DatabaseReference dbRef = FirebaseDatabase.instance
//           .ref(myUid.value)
//           .child("chatlist")
//           .child(uid);
//
//       await dbRef.set({
//         "time": DateTime.now().toString(),
//         "last_msg": msg,
//         "type": type,
//         "messageCount": 0,
//         "status": 1,
//         "channelId": channelId.value
//       });
//
//       DatabaseReference dbRef2 = FirebaseDatabase.instance
//           .ref(uid)
//           .child("chatlist")
//           .child(myUid.value);
//
//       await dbRef2.once().then((value) {
//         final snapshot = value.snapshot.value as Map;
//         dbRef2.set({
//           "time": DateTime.now().toString(),
//           "last_msg": msg,
//           "type": type,
//           "messageCount": snapshot.isEmpty
//               ? 1
//               : snapshot['messageCount'] == null
//                   ? 1
//                   : snapshot['messageCount'] + 1,
//           "status": 0,
//           "channelId": channelId.value
//         });
//       });
//       isFirstMessage.value = false;
//     } else {
//       DatabaseReference dbRef = FirebaseDatabase.instance
//           .ref(myUid.value)
//           .child("chatlist")
//           .child(uid);
//
//       await dbRef.update({
//         "time": DateTime.now().toString(),
//         "last_msg": msg,
//         "type": type,
//         "messageCount": 0,
//         "channelId": channelId.value
//       });
//
//       DatabaseReference dbRef2 = FirebaseDatabase.instance
//           .ref(uid)
//           .child("chatlist")
//           .child(myUid.value);
//
//       await dbRef2.once().then((data) {
//         final call = data.snapshot.value as Map;
//
//         dbRef2.update({
//           "time": DateTime.now().toString(),
//           "last_msg": msg,
//           "type": type,
//           "messageCount": call.isEmpty
//               ? 1
//               : call['messageCount'] == null
//                   ? 1
//                   : call['messageCount'] + 1,
//           "channelId": channelId.value
//         });
//       });
//     }
//
//     if (messageCount.value >= 0) {
//       globalMessage.value =
//           globalMessage.value.isEmpty ? msg : globalMessage.value + "`" + msg;
//     }
//
//     for (int i = 0; i < tokensList.length; i++) {
//       sendNotification(senderName.value, msg, tokensList[i]);
//     }
//   }
//
//   void sendTask(int type, String taskId) async {
//     String msg = message.value;
//
//     CollectionReference collectionReference = FirebaseFirestore.instance
//         .collection("Chats")
//         .doc(channelId.value)
//         .collection("All Chat");
//     await collectionReference.doc(taskId).set({
//       "msg": msg,
//       "time": DateTime.now().toString(),
//       "uid": myUid.value,
//       "type": type,
//     });
//   }
//
//   void deleteTask(String taskId) async {
//     await FirebaseFirestore.instance
//         .collection("Chats")
//         .doc(channelId.value)
//         .collection("All Chat")
//         .doc(taskId)
//         .delete();
//   }
//
//   void updateTaskToFile(int type, String taskId) async {
//     String msg = message.value;
//     message.value = "";
//     showButton.value = false;
//     isSeenStatusExist.value = false;
//
//     CollectionReference collectionReference = FirebaseFirestore.instance
//         .collection("Chats")
//         .doc(channelId.value)
//         .collection("All Chat");
//     await collectionReference.doc(taskId).set({
//       "msg": msg,
//       "time": DateTime.now().toString(),
//       "uid": myUid.value,
//       "type": type,
//     });
//
//     if (isFirstMessage.value) {
//       DatabaseReference dbRef = FirebaseDatabase.instance
//           .ref(myUid.value)
//           .child("chatlist")
//           .child(uid);
//
//       await dbRef.set({
//         "time": DateTime.now().toString(),
//         "last_msg": msg,
//         "type": type,
//         "messageCount": 0,
//         "status": 1,
//         "channelId": channelId.value
//       });
//
//       DatabaseReference dbRef2 = FirebaseDatabase.instance
//           .ref(uid)
//           .child("chatlist")
//           .child(myUid.value);
//
//       dbRef2.onValue.listen((DatabaseEvent event) {
//         final snapshot = event.snapshot.value as Map;
//
//         dbRef2.set({
//           "time": DateTime.now().toString(),
//           "last_msg": msg,
//           "type": type,
//           "messageCount": snapshot.isEmpty ? 1 : snapshot['messageCount'] + 1,
//           "status": 0,
//           "channelId": channelId.value
//         });
//       });
//       isFirstMessage.value = false;
//     } else {
//       DatabaseReference dbRef = FirebaseDatabase.instance
//           .ref(myUid.value)
//           .child("chatlist")
//           .child(uid);
//
//       await dbRef.update({
//         "time": DateTime.now().toString(),
//         "last_msg": msg,
//         "type": type,
//         "messageCount": 0,
//         "channelId": channelId.value
//       });
//
//       DatabaseReference dbRef2 = FirebaseDatabase.instance
//           .ref(uid)
//           .child("chatlist")
//           .child(myUid.value);
//
//       dbRef2.onValue.listen((DatabaseEvent event) {
//         final snapshot = event.snapshot.value as Map;
//
//         dbRef2.update({
//           "time": DateTime.now().toString(),
//           "last_msg": msg,
//           "type": type,
//           "messageCount": snapshot.isEmpty ? 1 : snapshot['messageCount'] + 1,
//           "channelId": channelId.value
//         });
//       });
//     }
//
//     for (int i = 0; i < tokensList.length; i++) {
//       sendNotification(senderName.value, msg, tokensList[i]);
//     }
//   }
//
//   void markAsSeen() async {
//     String x = "${uid}";
//     seenRef =
//         FirebaseDatabase.instance.ref(myUid.value).child('chatlist').child(x);
//     seenRefListner = seenRef!.onValue.listen((event) {
//       seenRef!.update({
//         "messageCount": 0,
//       });
//     });
//   }
//
//   checkSeenStatus() async {
//     checkSeenRefListner = FirebaseDatabase.instance
//         .ref(uid)
//         .child('chatlist')
//         .child(myUid.value)
//         .child("messageCount")
//         .onValue
//         .listen((event) {
//       if (event.snapshot.value != null) {
//         final snapshot = event.snapshot.value as int;
//         if (event.snapshot.value == 0) {
//           messageCount.value = snapshot;
//           isSeenStatusExist.value = true;
//           globalMessage.value = "";
//         } else {
//           messageCount.value = snapshot;
//           isSeenStatusExist.value = false;
//         }
//       } else {
//         isSeenStatusExist.value = false;
//       }
//     });
//   }
//
//   void pickFile() async {
//     final file = await picker.pickMedia();
//
//     if (file == null) return;
//     if (file.path.contains(".jpg") ||
//         file.path.contains(".png") ||
//         file.path.contains(".jpeg")) {
//       uploadFileToServer(
//           File(file.path).readAsBytesSync(), "jpg", "file", file.path);
//     } else if (file.path.contains(".MP4") || file.path.contains(".mp4")) {
//       if (Platform.isIOS) {
//         if (file.path.contains(".MP4")) {
//           uploadFileToServer(
//               File(file.path).readAsBytesSync(), "mp4", "file", file.path);
//         }
//       } else {
//         if (file.path.contains(".mp4")) {
//           uploadFileToServer1(
//               File(file.path).readAsBytesSync(), "mp4", "file", file.path);
//         }
//       }
//     } else {
//       customDialog(s1: 'error'.tr, s2: 'file_type_not_supported'.tr);
//     }
//   }
//
//   uploadFileToServer1(
//       Uint8List result, String extension, String type, path) async {
//     await getExternalStorageDirectory().then((value) async {
//       final uploader = FlutterUploader();
//
//       File f2 = await File(value!.path + '/0.$extension').create();
//       f2.writeAsBytesSync(result);
//
//       List<FileItem> fItem = [
//         FileItem(path: path),
//       ];
//
//       final tag = "image upload ${Random().nextInt(9999)}";
//
//       var taskId = await uploader.enqueue(MultipartFormDataUpload(
//         url: "${Apis.ServerAddress}/api/mediaupload",
//         files: fItem,
//         method: UploadMethod.POST,
//         tag: tag,
//       ));
//
//       message.value = value.toString();
//       sendTask(3, taskId);
//
//       _progressSubscription.putIfAbsent("$taskId", () {
//         return uploader.progress.listen((progress) {
//           final task = _tasks[progress.status];
//
//           if (task == null) return;
//           if (task.isCompleted()) return;
//         });
//       });
//
//       _resultSubscription.putIfAbsent("$taskId", () {
//         return uploader.result.listen((result) {
//           if (taskId.toString() == result.taskId) {
//             uploadDataWithBackgroundService(result.taskId, result);
//           }
//           final task = _tasks[result];
//           if (task == null) return;
//         }, onError: (ex, stacktrace) {
//           final exp = ex;
//           final task = _tasks[exp.tag];
//           if (task == null) return;
//         });
//       });
//
//       _tasks.putIfAbsent(
//           tag,
//           () => UploadItem(
//                 id: taskId,
//                 tag: tag,
//                 type: MediaType.Video,
//                 status: UploadTaskStatus.enqueued,
//               ));
//     });
//   }
//
//   uploadFileToServer(
//       Uint8List result, String extension, String type, path) async {
//     final uploader = FlutterUploader();
//
//     List<FileItem> fItem = [
//       FileItem(path: path),
//     ];
//
//     final tag = "image upload ${Random().nextInt(9999)}";
//
//     var taskId = await uploader.enqueue(MultipartFormDataUpload(
//       url: "${Apis.ServerAddress}/api/mediaupload",
//       files: fItem,
//       method: UploadMethod.POST,
//       tag: tag,
//     ));
//
//     message.value = path;
//     sendTask(3, taskId);
//
//     _progressSubscription.putIfAbsent("$taskId", () {
//       return uploader.progress.listen((progress) {
//         final task = _tasks[progress.status];
//
//         if (task == null) return;
//         if (task.isCompleted()) return;
//       });
//     });
//
//     _resultSubscription.putIfAbsent("$taskId", () {
//       return uploader.result.listen((result) {
//         if (taskId.toString() == result.taskId) {
//           uploadDataWithBackgroundService(result.taskId, result);
//         }
//
//         final task = _tasks[result];
//         if (task == null) return;
//       }, onError: (ex, stacktrace) {
//         final exp = ex;
//         final task = _tasks[exp.tag];
//         if (task == null) return;
//       });
//     });
//
//     _tasks.putIfAbsent(
//         tag,
//         () => UploadItem(
//               id: taskId,
//               tag: tag,
//               type: MediaType.Video,
//               status: UploadTaskStatus.enqueued,
//             ));
//   }
//
//   Widget typeToWidget({String? message, int? type, String? uid}) {
//     if (type == 2 || type == 1) {
//       String ext = message!.split('.').last;
//       return (ext == 'mp4' || ext == 'MP4')
//           ? InkWell(
//               onTap: () async {
//                 await Get.toNamed(Routes.videoPlayerScreen, arguments: {
//                   'type': 2,
//                   'url': Apis.chatMediaPath + message
//                 });
//                 Get.delete<MyVideoPlayerController>();
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: MyVideoThumbNail(url: Apis.chatMediaPath + message),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.BLACK.withOpacity(0.7),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: const Icon(
//                       Icons.play_arrow,
//                       color: AppColors.WHITE,
//                     ),
//                   )
//                 ],
//               ),
//             )
//           : InkWell(
//               onTap: () async {
//                 await Get.toNamed(Routes.photoViewerScreen, arguments: {
//                   'url': Apis.chatMediaPath + message,
//                   'id': "0",
//                   'isDeleteShown': false,
//                   'reportName': userName,
//                 });
//                 Get.delete<MyPhotoViewerController>();
//               },
//               child: Hero(
//                 tag: Apis.chatMediaPath + message,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: CachedNetworkImage(
//                     imageUrl: Apis.chatMediaPath + message,
//                     placeholder: (context, url) => const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                     errorWidget: (context, url, error) =>
//                         const Icon(Icons.error),
//                     height: 200,
//                     width: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             );
//     } else if (type == 3 && uid == myUid.value) {
//       return InkWell(
//         onLongPress: () {},
//         child: Container(
//           height: 200,
//           child: Stack(
//             children: [
//               const Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation(AppColors.WHITE),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: AppTextWidgets.regularTextWithColor(
//                   text: 'uploading_file'.tr,
//                   color: AppColors.WHITE,
//                 ),
//               ),
//               const Center(
//                 child: Icon(
//                   Icons.upload_rounded,
//                   color: AppColors.WHITE,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else if (type == 0) {
//       return InkWell(
//         onTap: () async {
//           if (GetUtils.isURL(message)) {
//             if (await canLaunch(message)) {
//               await launch(message);
//             }
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Text(
//             message!,
//             style: TextStyle(
//                 fontSize: GetUtils.isURL(message) ? 18 : 15,
//                 color: uid == myUid.value ? AppColors.WHITE : AppColors.BLACK,
//                 fontFamily: GetUtils.isURL(message)
//                     ? AppFontStyleTextStrings.light
//                     : AppFontStyleTextStrings.regular,
//                 decoration: GetUtils.isURL(message)
//                     ? TextDecoration.underline
//                     : TextDecoration.none),
//           ),
//         ),
//       );
//     } else if (type == 3 && uid != myUid.value) {
//       return AppTextWidgets.regularTextWithSize(
//         text: 'uploading_file1'.tr,
//         size: 10,
//       );
//     } else {
//       return Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Text(
//           message!,
//           style: TextStyle(
//               fontSize: GetUtils.isURL(message) ? 18 : 15,
//               color: uid == myUid.value ? AppColors.WHITE : AppColors.BLACK,
//               fontFamily: GetUtils.isURL(message)
//                   ? AppFontStyleTextStrings.light
//                   : AppFontStyleTextStrings.regular,
//               decoration: GetUtils.isURL(message)
//                   ? TextDecoration.underline
//                   : TextDecoration.none),
//         ),
//       );
//     }
//   }
//
//   Widget statusToWidget(data) {
//     if (data == 2) {
//       return Container(
//         margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: AppColors.LIGHT_GREY_SCREEN_BACKGROUND),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Text(
//                     "accept_chat_dialog_text1".tr,
//                     style: const TextStyle(
//                       fontFamily: AppFontStyleTextStrings.black,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   acceptChatRequest();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color:
//                           Theme.of(Get.context!).primaryColor.withOpacity(0.8)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Text(
//                       "accept_chat_dialog_text2".tr,
//                       style: const TextStyle(
//                         color: AppColors.WHITE,
//                         fontFamily: AppFontStyleTextStrings.black,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else if (data == 1) {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: textField = TextField(
//                 minLines: 1,
//                 maxLines: 6,
//                 focusNode: myFocusNode,
//                 controller: textEditingController,
//                 decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide(color: AppColors.transparentColor),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide(color: AppColors.transparentColor),
//                     ),
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide(color: AppColors.transparentColor),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide(color: AppColors.transparentColor),
//                     ),
//                     hintText: "send_text_field_hint".tr,
//                     filled: true,
//                     hintStyle: const TextStyle(
//                       fontFamily: AppFontStyleTextStrings.regular,
//                       fontSize: 15,
//                     ),
//                     prefixIcon: IconButton(
//                       icon: isEmojiKeyboard.value
//                           ? const Icon(Icons.keyboard)
//                           : const Icon(Icons.emoji_emotions_outlined),
//                       onPressed: () async {
//                         if (isEmojiKeyboard.value) {
//                           myFocusNode.requestFocus();
//                           isEmojiKeyboard.value = !isEmojiKeyboard.value;
//                         } else {
//                           myFocusNode.unfocus();
//                           await SystemChannels.textInput
//                               .invokeMethod('TextInput.hide');
//                           await Future.delayed(
//                               const Duration(milliseconds: 100));
//
//                           isEmojiKeyboard.value = !isEmojiKeyboard.value;
//                         }
//                       },
//                     ),
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.file_present),
//                       onPressed: () {
//                         uploadMediaOptionDialog(
//                           onTap: () {
//                             getImage();
//                             Get.back();
//                           },
//                           onTap1: () {
//                             pickFile();
//                             Get.back();
//                           },
//                         );
//                       },
//                     )),
//                 onChanged: (val) {
//                   markAsTyping();
//                   message.value = val;
//                   if (val.length == 0) {
//                     showButton.value = false;
//                   } else {
//                     showButton.value = true;
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(
//               width: 8,
//             ),
//             showButton.value
//                 ? FloatingActionButton(
//                     shape: const CircleBorder(
//                       side: BorderSide(
//                         width: 5,
//                         color: AppColors.WHITE,
//                       ),
//                     ),
//                     onPressed: () {
//                       sendMessage(0);
//                     },
//                     elevation: 0.0,
//                     child: Transform.rotate(
//                       angle: 5.5,
//                       child: const Icon(
//                         Icons.send,
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ],
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }
//
//   acceptChatRequest() async {
//     await FirebaseDatabase.instance
//         .ref(myUid.value)
//         .child('chatlist')
//         .child(uid)
//         .update({
//       "status": 1,
//     }).then((value) {
//       requestStatus.value = 1;
//     });
//   }
//
//   unSendMessage(String id, int index, int length,
//       AsyncSnapshot<QuerySnapshot> snapshot) async {
//     if (index > 0) {
//       await FirebaseFirestore.instance
//           .collection("Chats")
//           .doc(channelId.value)
//           .collection("All Chat")
//           .doc(id)
//           .delete();
//       Get.back();
//     } else if (length == 1) {
//       await FirebaseFirestore.instance
//           .collection("Chats")
//           .doc(channelId.value)
//           .collection("All Chat")
//           .doc(id)
//           .delete();
//       await FirebaseDatabase.instance
//           .ref(myUid.value)
//           .child("chatlist")
//           .child(uid)
//           .remove();
//       await FirebaseDatabase.instance
//           .ref(uid)
//           .child("chatlist")
//           .child(myUid.value)
//           .remove();
//       Get.back();
//     } else {
//       DatabaseReference documentReference = FirebaseDatabase.instance
//           .ref(myUid.value)
//           .child('chatlist')
//           .child(uid);
//       await documentReference.update({
//         "time": snapshot.data!.docs[1]['time'].toString(),
//         "last_msg": snapshot.data!.docs[1]['msg'],
//         "type": snapshot.data!.docs[1]['type'],
//       });
//
//       DatabaseReference documentReference2 = FirebaseDatabase.instance
//           .ref(uid)
//           .child('chatlist')
//           .child(myUid.value);
//       await documentReference2.update({
//         "time": snapshot.data!.docs[1]['time'].toString(),
//         "last_msg": snapshot.data!.docs[1]['msg'],
//         "type": snapshot.data!.docs[1]['type'],
//       });
//       Get.back();
//       await FirebaseFirestore.instance
//           .collection("Chats")
//           .doc(channelId.value)
//           .collection("All Chat")
//           .doc(id)
//           .delete();
//     }
//   }
//
//   Future<Map<String, dynamic>> sendNotification(
//       String userName, String message, String token) async {
//     await firebaseMessaging.requestPermission(
//         sound: true, badge: true, alert: true, provisional: false);
//
//     await post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=$ServerToken',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'priority': 'high',
//           'notification': <String, dynamic>{
//             'android': <String, String>{},
//             'title': userName,
//             'body': message,
//           },
//           'data': <String, String>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'body': message,
//             'title': userName,
//             'uid': myUid.value.toString(),
//             'channelId': channelId.value,
//             'myUserName': userName,
//             'myid': myUid.value.toString(),
//             'notificationType': 0.toString(),
//           },
//           'to': token,
//         },
//       ),
//     );
//
//     final Completer<Map<String, dynamic>> completer =
//         Completer<Map<String, dynamic>>();
//
//     return completer.future;
//   }
// }
///new notification code
import 'package:videocalling_medical/services/send_chat_notification_service.dart';

class ChatController extends GetxController {
  String userName = Get.arguments['userName'];
  String uid = Get.arguments['uid'];
  bool isUser = Get.arguments['isUser'];
  ScrollController lvScrollCtrl = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  RxString myUid = "".obs;
  RxString senderName = "".obs;
  RxBool isKeyboard = false.obs;
  RxBool isEmojiKeyboard = false.obs;
  RxBool isSeenStatusExist = false.obs;
  RxInt messageCount = 0.obs;
  RxBool isFirstMessage = false.obs;
  RxString channelId = "".obs;
  RxBool showButton = false.obs;
  RxString globalMessage = "".obs;
  RxBool showDate = false.obs;
  RxInt perPage = 20.obs;
  RxInt requestStatus = 0.obs;
  RxString message = "".obs;
  RxBool isLoading = false.obs;
  RxBool showLoadingIndicator = false.obs;
  RxString lastMessageUid = "".obs;

  TextField? textField;
  RxBool isFileUploading = false.obs;
  RxDouble uploadingProgress = 0.0.obs;

  Uint8List? image;
  Map<String, UploadItem> _tasks = {};

  Uint8List? fileThumbnail;
  List<String> monthsList = [
    'month_full_1'.tr,
    'month_full_2'.tr,
    'month_full_3'.tr,
    'month_full_4'.tr,
    'month_full_5'.tr,
    'month_full_6'.tr,
    'month_full_7'.tr,
    'month_full_8'.tr,
    'month_full_9'.tr,
    'month_full_10'.tr,
    'month_full_11'.tr,
    'month_full_12'.tr
  ];

  Map<String, StreamSubscription> _progressSubscription = {};
  Map<String, StreamSubscription> _resultSubscription = {};

  List<String> tokensList = [];
  DatabaseReference? seenRef;
  var seenRefListner;
  var checkSeenRefListner;
  late StreamSubscription<bool> keyboardSubscription;
  late FocusNode myFocusNode;
  File? _image;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool isKeybord) {
          this.isKeyboard.value = isKeybord;

          if (isKeybord && isEmojiKeyboard.value) {
            isEmojiKeyboard.value = false;
          }
        });

    myFocusNode = FocusNode();

    myUid.value =
        StorageService.readData(key: LocalStorageKeys.userIdWithAscii) ?? "";
    senderName.value =
        StorageService.readData(key: LocalStorageKeys.name) ?? "";

    loadUserProfile();
    getMyUid();
    checkSeenStatus();
    markAsSeen();
    lvScrollCtrl.addListener(() {
      if (lvScrollCtrl.position.maxScrollExtent ==
          lvScrollCtrl.position.pixels) {
        showLoadingIndicator.value = true;
        perPage.value += 20;
      }
    });

    SharedPreferences.getInstance().then((value) {
      value.remove("payload");
      value.commit();
    });
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);

      uploadFileToServer(
          File(_image!.path).readAsBytesSync(), "jpg", "file", _image!.path);
    }
  }

  loadUserProfile() async {
    DatabaseReference starCountRef =
    FirebaseDatabase.instance.ref(uid).child("TokenList");
    starCountRef.once().then((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        Map<dynamic, dynamic>.from(data as Map).forEach((key, values) {
          tokensList.add(data[key]);
        });
      }
    });

    DatabaseReference starCountRef2 =
    FirebaseDatabase.instance.ref(myUid.value).child("chatlist").child(uid);

    starCountRef2.once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        final snapshot = event.snapshot.value as Map;
        if (snapshot['status'] == 0) {
          requestStatus.value = 2;
        } else {
          requestStatus.value = snapshot['status'] ?? 1;
        }
        update();
      } else {
        requestStatus.value = 1;
        update();
      }
    });
  }

  uploadDataWithBackgroundService(String taskId, result) async {
    CollectionReference collectionReference = firestoreInstance
        .collection("Chats")
        .doc(channelId.value)
        .collection("All Chat");

    await collectionReference.doc(taskId.toString()).update({
      "msg": jsonDecode(result.response)['data'],
      "time": DateTime.now().toString(),
      "uid": myUid.value,
      "type": jsonDecode(result.response)['data'].toString().contains(".jpg") ||
          jsonDecode(result.response)['data'].toString().contains(".png") ||
          jsonDecode(result.response)['data'].toString().contains(".jpeg")
          ? 1
          : 2,
    });

    if (isFirstMessage.value) {
      DatabaseReference dbRef = FirebaseDatabase.instance
          .ref(myUid.value)
          .child("chatlist")
          .child(uid);

      await dbRef.set({
        "time": DateTime.now().toString(),
        "last_msg": jsonDecode(result.response)['data'],
        "type": jsonDecode(result.response)['data'].toString().contains(".jpg")
            ? 1
            : 2,
        "messageCount": 0,
        "status": 1,
        "channelId": channelId.value
      });

      DatabaseReference dbRef2 = FirebaseDatabase.instance
          .ref(uid)
          .child("chatlist")
          .child(myUid.value);

      await dbRef2.once().then((DatabaseEvent event) {
        final snapshot = event.snapshot.value as Map;

        dbRef2.set({
          "time": DateTime.now().toString(),
          "last_msg": jsonDecode(result.response)['data'],
          "type":
          jsonDecode(result.response)['data'].toString().contains(".jpg")
              ? 1
              : 2,
          "messageCount":
          event.snapshot.value == null ? 1 : snapshot['messageCount'] + 1,
          "status": 0,
          "channelId": channelId.value
        });
      });
      isFirstMessage.value = false;
    } else {
      DatabaseReference dbRef = FirebaseDatabase.instance
          .ref(myUid.value)
          .child("chatlist")
          .child(uid);
      await dbRef.update({
        "time": DateTime.now().toString(),
        "last_msg": jsonDecode(result.response)['data'],
        "type": jsonDecode(result.response)['data'].toString().contains(".jpg")
            ? 1
            : 2,
        "messageCount": 0,
        "channelId": channelId.value
      });

      DatabaseReference dbRef2 = FirebaseDatabase.instance
          .ref(uid)
          .child("chatlist")
          .child(myUid.value);

      await dbRef2.once().then((DatabaseEvent event) {
        final snapshot = event.snapshot.value as Map;

        dbRef2.update({
          "time": DateTime.now().toString(),
          "last_msg": jsonDecode(result.response)['data'],
          "type":
          jsonDecode(result.response)['data'].toString().contains(".jpg")
              ? 1
              : 2,
          "messageCount": snapshot.isEmpty ? 1 : snapshot['messageCount'] + 1,
          "channelId": channelId.value
        });
      });
    }

    for (int i = 0; i < tokensList.length; i++) {
      sendNotification(senderName.value, "Shared a file", tokensList[i]);
    }

    _progressSubscription['$taskId']?.cancel();
    _resultSubscription['$taskId']?.cancel();
  }

  getMyUid() async {
    if (uid.compareTo(myUid.value) < 0) {
      channelId.value = (uid + myUid.value);
    } else {
      channelId.value = myUid.value + uid;
    }
  }

  Timer markTypingAsZerotimer = Timer(const Duration(seconds: 1), () {});

  void markAsTyping() {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    db.child(uid).child("chatlist").child(myUid.value).update(
      {"typingTime": 1},
    );

    db
        .child(uid)
        .child("chatlist")
        .child(myUid.value)
        .child("typingTime")
        .onValue
        .listen((event) {
      markTypingAsZerotimer.cancel();
      if (event.snapshot.value == 1) {
        markTypingAsZerotimer = Timer(const Duration(seconds: 1), () {
          db.child(uid).child("chatlist").child(myUid.value).update(
            {"typingTime": 0},
          );
        });
      }
    });
  }

  Future<bool> onBackPress() {
    if (isEmojiKeyboard.value) {
      isEmojiKeyboard.value = false;
    } else {
      Get.back();
    }
    return Future.value(false);
  }

  void sendMessage(int type) async {
    Get.focusScope?.unfocus();
    String msg = message.value;
    message.value = "";
    showButton.value = false;
    isSeenStatusExist.value = false;

    textEditingController = TextEditingController(text: "");
    await firestoreInstance
        .collection("Chats")
        .doc(channelId.value)
        .collection("All Chat")
        .add({
      "msg": msg,
      "time": DateTime.now().toString(),
      "uid": myUid.value,
      "type": type,
    });

    if (isFirstMessage.value) {
      DatabaseReference dbRef = FirebaseDatabase.instance
          .ref(myUid.value)
          .child("chatlist")
          .child(uid);

      await dbRef.set({
        "time": DateTime.now().toString(),
        "last_msg": msg,
        "type": type,
        "messageCount": 0,
        "status": 1,
        "channelId": channelId.value
      });

      DatabaseReference dbRef2 = FirebaseDatabase.instance
          .ref(uid)
          .child("chatlist")
          .child(myUid.value);

      await dbRef2.once().then((value) {
        final snapshot = value.snapshot.value as Map;
        dbRef2.set({
          "time": DateTime.now().toString(),
          "last_msg": msg,
          "type": type,
          "messageCount": snapshot.isEmpty
              ? 1
              : snapshot['messageCount'] == null
              ? 1
              : snapshot['messageCount'] + 1,
          "status": 0,
          "channelId": channelId.value
        });
      });
      isFirstMessage.value = false;
    } else {
      DatabaseReference dbRef = FirebaseDatabase.instance
          .ref(myUid.value)
          .child("chatlist")
          .child(uid);

      await dbRef.update({
        "time": DateTime.now().toString(),
        "last_msg": msg,
        "type": type,
        "messageCount": 0,
        "channelId": channelId.value
      });

      DatabaseReference dbRef2 = FirebaseDatabase.instance
          .ref(uid)
          .child("chatlist")
          .child(myUid.value);

      await dbRef2.once().then((data) {
        final call = data.snapshot.value as Map;

        dbRef2.update({
          "time": DateTime.now().toString(),
          "last_msg": msg,
          "type": type,
          "messageCount": call.isEmpty
              ? 1
              : call['messageCount'] == null
              ? 1
              : call['messageCount'] + 1,
          "channelId": channelId.value
        });
      });
    }

    if (messageCount.value >= 0) {
      globalMessage.value =
      globalMessage.value.isEmpty ? msg : globalMessage.value + "`" + msg;
    }

    for (int i = 0; i < tokensList.length; i++) {
      sendNotification(senderName.value, msg, tokensList[i]);
    }
  }

  void sendTask(int type, String taskId) async {
    String msg = message.value;

    CollectionReference collectionReference = firestoreInstance
        .collection("Chats")
        .doc(channelId.value)
        .collection("All Chat");
    await collectionReference.doc(taskId).set({
      "msg": msg,
      "time": DateTime.now().toString(),
      "uid": myUid.value,
      "type": type,
    });
  }

  void deleteTask(String taskId) async {
    await firestoreInstance
        .collection("Chats")
        .doc(channelId.value)
        .collection("All Chat")
        .doc(taskId)
        .delete();
  }

  void updateTaskToFile(int type, String taskId) async {
    String msg = message.value;
    message.value = "";
    showButton.value = false;
    isSeenStatusExist.value = false;

    CollectionReference collectionReference = firestoreInstance
        .collection("Chats")
        .doc(channelId.value)
        .collection("All Chat");
    await collectionReference.doc(taskId).set({
      "msg": msg,
      "time": DateTime.now().toString(),
      "uid": myUid.value,
      "type": type,
    });

    if (isFirstMessage.value) {
      DatabaseReference dbRef = FirebaseDatabase.instance
          .ref(myUid.value)
          .child("chatlist")
          .child(uid);

      await dbRef.set({
        "time": DateTime.now().toString(),
        "last_msg": msg,
        "type": type,
        "messageCount": 0,
        "status": 1,
        "channelId": channelId.value
      });

      DatabaseReference dbRef2 = FirebaseDatabase.instance
          .ref(uid)
          .child("chatlist")
          .child(myUid.value);

      dbRef2.onValue.listen((DatabaseEvent event) {
        final snapshot = event.snapshot.value as Map;

        dbRef2.set({
          "time": DateTime.now().toString(),
          "last_msg": msg,
          "type": type,
          "messageCount": snapshot.isEmpty ? 1 : snapshot['messageCount'] + 1,
          "status": 0,
          "channelId": channelId.value
        });
      });
      isFirstMessage.value = false;
    } else {
      DatabaseReference dbRef = FirebaseDatabase.instance
          .ref(myUid.value)
          .child("chatlist")
          .child(uid);

      await dbRef.update({
        "time": DateTime.now().toString(),
        "last_msg": msg,
        "type": type,
        "messageCount": 0,
        "channelId": channelId.value
      });

      DatabaseReference dbRef2 = FirebaseDatabase.instance
          .ref(uid)
          .child("chatlist")
          .child(myUid.value);

      dbRef2.onValue.listen((DatabaseEvent event) {
        final snapshot = event.snapshot.value as Map;

        dbRef2.update({
          "time": DateTime.now().toString(),
          "last_msg": msg,
          "type": type,
          "messageCount": snapshot.isEmpty ? 1 : snapshot['messageCount'] + 1,
          "channelId": channelId.value
        });
      });
    }

    for (int i = 0; i < tokensList.length; i++) {
      sendNotification(senderName.value, msg, tokensList[i]);
    }
  }

  void markAsSeen() async {
    String x = "${uid}";
    seenRef =
        FirebaseDatabase.instance.ref(myUid.value).child('chatlist').child(x);
    seenRefListner = seenRef!.onValue.listen((event) {
      seenRef!.update({
        "messageCount": 0,
      });
    });
  }

  checkSeenStatus() async {
    checkSeenRefListner = FirebaseDatabase.instance
        .ref(uid)
        .child('chatlist')
        .child(myUid.value)
        .child("messageCount")
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        final snapshot = event.snapshot.value as int;
        if (event.snapshot.value == 0) {
          messageCount.value = snapshot;
          isSeenStatusExist.value = true;
          globalMessage.value = "";
        } else {
          messageCount.value = snapshot;
          isSeenStatusExist.value = false;
        }
      } else {
        isSeenStatusExist.value = false;
      }
    });
  }

  void pickFile() async {
    final file = await picker.pickMedia();

    if (file == null) return;
    if (file.path.contains(".jpg") ||
        file.path.contains(".png") ||
        file.path.contains(".jpeg")) {
      uploadFileToServer(
          File(file.path).readAsBytesSync(), "jpg", "file", file.path);
    } else if (file.path.contains(".MP4") || file.path.contains(".mp4")) {
      if (Platform.isIOS) {
        if (file.path.contains(".MP4")) {
          uploadFileToServer(
              File(file.path).readAsBytesSync(), "mp4", "file", file.path);
        }
      } else {
        if (file.path.contains(".mp4")) {
          uploadFileToServer1(
              File(file.path).readAsBytesSync(), "mp4", "file", file.path);
        }
      }
    } else {
      customDialog(s1: 'error'.tr, s2: 'file_type_not_supported'.tr);
    }
  }

  uploadFileToServer1(
      Uint8List result, String extension, String type, path) async {
    await getExternalStorageDirectory().then((value) async {
      final uploader = FlutterUploader();

      File f2 = await File(value!.path + '/0.$extension').create();
      f2.writeAsBytesSync(result);

      List<FileItem> fItem = [
        FileItem(path: path),
      ];

      final tag = "image upload ${Random().nextInt(9999)}";

      var taskId = await uploader.enqueue(MultipartFormDataUpload(
        url: "${Apis.ServerAddress}/api/mediaupload",
        files: fItem,
        method: UploadMethod.POST,
        tag: tag,
      ));

      message.value = value.toString();
      sendTask(3, taskId);

      _progressSubscription.putIfAbsent("$taskId", () {
        return uploader.progress.listen((progress) {
          final task = _tasks[progress.status];

          if (task == null) return;
          if (task.isCompleted()) return;
        });
      });

      _resultSubscription.putIfAbsent("$taskId", () {
        return uploader.result.listen((result) {
          if (taskId.toString() == result.taskId) {
            uploadDataWithBackgroundService(result.taskId, result);
          }
          final task = _tasks[result];
          if (task == null) return;
        }, onError: (ex, stacktrace) {
          final exp = ex;
          final task = _tasks[exp.tag];
          if (task == null) return;
        });
      });

      _tasks.putIfAbsent(
          tag,
              () => UploadItem(
            id: taskId,
            tag: tag,
            type: MediaType.Video,
            status: UploadTaskStatus.enqueued,
          ));
    });
  }

  uploadFileToServer(
      Uint8List result, String extension, String type, path) async {
    final uploader = FlutterUploader();

    List<FileItem> fItem = [
      FileItem(path: path),
    ];

    final tag = "image upload ${Random().nextInt(9999)}";

    var taskId = await uploader.enqueue(MultipartFormDataUpload(
      url: "${Apis.ServerAddress}/api/mediaupload",
      files: fItem,
      method: UploadMethod.POST,
      tag: tag,
    ));

    message.value = path;
    sendTask(3, taskId);

    _progressSubscription.putIfAbsent("$taskId", () {
      return uploader.progress.listen((progress) {
        final task = _tasks[progress.status];

        if (task == null) return;
        if (task.isCompleted()) return;
      });
    });

    _resultSubscription.putIfAbsent("$taskId", () {
      return uploader.result.listen((result) {
        if (taskId.toString() == result.taskId) {
          uploadDataWithBackgroundService(result.taskId, result);
        }

        final task = _tasks[result];
        if (task == null) return;
      }, onError: (ex, stacktrace) {
        final exp = ex;
        final task = _tasks[exp.tag];
        if (task == null) return;
      });
    });

    _tasks.putIfAbsent(
        tag,
            () => UploadItem(
          id: taskId,
          tag: tag,
          type: MediaType.Video,
          status: UploadTaskStatus.enqueued,
        ));
  }

  Widget typeToWidget({String? message, int? type, String? uid}) {
    if (type == 2 || type == 1) {
      String ext = message!.split('.').last;
      return (ext == 'mp4' || ext == 'MP4')
          ? InkWell(
        onTap: () async {
          await Get.toNamed(Routes.videoPlayerScreen, arguments: {
            'type': 2,
            'url': Apis.chatMediaPath + message
          });
          Get.delete<MyVideoPlayerController>();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: MyVideoThumbNail(url: Apis.chatMediaPath + message),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.BLACK.withOpacity(0.7),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.play_arrow,
                color: AppColors.WHITE,
              ),
            )
          ],
        ),
      )
          : InkWell(
        onTap: () async {
          await Get.toNamed(Routes.photoViewerScreen, arguments: {
            'url': Apis.chatMediaPath + message,
            'id': "0",
            'isDeleteShown': false,
            'reportName': userName,
          });
          Get.delete<MyPhotoViewerController>();
        },
        child: Hero(
          tag: Apis.chatMediaPath + message,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: Apis.chatMediaPath + message,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (type == 3 && uid == myUid.value) {
      return InkWell(
        onLongPress: () {},
        child: Container(
          height: 200,
          child: Stack(
            children: [
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.WHITE),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: AppTextWidgets.regularTextWithColor(
                  text: 'uploading_file'.tr,
                  color: AppColors.WHITE,
                ),
              ),
              const Center(
                child: Icon(
                  Icons.upload_rounded,
                  color: AppColors.WHITE,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (type == 0) {
      return InkWell(
        onTap: () async {
          if (GetUtils.isURL(message)) {
            if (await canLaunch(message)) {
              await launch(message);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            message!,
            style: TextStyle(
                fontSize: GetUtils.isURL(message) ? 18 : 15,
                color: uid == myUid.value ? AppColors.WHITE : AppColors.BLACK,
                fontFamily: GetUtils.isURL(message)
                    ? AppFontStyleTextStrings.light
                    : AppFontStyleTextStrings.regular,
                decoration: GetUtils.isURL(message)
                    ? TextDecoration.underline
                    : TextDecoration.none),
          ),
        ),
      );
    } else if (type == 3 && uid != myUid.value) {
      return AppTextWidgets.regularTextWithSize(
        text: 'uploading_file1'.tr,
        size: 10,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          message!,
          style: TextStyle(
              fontSize: GetUtils.isURL(message) ? 18 : 15,
              color: uid == myUid.value ? AppColors.WHITE : AppColors.BLACK,
              fontFamily: GetUtils.isURL(message)
                  ? AppFontStyleTextStrings.light
                  : AppFontStyleTextStrings.regular,
              decoration: GetUtils.isURL(message)
                  ? TextDecoration.underline
                  : TextDecoration.none),
        ),
      );
    }
  }

  Widget statusToWidget(data) {
    if (data == 2) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.LIGHT_GREY_SCREEN_BACKGROUND),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "accept_chat_dialog_text1".tr,
                    style: const TextStyle(
                      fontFamily: AppFontStyleTextStrings.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  acceptChatRequest();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:
                      Theme.of(Get.context!).primaryColor.withOpacity(0.8)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "accept_chat_dialog_text2".tr,
                      style: const TextStyle(
                        color: AppColors.WHITE,
                        fontFamily: AppFontStyleTextStrings.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (data == 1) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: textField = TextField(
                minLines: 1,
                maxLines: 6,
                focusNode: myFocusNode,
                controller: textEditingController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.transparentColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.transparentColor),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.transparentColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.transparentColor),
                    ),
                    hintText: "send_text_field_hint".tr,
                    filled: true,
                    hintStyle: const TextStyle(
                      fontFamily: AppFontStyleTextStrings.regular,
                      fontSize: 15,
                    ),
                    prefixIcon: IconButton(
                      icon: isEmojiKeyboard.value
                          ? const Icon(Icons.keyboard)
                          : const Icon(Icons.emoji_emotions_outlined),
                      onPressed: () async {
                        if (isEmojiKeyboard.value) {
                          myFocusNode.requestFocus();
                          isEmojiKeyboard.value = !isEmojiKeyboard.value;
                        } else {
                          myFocusNode.unfocus();
                          await SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          await Future.delayed(
                              const Duration(milliseconds: 100));

                          isEmojiKeyboard.value = !isEmojiKeyboard.value;
                        }
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.file_present),
                      onPressed: () {
                        uploadMediaOptionDialog(
                          onTap: () {
                            getImage();
                            Get.back();
                          },
                          onTap1: () {
                            pickFile();
                            Get.back();
                          },
                        );
                      },
                    )),
                onChanged: (val) {
                  markAsTyping();
                  message.value = val;
                  if (val.length == 0) {
                    showButton.value = false;
                  } else {
                    showButton.value = true;
                  }
                },
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            showButton.value
                ? FloatingActionButton(
              shape: const CircleBorder(
                side: BorderSide(
                  width: 5,
                  color: AppColors.WHITE,
                ),
              ),
              onPressed: () {
                sendMessage(0);
              },
              elevation: 0.0,
              child: Transform.rotate(
                angle: 5.5,
                child: const Icon(
                  Icons.send,
                ),
              ),
            )
                : Container(),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  acceptChatRequest() async {
    await FirebaseDatabase.instance
        .ref(myUid.value)
        .child('chatlist')
        .child(uid)
        .update({
      "status": 1,
    }).then((value) {
      requestStatus.value = 1;
    });
  }

  unSendMessage(String id, int index, int length,
      AsyncSnapshot<QuerySnapshot> snapshot) async {
    if (index > 0) {
      await firestoreInstance
          .collection("Chats")
          .doc(channelId.value)
          .collection("All Chat")
          .doc(id)
          .delete();
      Get.back();
    } else if (length == 1) {
      await firestoreInstance
          .collection("Chats")
          .doc(channelId.value)
          .collection("All Chat")
          .doc(id)
          .delete();
      await FirebaseDatabase.instance
          .ref(myUid.value)
          .child("chatlist")
          .child(uid)
          .remove();
      await FirebaseDatabase.instance
          .ref(uid)
          .child("chatlist")
          .child(myUid.value)
          .remove();
      Get.back();
    } else {
      DatabaseReference documentReference = FirebaseDatabase.instance
          .ref(myUid.value)
          .child('chatlist')
          .child(uid);
      await documentReference.update({
        "time": snapshot.data!.docs[1]['time'].toString(),
        "last_msg": snapshot.data!.docs[1]['msg'],
        "type": snapshot.data!.docs[1]['type'],
      });

      DatabaseReference documentReference2 = FirebaseDatabase.instance
          .ref(uid)
          .child('chatlist')
          .child(myUid.value);
      await documentReference2.update({
        "time": snapshot.data!.docs[1]['time'].toString(),
        "last_msg": snapshot.data!.docs[1]['msg'],
        "type": snapshot.data!.docs[1]['type'],
      });
      Get.back();
      await firestoreInstance
          .collection("Chats")
          .doc(channelId.value)
          .collection("All Chat")
          .doc(id)
          .delete();
    }
  }

  sendNotification(String userName, String message, String token) async {

    print("object");
    await firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);
    print("object1");


    SendNotification().sendNotificationFinalStep(mm: {
      'message': {
        "token": token,
        "notification": {
          'title': userName,
          'body': message,
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'body': message,
          'title': userName,
          'uid': myUid.value.toString(),
          'channelId': channelId.value,
          'myUserName': userName,
          'myid': myUid.value.toString(),
          'notificationType': 0.toString(),
        },
      },
      // 'token': token,
    });
  }
}
