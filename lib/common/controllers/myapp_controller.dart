import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/VideoCall/utils/configs.dart'
    as config;
import 'package:videocalling_medical/common/utils/video_call_imports.dart';

class MyAppController extends GetxController {
  initConnectycube() {
    // ConnectycubeFlutterCallKit.instance.init(
    //   onCallAccepted: onCallAcceptedWhenTerminated,
    //   onCallRejected: onCallRejectedWhenTerminated,
    // );
    init(
      config.APP_ID,
      config.AUTH_KEY,
      config.AUTH_SECRET,
      onSessionRestore: () {
        return SharedPrefs.getUser().then((savedUser) {
          return createSession(savedUser);
        });
      },
    );
    setEndpoints(config.apiEndpoint, config.chatEndpoint);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initConnectycube();
  }
}
