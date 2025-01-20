// import 'package:videocalling_medical/common/screens/call_screen.dart';
// import 'package:videocalling_medical/common/utils/app_imports.dart';
// import 'package:videocalling_medical/common/utils/video_call_imports.dart';
// import 'package:videocalling_medical/services/send_chat_notification_service.dart';
//
// // class CallManager {
// //   static String TAG = "CallManager";
// //
// //   static CallManager get instance => _getInstance();
// //   static CallManager? _instance;
// //
// //   static CallManager _getInstance() {
// //     return _instance ??= CallManager._internal();
// //   }
// //
// //   factory CallManager() => _getInstance();
// //
// //   CallManager._internal();
// //
// //   P2PClient? _callClient;
// //   P2PSession? _currentCall;
// //   BuildContext? context;
// //   MediaStream? localMediaStream;
// //   Map<int, MediaStream> remoteStreams = {};
// //   Function(bool, String)? onMicMuted;
// //
// //   init(BuildContext context) {
// //     this.context = context;
// //
// //     _initCustomMediaConfigs();
// //
// //     if (CubeChatConnection.instance.isAuthenticated()) {
// //       _initCalls();
// //     } else {
// //       _initChatConnectionStateListener();
// //     }
// //
// //     _initCallKit();
// //   }
// //
// //   destroy() {
// //     _callClient?.destroy();
// //     _callClient = null;
// //   }
// //
// //   void _initCustomMediaConfigs() {
// //     RTCMediaConfig mediaConfig = RTCMediaConfig.instance;
// //     mediaConfig.minHeight = 340;
// //     mediaConfig.minWidth = 480;
// //     mediaConfig.minFrameRate = 25;
// //
// //     RTCConfig.instance.statsReportsInterval = 200;
// //   }
// //
// //   void _initCalls() {
// //     if (_callClient == null) {
// //       _callClient = P2PClient.instance;
// //
// //       _callClient!.init();
// //     }
// //
// //     _callClient!.onReceiveNewSession = (callSession) async {
// //       if (_currentCall != null &&
// //           _currentCall!.sessionId != callSession.sessionId) {
// //         callSession.reject();
// //         return;
// //       }
// //       _currentCall = callSession;
// //
// //       var callState = await _getCallState(_currentCall!.sessionId);
// //
// //       if (callState == CallState.REJECTED) {
// //         reject(_currentCall!.sessionId, false);
// //       } else if (callState == CallState.ACCEPTED) {
// //         acceptCall(_currentCall!.sessionId, false);
// //       } else if (callState == CallState.UNKNOWN ||
// //           callState == CallState.PENDING) {
// //         if (callState == CallState.UNKNOWN &&
// //             (Platform.isIOS || Platform.isAndroid)) {
// //           ConnectycubeFlutterCallKit.setCallState(
// //               sessionId: _currentCall!.sessionId, callState: CallState.PENDING);
// //         }
// //
// //         _showIncomingCallScreen(_currentCall!);
// //       }
// //
// //       _currentCall?.onLocalStreamReceived = (localStream) {
// //         localMediaStream = localStream;
// //       };
// //
// //       _currentCall?.onRemoteStreamReceived = (session, userId, stream) {
// //         remoteStreams[userId] = stream;
// //       };
// //
// //       _currentCall?.onRemoteStreamRemoved = (session, userId, stream) {
// //         remoteStreams.remove(userId);
// //       };
// //     };
// //
// //     _callClient!.onSessionClosed = (callSession) async {
// //       if (_currentCall != null &&
// //           _currentCall!.sessionId == callSession.sessionId) {
// //         _currentCall = null;
// //         localMediaStream?.getTracks().forEach((track) async {
// //           await track.stop();
// //         });
// //         await localMediaStream?.dispose();
// //         localMediaStream = null;
// //
// //         remoteStreams.forEach((key, value) async {
// //           await value.dispose();
// //         });
// //
// //         remoteStreams.clear();
// //         CallKitManager.instance.processCallFinished(callSession.sessionId);
// //       }
// //     };
// //   }
// //
// //   void startNewCall(
// //       BuildContext context, int callType, Set<int> opponents) async {
// //     if (opponents.isEmpty) return;
// //
// //     Helper.setAppleAudioIOMode(AppleAudioIOMode.localAndRemote);
// //
// //     P2PSession callSession =
// //         _callClient!.createCallSession(callType, opponents);
// //     _currentCall = callSession;
// //     Get.to(
// //       () => ConversationCallScreen(callSession, false),
// //       transition: Transition.cupertino,
// //     );
// //
// //     _sendStartCallSignalForOffliners(_currentCall!);
// //   }
// //
// //   void _showIncomingCallScreen(P2PSession callSession) {
// //     if (StorageService.readData(key: LocalStorageKeys.callSessionCS) != null) {
// //       CallManager.instance.acceptCall(
// //           StorageService.readData(key: LocalStorageKeys.callSessionCS), false);
// //     } else {
// //       Get.toNamed(Routes.incomingCallScreen, arguments: {
// //         'callSession': callSession,
// //       });
// //     }
// //   }
// //
// //   void acceptCall(String sessionId, bool fromCallkit) {
// //     log('acceptCall, from callKit: $fromCallkit', TAG);
// //     ConnectycubeFlutterCallKit.setOnLockScreenVisibility(isVisible: true);
// //
// //     if (_currentCall != null) {
// //       if (context != null) {
// //         if (AppLifecycleState.resumed !=
// //             WidgetsBinding.instance.lifecycleState) {
// //           _currentCall?.acceptCall();
// //         }
// //
// //         if (!fromCallkit) {
// //           ConnectycubeFlutterCallKit.reportCallAccepted(sessionId: sessionId);
// //         }
// //
// //         if (StorageService.readData(key: LocalStorageKeys.callSessionCS) !=
// //             null) {
// //           Get.back();
// //           Get.to(
// //             () => ConversationCallScreen(_currentCall!, true),
// //             transition: Transition.cupertino,
// //           );
// //         } else {
// //           if (Get.currentRoute == "/incoming-call-screen") {
// //             Get.back();
// //           }
// //           Get.to(
// //             () => ConversationCallScreen(_currentCall!, true),
// //             transition: Transition.cupertino,
// //           );
// //         }
// //       }
// //
// //       Helper.setAppleAudioIOMode(AppleAudioIOMode.localAndRemote);
// //     }
// //   }
// //
// //   void reject(String sessionId, bool fromCallkit) {
// //     if (_currentCall != null) {
// //       if (fromCallkit) {
// //         ConnectycubeFlutterCallKit.setOnLockScreenVisibility(isVisible: false);
// //       } else {
// //         CallKitManager.instance.processCallFinished(_currentCall!.sessionId);
// //       }
// //
// //       _currentCall!.reject();
// //       _sendEndCallSignalForOffliners(_currentCall);
// //     }
// //   }
// //
// //   void hungUp() {
// //     if (_currentCall != null) {
// //       CallKitManager.instance.processCallFinished(_currentCall!.sessionId);
// //       _currentCall!.hungUp();
// //       _sendEndCallSignalForOffliners(_currentCall);
// //     }
// //   }
// //
// //   CreateEventParams _getCallEventParameters(P2PSession currentCall) {
// //     CreateEventParams params = CreateEventParams();
// //     params.parameters = {
// //       'message':
// //           "Incoming ${currentCall.callType == CallType.VIDEO_CALL ? "Video" : "Audio"} call",
// //       PARAM_CALL_TYPE: currentCall.callType,
// //       PARAM_SESSION_ID: currentCall.sessionId,
// //       PARAM_CALLER_ID: currentCall.callerId,
// //       PARAM_CALLER_NAME:
// //           StorageService.readData(key: LocalStorageKeys.name) ?? "Name",
// //       PARAM_CALLER_IMAGE:
// //           StorageService.readData(key: LocalStorageKeys.callerImage) ??
// //               ("${Apis.userImagePath}profile.png"),
// //       PARAM_CALL_OPPONENTS: currentCall.opponentsIds.join(','),
// //     };
// //
// //     params.notificationType = NotificationType.PUSH;
// //     params.environment =
// //         kReleaseMode ? CubeEnvironment.PRODUCTION : CubeEnvironment.DEVELOPMENT;
// //     params.usersIds = currentCall.opponentsIds.toList();
// //
// //     return params;
// //   }
// //
// //   void _sendStartCallSignalForOffliners(P2PSession currentCall) {
// //     CreateEventParams params = _getCallEventParameters(currentCall);
// //     params.parameters[PARAM_SIGNAL_TYPE] = SIGNAL_TYPE_START_CALL;
// //     // params.parameters[PARAM_IOS_VOIP] = 1;
// //     // params.parameters[PARAM_EXPIRATION] = 0;
// //     // params.parameters['ios_push_type'] = 'voip';
// //
// //     createEvent(params.getEventForRequest()).then((cubeEvent) {
// //       log("Event for offliners created: $cubeEvent");
// //     }).catchError((error) {
// //       log("ERROR occurs during create event");
// //     });
// //   }
// //
// //   void _sendEndCallSignalForOffliners(P2PSession? currentCall) {
// //     if (currentCall == null) return;
// //
// //     CubeUser? currentUser = CubeChatConnection.instance.currentUser;
// //     if (currentUser == null || currentUser.id != currentCall.callerId) return;
// //
// //     CreateEventParams params = _getCallEventParameters(currentCall);
// //     params.parameters[PARAM_SIGNAL_TYPE] = SIGNAL_TYPE_END_CALL;
// //
// //     createEvent(params.getEventForRequest()).then((cubeEvent) {
// //       log("Event for offliners created");
// //     }).catchError((error) {
// //       log("ERROR occurs during create event");
// //     });
// //   }
// //
// //   void _initCallKit() {
// //     CallKitManager.instance.init(
// //       onCallAccepted: (uuid) {
// //         acceptCall(uuid, true);
// //       },
// //       onCallEnded: (uuid) {
// //         reject(uuid, true);
// //       },
// //       onMuteCall: (mute, uuid) {
// //         onMicMuted?.call(mute, uuid);
// //       },
// //     );
// //   }
// //
// //   void _initChatConnectionStateListener() {
// //     CubeChatConnection.instance.connectionStateStream.listen((state) {
// //       if (CubeChatConnectionState.Ready == state) {
// //         _initCalls();
// //       }
// //     });
// //   }
// //
// //   Future<String> _getCallState(String sessionId) async {
// //     if (Platform.isAndroid || Platform.isIOS) {
// //       var callState =
// //           ConnectycubeFlutterCallKit.getCallState(sessionId: sessionId);
// //       return callState;
// //     }
// //
// //     return Future.value(CallState.UNKNOWN);
// //   }
// //
// //   void muteCall(String sessionId, bool mute) {
// //     CallKitManager.instance.muteCall(sessionId, mute);
// //   }
// // }
// class CallManager {
//   static String TAG = "CallManager";
//
//   static CallManager get instance => _getInstance();
//   static CallManager? _instance;
//
//   static CallManager _getInstance() {
//     return _instance ??= CallManager._internal();
//   }
//
//   factory CallManager() => _getInstance();
//
//   RxInt requestStatus = 0.obs;
//   List<String> tokensList = [];
//
//
//   CallManager._internal();
//
//   P2PClient? _callClient;
//   P2PSession? _currentCall;
//   BuildContext? context;
//   MediaStream? localMediaStream;
//   Map<int, MediaStream> remoteStreams = {};
//   Function(bool, String)? onMicMuted;
//
//   init(BuildContext context) {
//     this.context = context;
//
//     _initCustomMediaConfigs();
//
//     if (CubeChatConnection.instance.isAuthenticated()) {
//       _initCalls();
//     } else {
//       _initChatConnectionStateListener();
//     }
//
//     _initCallKit();
//   }
//
//   destroy() {
//     _callClient?.destroy();
//     _callClient = null;
//   }
//
//   void _initCustomMediaConfigs() {
//     RTCMediaConfig mediaConfig = RTCMediaConfig.instance;
//     mediaConfig.minHeight = 340;
//     mediaConfig.minWidth = 480;
//     mediaConfig.minFrameRate = 25;
//     RTCConfig.instance.statsReportsInterval = 200;
//   }
//
//   void _initCalls() {
//     if (_callClient == null) {
//       _callClient = P2PClient.instance;
//
//       _callClient!.init();
//     }
//
//     _callClient!.onReceiveNewSession = (callSession) async {
//       if (_currentCall != null &&
//           _currentCall!.sessionId != callSession.sessionId) {
//         callSession.reject();
//         return;
//       }
//       _currentCall = callSession;
//
//       var callState = await _getCallState(_currentCall!.sessionId);
//
//       if (callState == CallState.REJECTED) {
//         reject(_currentCall!.sessionId, false);
//       } else if (callState == CallState.ACCEPTED) {
//         acceptCall(_currentCall!.sessionId, false);
//       } else if (callState == CallState.UNKNOWN ||
//           callState == CallState.PENDING) {
//         if (callState == CallState.UNKNOWN &&
//             (Platform.isIOS || Platform.isAndroid)) {
//           ConnectycubeFlutterCallKit.setCallState(
//               sessionId: _currentCall!.sessionId, callState: CallState.PENDING);
//         }
//
//         _showIncomingCallScreen(_currentCall!);
//       }
//
//       _currentCall?.onLocalStreamReceived = (localStream) {
//         localMediaStream = localStream;
//       };
//
//       _currentCall?.onRemoteStreamReceived = (session, userId, stream) {
//         remoteStreams[userId] = stream;
//       };
//
//       _currentCall?.onRemoteStreamRemoved = (session, userId, stream) {
//         remoteStreams.remove(userId);
//       };
//     };
//
//     _callClient!.onSessionClosed = (callSession) async {
//       if (_currentCall != null &&
//           _currentCall!.sessionId == callSession.sessionId) {
//         _currentCall = null;
//         localMediaStream?.getTracks().forEach((track) async {
//           await track.stop();
//         });
//         await localMediaStream?.dispose();
//         localMediaStream = null;
//
//         remoteStreams.forEach((key, value) async {
//           await value.dispose();
//         });
//
//         remoteStreams.clear();
//         CallKitManager.instance.processCallFinished(callSession.sessionId);
//       }
//     };
//   }
//
//   void startNewCall(
//       BuildContext context, int callType, Set<int> opponents,{required int uid}) async {
//     tokensList.clear();
//     print("object");
//     DatabaseReference starCountRef =
//     FirebaseDatabase.instance.ref(uid.toString()).child("TokenList");
//     print("object1");
//     await starCountRef.once().then((DatabaseEvent event) {
//       final data = event.snapshot.value;
//       if (data != null) {
//         Map<dynamic, dynamic>.from(data as Map).forEach((key, values) {
//           print("object2");
//           tokensList.add(data[key]);
//           print("object3");
//           print(tokensList);
//
//         });
//       }
//     });
//
//     print("callstart");
//     print("============$uid");
//     print("============$tokensList");
//     print("============$callType");
//     print("============$opponents");
//     if (opponents.isEmpty) return;
//
//     Helper.setAppleAudioIOMode(AppleAudioIOMode.localAndRemote);
//
//     P2PSession callSession =
//     _callClient!.createCallSession(callType, opponents);
//     _currentCall = callSession;
//
//     SendNotification().sendNotificationFinalStep(
//         mm: {
//           'message': {
//             "token": tokensList[0].toString(),
//             "notification": {
//               'title': "doctorefinder",
//               'body': "call",
//             },
//             'data': {
//               'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//               'body': "message",
//               'title': "userName",
//               'uid': "myUid.value.toString()",
//               'channelId': "channelId.val",
//               'myUserName': "userName",
//               "signal_type":"startCall",
//               'myid': "myUid.value.toString()",
//               'notificationType': 0.toString(),
//             },
//           },
//         });
//
//     Get.to(
//           () => ConversationCallScreen(callSession, false),
//       transition: Transition.cupertino,
//     );
//
//     _sendStartCallSignalForOffliners(_currentCall!);
//   }
//
//
//
//   void _showIncomingCallScreen(P2PSession callSession) {
//     if (StorageService.readData(key: LocalStorageKeys.callSessionCS) != null) {
//       CallManager.instance.acceptCall(
//           StorageService.readData(key: LocalStorageKeys.callSessionCS), false);
//     } else {
//       Get.toNamed(Routes.incomingCallScreen, arguments: {
//         'callSession': callSession,
//       });
//     }
//   }
//
//   void acceptCall(String sessionId, bool fromCallkit) {
//     log('acceptCall, from callKit: $fromCallkit', TAG);
//     ConnectycubeFlutterCallKit.setOnLockScreenVisibility(isVisible: true);
//
//     if (_currentCall != null) {
//       if (context != null) {
//         if (AppLifecycleState.resumed !=
//             WidgetsBinding.instance.lifecycleState) {
//           _currentCall?.acceptCall();
//         }
//
//         if (!fromCallkit) {
//           ConnectycubeFlutterCallKit.reportCallAccepted(sessionId: sessionId);
//         }
//
//         if (StorageService.readData(key: LocalStorageKeys.callSessionCS) !=
//             null) {
//           Get.back();
//           Get.to(
//                 () => ConversationCallScreen(_currentCall!, true),
//             transition: Transition.cupertino,
//           );
//         } else {
//           if (Get.currentRoute == "/incoming-call-screen") {
//             Get.back();
//           }
//           Get.to(
//                 () => ConversationCallScreen(_currentCall!, true),
//             transition: Transition.cupertino,
//           );
//         }
//       }
//       Helper.setAppleAudioIOMode(AppleAudioIOMode.localAndRemote);
//     }
//   }
//
//   void reject(String sessionId, bool fromCallkit) {
//     if (_currentCall != null) {
//       if (fromCallkit) {
//         ConnectycubeFlutterCallKit.setOnLockScreenVisibility(isVisible: false);
//       } else {
//         CallKitManager.instance.processCallFinished(_currentCall!.sessionId);
//       }
//
//       _currentCall!.reject();
//       _sendEndCallSignalForOffliners(_currentCall);
//     }
//   }
//
//   void hungUp() {
//     if (_currentCall != null) {
//       CallKitManager.instance.processCallFinished(_currentCall!.sessionId);
//       _currentCall!.hungUp();
//       _sendEndCallSignalForOffliners(_currentCall);
//     }
//   }
//
//   CreateEventParams _getCallEventParameters(P2PSession currentCall) {
//     CreateEventParams params = CreateEventParams();
//     params.parameters = {
//       'message':
//       "Incoming ${currentCall.callType == CallType.VIDEO_CALL ? "Video" : "Audio"} call",
//       PARAM_CALL_TYPE: currentCall.callType,
//       PARAM_SESSION_ID: currentCall.sessionId,
//       PARAM_CALLER_ID: currentCall.callerId,
//       PARAM_CALLER_NAME:
//       StorageService.readData(key: LocalStorageKeys.name) ?? "Name",
//       PARAM_CALLER_IMAGE:
//       StorageService.readData(key: LocalStorageKeys.callerImage) ??
//           ("${Apis.userImagePath}profile.png"),
//       PARAM_CALL_OPPONENTS: currentCall.opponentsIds.join(','),
//     };
//
//     params.notificationType = NotificationType.PUSH;
//     params.environment =
//     kReleaseMode ? CubeEnvironment.PRODUCTION : CubeEnvironment.DEVELOPMENT;
//     params.usersIds = currentCall.opponentsIds.toList();
//
//     return params;
//   }
//
//   void _sendStartCallSignalForOffliners(P2PSession currentCall) {
//     print("object1");
//     CreateEventParams params = _getCallEventParameters(currentCall);
//     params.parameters[PARAM_SIGNAL_TYPE] = SIGNAL_TYPE_START_CALL;
//     // params.parameters[PARAM_IOS_VOIP] = 1;
//     // params.parameters[PARAM_EXPIRATION] = 0;
//     // params.parameters['ios_push_type'] = 'voip';
//
//     createEvent(params.getEventForRequest()).then((cubeEvent) {
//       log("Event for offliners created: $cubeEvent");
//     }).catchError((error) {
//       log("ERROR occurs during create event");
//     });
//   }
//
//   void _sendEndCallSignalForOffliners(P2PSession? currentCall) {
//     if (currentCall == null) return;
//
//     CubeUser? currentUser = CubeChatConnection.instance.currentUser;
//     if (currentUser == null || currentUser.id != currentCall.callerId) return;
//
//     CreateEventParams params = _getCallEventParameters(currentCall);
//     params.parameters[PARAM_SIGNAL_TYPE] = SIGNAL_TYPE_END_CALL;
//
//     createEvent(params.getEventForRequest()).then((cubeEvent) {
//       log("Event for offliners created");
//     }).catchError((error) {
//       log("ERROR occurs during create event");
//     });
//   }
//
//   void _initCallKit() {
//     CallKitManager.instance.init(
//       onCallAccepted: (uuid) {
//         acceptCall(uuid, true);
//       },
//       onCallEnded: (uuid) {
//         reject(uuid, true);
//       },
//       onMuteCall: (mute, uuid) {
//         onMicMuted?.call(mute, uuid);
//       },
//     );
//   }
//
//   void _initChatConnectionStateListener() {
//     CubeChatConnection.instance.connectionStateStream.listen((state) {
//       if (CubeChatConnectionState.Ready == state) {
//         _initCalls();
//       }
//     });
//   }
//
//   Future<String> _getCallState(String sessionId) async {
//     if (Platform.isAndroid || Platform.isIOS) {
//       var callState =
//       ConnectycubeFlutterCallKit.getCallState(sessionId: sessionId);
//       return callState;
//     }
//
//     return Future.value(CallState.UNKNOWN);
//   }
//
//   void muteCall(String sessionId, bool mute) {
//     CallKitManager.instance.muteCall(sessionId, mute);
//   }
// }
//
import 'package:videocalling_medical/common/screens/call_screen.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';
import 'package:videocalling_medical/services/send_chat_notification_service.dart';

// class CallManager {
//   static String TAG = "CallManager";
//
//   static CallManager get instance => _getInstance();
//   static CallManager? _instance;
//
//   static CallManager _getInstance() {
//     return _instance ??= CallManager._internal();
//   }
//
//   factory CallManager() => _getInstance();
//
//   CallManager._internal();
//
//   P2PClient? _callClient;
//   P2PSession? _currentCall;
//   BuildContext? context;
//   MediaStream? localMediaStream;
//   Map<int, MediaStream> remoteStreams = {};
//   Function(bool, String)? onMicMuted;
//
//   init(BuildContext context) {
//     this.context = context;
//
//     _initCustomMediaConfigs();
//
//     if (CubeChatConnection.instance.isAuthenticated()) {
//       _initCalls();
//     } else {
//       _initChatConnectionStateListener();
//     }
//
//     _initCallKit();
//   }
//
//   destroy() {
//     _callClient?.destroy();
//     _callClient = null;
//   }
//
//   void _initCustomMediaConfigs() {
//     RTCMediaConfig mediaConfig = RTCMediaConfig.instance;
//     mediaConfig.minHeight = 340;
//     mediaConfig.minWidth = 480;
//     mediaConfig.minFrameRate = 25;
//
//     RTCConfig.instance.statsReportsInterval = 200;
//   }
//
//   void _initCalls() {
//     if (_callClient == null) {
//       _callClient = P2PClient.instance;
//
//       _callClient!.init();
//     }
//
//     _callClient!.onReceiveNewSession = (callSession) async {
//       if (_currentCall != null &&
//           _currentCall!.sessionId != callSession.sessionId) {
//         callSession.reject();
//         return;
//       }
//       _currentCall = callSession;
//
//       var callState = await _getCallState(_currentCall!.sessionId);
//
//       if (callState == CallState.REJECTED) {
//         reject(_currentCall!.sessionId, false);
//       } else if (callState == CallState.ACCEPTED) {
//         acceptCall(_currentCall!.sessionId, false);
//       } else if (callState == CallState.UNKNOWN ||
//           callState == CallState.PENDING) {
//         if (callState == CallState.UNKNOWN &&
//             (Platform.isIOS || Platform.isAndroid)) {
//           ConnectycubeFlutterCallKit.setCallState(
//               sessionId: _currentCall!.sessionId, callState: CallState.PENDING);
//         }
//
//         _showIncomingCallScreen(_currentCall!);
//       }
//
//       _currentCall?.onLocalStreamReceived = (localStream) {
//         localMediaStream = localStream;
//       };
//
//       _currentCall?.onRemoteStreamReceived = (session, userId, stream) {
//         remoteStreams[userId] = stream;
//       };
//
//       _currentCall?.onRemoteStreamRemoved = (session, userId, stream) {
//         remoteStreams.remove(userId);
//       };
//     };
//
//     _callClient!.onSessionClosed = (callSession) async {
//       if (_currentCall != null &&
//           _currentCall!.sessionId == callSession.sessionId) {
//         _currentCall = null;
//         localMediaStream?.getTracks().forEach((track) async {
//           await track.stop();
//         });
//         await localMediaStream?.dispose();
//         localMediaStream = null;
//
//         remoteStreams.forEach((key, value) async {
//           await value.dispose();
//         });
//
//         remoteStreams.clear();
//         CallKitManager.instance.processCallFinished(callSession.sessionId);
//       }
//     };
//   }
//
//   void startNewCall(
//       BuildContext context, int callType, Set<int> opponents) async {
//     if (opponents.isEmpty) return;
//
//     Helper.setAppleAudioIOMode(AppleAudioIOMode.localAndRemote);
//
//     P2PSession callSession =
//         _callClient!.createCallSession(callType, opponents);
//     _currentCall = callSession;
//     Get.to(
//       () => ConversationCallScreen(callSession, false),
//       transition: Transition.cupertino,
//     );
//
//     _sendStartCallSignalForOffliners(_currentCall!);
//   }
//
//   void _showIncomingCallScreen(P2PSession callSession) {
//     if (StorageService.readData(key: LocalStorageKeys.callSessionCS) != null) {
//       CallManager.instance.acceptCall(
//           StorageService.readData(key: LocalStorageKeys.callSessionCS), false);
//     } else {
//       Get.toNamed(Routes.incomingCallScreen, arguments: {
//         'callSession': callSession,
//       });
//     }
//   }
//
//   void acceptCall(String sessionId, bool fromCallkit) {
//     log('acceptCall, from callKit: $fromCallkit', TAG);
//     ConnectycubeFlutterCallKit.setOnLockScreenVisibility(isVisible: true);
//
//     if (_currentCall != null) {
//       if (context != null) {
//         if (AppLifecycleState.resumed !=
//             WidgetsBinding.instance.lifecycleState) {
//           _currentCall?.acceptCall();
//         }
//
//         if (!fromCallkit) {
//           ConnectycubeFlutterCallKit.reportCallAccepted(sessionId: sessionId);
//         }
//
//         if (StorageService.readData(key: LocalStorageKeys.callSessionCS) !=
//             null) {
//           Get.back();
//           Get.to(
//             () => ConversationCallScreen(_currentCall!, true),
//             transition: Transition.cupertino,
//           );
//         } else {
//           if (Get.currentRoute == "/incoming-call-screen") {
//             Get.back();
//           }
//           Get.to(
//             () => ConversationCallScreen(_currentCall!, true),
//             transition: Transition.cupertino,
//           );
//         }
//       }
//
//       Helper.setAppleAudioIOMode(AppleAudioIOMode.localAndRemote);
//     }
//   }
//
//   void reject(String sessionId, bool fromCallkit) {
//     if (_currentCall != null) {
//       if (fromCallkit) {
//         ConnectycubeFlutterCallKit.setOnLockScreenVisibility(isVisible: false);
//       } else {
//         CallKitManager.instance.processCallFinished(_currentCall!.sessionId);
//       }
//
//       _currentCall!.reject();
//       _sendEndCallSignalForOffliners(_currentCall);
//     }
//   }
//
//   void hungUp() {
//     if (_currentCall != null) {
//       CallKitManager.instance.processCallFinished(_currentCall!.sessionId);
//       _currentCall!.hungUp();
//       _sendEndCallSignalForOffliners(_currentCall);
//     }
//   }
//
//   CreateEventParams _getCallEventParameters(P2PSession currentCall) {
//     CreateEventParams params = CreateEventParams();
//     params.parameters = {
//       'message':
//           "Incoming ${currentCall.callType == CallType.VIDEO_CALL ? "Video" : "Audio"} call",
//       PARAM_CALL_TYPE: currentCall.callType,
//       PARAM_SESSION_ID: currentCall.sessionId,
//       PARAM_CALLER_ID: currentCall.callerId,
//       PARAM_CALLER_NAME:
//           StorageService.readData(key: LocalStorageKeys.name) ?? "Name",
//       PARAM_CALLER_IMAGE:
//           StorageService.readData(key: LocalStorageKeys.callerImage) ??
//               ("${Apis.userImagePath}profile.png"),
//       PARAM_CALL_OPPONENTS: currentCall.opponentsIds.join(','),
//     };
//
//     params.notificationType = NotificationType.PUSH;
//     params.environment =
//         kReleaseMode ? CubeEnvironment.PRODUCTION : CubeEnvironment.DEVELOPMENT;
//     params.usersIds = currentCall.opponentsIds.toList();
//
//     return params;
//   }
//
//   void _sendStartCallSignalForOffliners(P2PSession currentCall) {
//     CreateEventParams params = _getCallEventParameters(currentCall);
//     params.parameters[PARAM_SIGNAL_TYPE] = SIGNAL_TYPE_START_CALL;
//     // params.parameters[PARAM_IOS_VOIP] = 1;
//     // params.parameters[PARAM_EXPIRATION] = 0;
//     // params.parameters['ios_push_type'] = 'voip';
//
//     createEvent(params.getEventForRequest()).then((cubeEvent) {
//       log("Event for offliners created: $cubeEvent");
//     }).catchError((error) {
//       log("ERROR occurs during create event");
//     });
//   }
//
//   void _sendEndCallSignalForOffliners(P2PSession? currentCall) {
//     if (currentCall == null) return;
//
//     CubeUser? currentUser = CubeChatConnection.instance.currentUser;
//     if (currentUser == null || currentUser.id != currentCall.callerId) return;
//
//     CreateEventParams params = _getCallEventParameters(currentCall);
//     params.parameters[PARAM_SIGNAL_TYPE] = SIGNAL_TYPE_END_CALL;
//
//     createEvent(params.getEventForRequest()).then((cubeEvent) {
//       log("Event for offliners created");
//     }).catchError((error) {
//       log("ERROR occurs during create event");
//     });
//   }
//
//   void _initCallKit() {
//     CallKitManager.instance.init(
//       onCallAccepted: (uuid) {
//         acceptCall(uuid, true);
//       },
//       onCallEnded: (uuid) {
//         reject(uuid, true);
//       },
//       onMuteCall: (mute, uuid) {
//         onMicMuted?.call(mute, uuid);
//       },
//     );
//   }
//
//   void _initChatConnectionStateListener() {
//     CubeChatConnection.instance.connectionStateStream.listen((state) {
//       if (CubeChatConnectionState.Ready == state) {
//         _initCalls();
//       }
//     });
//   }
//
//   Future<String> _getCallState(String sessionId) async {
//     if (Platform.isAndroid || Platform.isIOS) {
//       var callState =
//           ConnectycubeFlutterCallKit.getCallState(sessionId: sessionId);
//       return callState;
//     }
//
//     return Future.value(CallState.UNKNOWN);
//   }
//
//   void muteCall(String sessionId, bool mute) {
//     CallKitManager.instance.muteCall(sessionId, mute);
//   }
// }
class CallManager {
  static String TAG = "CallManager";

  static CallManager get instance => _getInstance();
  static CallManager? _instance;

  static CallManager _getInstance() {
    return _instance ??= CallManager._internal();
  }

  factory CallManager() => _getInstance();

  RxInt requestStatus = 0.obs;
  List<String> tokensList = [];


  CallManager._internal();

  P2PClient? _callClient;
  P2PSession? _currentCall;
  BuildContext? context;
  MediaStream? localMediaStream;
  Map<int, MediaStream> remoteStreams = {};
  Function(bool, String)? onMicMuted;

  init(BuildContext context) {
    this.context = context;

    _initCustomMediaConfigs();

    if (CubeChatConnection.instance.isAuthenticated()) {
      _initCalls();
    } else {
      _initChatConnectionStateListener();
    }

    _initCallKit();
  }

  destroy() {
    _callClient?.destroy();
    _callClient = null;
  }

  void _initCustomMediaConfigs() {
    RTCMediaConfig mediaConfig = RTCMediaConfig.instance;
    mediaConfig.minHeight = 340;
    mediaConfig.minWidth = 480;
    mediaConfig.minFrameRate = 25;
    RTCConfig.instance.statsReportsInterval = 200;
  }

  void _initCalls() {
    if (_callClient == null) {
      _callClient = P2PClient.instance;

      _callClient!.init();
    }

    _callClient!.onReceiveNewSession = (callSession) async {
      if (_currentCall != null &&
          _currentCall!.sessionId != callSession.sessionId) {
        callSession.reject();
        return;
      }
      _currentCall = callSession;

      var callState = await _getCallState(_currentCall!.sessionId);

      if (callState == CallState.REJECTED) {
        reject(_currentCall!.sessionId, false);
      } else if (callState == CallState.ACCEPTED) {
        acceptCall(_currentCall!.sessionId, false);
      } else if (callState == CallState.UNKNOWN ||
          callState == CallState.PENDING) {
        if (callState == CallState.UNKNOWN &&
            (Platform.isIOS || Platform.isAndroid)) {
          ConnectycubeFlutterCallKit.setCallState(
              sessionId: _currentCall!.sessionId, callState: CallState.PENDING);
        }

        _showIncomingCallScreen(_currentCall!);
      }

      _currentCall?.onLocalStreamReceived = (localStream) {
        localMediaStream = localStream;
      };

      _currentCall?.onRemoteStreamReceived = (session, userId, stream) {
        remoteStreams[userId] = stream;
      };

      _currentCall?.onRemoteStreamRemoved = (session, userId, stream) {
        remoteStreams.remove(userId);
      };
    };

    _callClient!.onSessionClosed = (callSession) async {
      if (_currentCall != null &&
          _currentCall!.sessionId == callSession.sessionId) {
        _currentCall = null;
        localMediaStream?.getTracks().forEach((track) async {
          await track.stop();
        });
        await localMediaStream?.dispose();
        localMediaStream = null;

        remoteStreams.forEach((key, value) async {
          await value.dispose();
        });

        remoteStreams.clear();
        CallKitManager.instance.processCallFinished(callSession.sessionId);
      }
    };
  }

  void startNewCall(
      BuildContext context, int callType, Set<int> opponents,{required int uid}) async {
    tokensList.clear();
    print("object");
    DatabaseReference starCountRef =
    FirebaseDatabase.instance.ref(uid.toString()).child("TokenList");
    print("object1");
    await starCountRef.once().then((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        Map<dynamic, dynamic>.from(data as Map).forEach((key, values) {
          print("object2");
          tokensList.add(data[key]);
          print("object3");
          print(tokensList);

        });
      }
    });

    print("callstart");

    print("============ $uid");
    print("============ $tokensList");
    print("============ $callType");
    print("============ $opponents");


    if (opponents.isEmpty) return;

    Helper.setAppleAudioIOMode(AppleAudioIOMode.localAndRemote);

    P2PSession callSession =
    _callClient!.createCallSession(callType, opponents);
    _currentCall = callSession;

    //
    // SendNotification().sendNotificationFinalStep(
    //     mm: {
    //       'message': {
    //         "token": tokensList[0].toString(),
    //         "notification": {
    //           'title': "doctorefinder",
    //           'body': "call",
    //         },
    //         'data': {
    //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    //           'body': "message",
    //           'title': "userName",
    //           'uid': "myUid.value.toString()",
    //           'channelId': "channelId.val",
    //           'myUserName': "userName",
    //           "signal_type":"startCall",
    //           'myid': "myUid.value.toString()",
    //           'notificationType': 0.toString(),
    //         },
    //       },
    //     });

    // print("call conversion screen");
    Get.to(
          () => ConversationCallScreen(callSession, false),
      transition: Transition.cupertino,
    );

    _sendStartCallSignalForOffliners(_currentCall!);
  }

  void _showIncomingCallScreen(P2PSession callSession) {
    if (StorageService.readData(key: LocalStorageKeys.callSessionCS) != null) {
      CallManager.instance.acceptCall(
          StorageService.readData(key: LocalStorageKeys.callSessionCS), false);
    } else {
      Get.toNamed(Routes.incomingCallScreen, arguments: {
        'callSession': callSession,
      });
    }
  }

  void acceptCall(String sessionId, bool fromCallkit) {
    log('acceptCall, from callKit: $fromCallkit', TAG);
    ConnectycubeFlutterCallKit.setOnLockScreenVisibility(isVisible: true);

    if (_currentCall != null) {
      if (context != null) {
        if (AppLifecycleState.resumed !=
            WidgetsBinding.instance.lifecycleState) {
          _currentCall?.acceptCall();
        }

        if (!fromCallkit) {
          ConnectycubeFlutterCallKit.reportCallAccepted(sessionId: sessionId);
        }

        if (StorageService.readData(key: LocalStorageKeys.callSessionCS) !=
            null) {
          Get.back();
          Get.to(
                () => ConversationCallScreen(_currentCall!, true),
            transition: Transition.cupertino,
          );
        } else {
          if (Get.currentRoute == "/incoming-call-screen") {
            Get.back();
          }
          Get.to(
                () => ConversationCallScreen(_currentCall!, true),
            transition: Transition.cupertino,
          );
        }
      }
      Helper.setAppleAudioIOMode(AppleAudioIOMode.localAndRemote);
    }
  }

  void reject(String sessionId, bool fromCallkit) {
    if (_currentCall != null) {
      if (fromCallkit) {
        ConnectycubeFlutterCallKit.setOnLockScreenVisibility(isVisible: false);
      } else {
        CallKitManager.instance.processCallFinished(_currentCall!.sessionId);
      }

      _currentCall!.reject();
      _sendEndCallSignalForOffliners(_currentCall);
    }
  }

  void hungUp() {
    if (_currentCall != null) {
      CallKitManager.instance.processCallFinished(_currentCall!.sessionId);
      _currentCall!.hungUp();
      _sendEndCallSignalForOffliners(_currentCall);
    }
  }

  CreateEventParams _getCallEventParameters(P2PSession currentCall) {
    CreateEventParams params = CreateEventParams();
    params.parameters = {
      'message':
      "Incoming ${currentCall.callType == CallType.VIDEO_CALL ? "Video" : "Audio"} call",
      PARAM_CALL_TYPE: currentCall.callType,
      PARAM_SESSION_ID: currentCall.sessionId,
      PARAM_CALLER_ID: currentCall.callerId,
      PARAM_CALLER_NAME:
      StorageService.readData(key: LocalStorageKeys.name) ?? "Name",
      PARAM_CALLER_IMAGE:
      StorageService.readData(key: LocalStorageKeys.callerImage) ??
          ("${Apis.userImagePath}profile.png"),
      PARAM_CALL_OPPONENTS: currentCall.opponentsIds.join(','),
    };

    params.notificationType = NotificationType.PUSH;
    params.environment =
    kReleaseMode ? CubeEnvironment.PRODUCTION : CubeEnvironment.DEVELOPMENT;
    params.usersIds = currentCall.opponentsIds.toList();

    return params;
  }

  void _sendStartCallSignalForOffliners(P2PSession currentCall) {
    print("object1");
    CreateEventParams params = _getCallEventParameters(currentCall);
    params.parameters[PARAM_SIGNAL_TYPE] = SIGNAL_TYPE_START_CALL;
    // params.parameters[PARAM_IOS_VOIP] = 1;
    // params.parameters[PARAM_EXPIRATION] = 0;
    // params.parameters['ios_push_type'] = 'voip';

    createEvent(params.getEventForRequest()).then((cubeEvent) {
      log("Event for offliners created: $cubeEvent");
    }).catchError((error) {
      log("ERROR occurs during create event");
    });
  }

  void _sendEndCallSignalForOffliners(P2PSession? currentCall) {
    if (currentCall == null) return;

    CubeUser? currentUser = CubeChatConnection.instance.currentUser;
    if (currentUser == null || currentUser.id != currentCall.callerId) return;

    CreateEventParams params = _getCallEventParameters(currentCall);
    params.parameters[PARAM_SIGNAL_TYPE] = SIGNAL_TYPE_END_CALL;

    createEvent(params.getEventForRequest()).then((cubeEvent) {
      log("Event for offliners created");
    }).catchError((error) {
      log("ERROR occurs during create event");
    });
  }

  void _initCallKit() {
    CallKitManager.instance.init(
      onCallAccepted: (uuid) {
        acceptCall(uuid, true);
      },
      onCallEnded: (uuid) {
        reject(uuid, true);
      },
      onMuteCall: (mute, uuid) {
        onMicMuted?.call(mute, uuid);
      },
    );
  }

  void _initChatConnectionStateListener() {
    CubeChatConnection.instance.connectionStateStream.listen((state) {
      if (CubeChatConnectionState.Ready == state) {
        _initCalls();
      }
    });
  }

  Future<String> _getCallState(String sessionId) async {
    if (Platform.isAndroid || Platform.isIOS) {
      var callState =
      ConnectycubeFlutterCallKit.getCallState(sessionId: sessionId);
      return callState;
    }

    return Future.value(CallState.UNKNOWN);
  }

  void muteCall(String sessionId, bool mute) {
    CallKitManager.instance.muteCall(sessionId, mute);
  }
}

