import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';

class ConnectyCubeSessionService {
  static void loginToCC(
    CubeUser user, {
    required VoidCallback onTap,
  }) {
    print("login to connectycube");

    customDialog1(
      s1: 'creating_account_c'.tr,
      s2: 'creating_account1_c'.tr,
      s1style: Theme.of(Get.context!).textTheme.bodyLarge,
      s2style: Theme.of(Get.context!).textTheme.bodyMedium,
    );
    print("cubeUser.login1");

    if (CubeSessionManager.instance.isActiveSessionValid() &&
        CubeSessionManager.instance.activeSession!.user != null) {
      if (CubeChatConnection.instance.isAuthenticated()) {
        print("cubeUser.login2");
        onTap();
      } else {
        print("cubeUser.login3");

        loginToCubeChat(user, onTap: onTap);
      }
    }
    else {
      print("cubeUser.login4");

      createSession(user).then((cubeSession) {
        print("cubeUser.login5");

        loginToCubeChat(user, onTap: onTap);
      }).catchError((exception) {
        print("catchError1 :: $exception");
        Get.back();
        customDialog(
          s1: 'error_c'.tr,
          s2: '$exception',
          s1style: Theme.of(Get.context!).textTheme.bodyLarge,
          s2style: Theme.of(Get.context!).textTheme.bodyLarge,
          onPressed: onTap,
        );
      });
    }
  }

  static void loginToCubeChat(
    CubeUser user, {
    VoidCallback? onTap,
  }) {
    print("cubeUser.login6");

    CubeChatConnection.instance.login(user).then((cubeUser) {
      print("cubeUser.login");
      print(cubeUser.login);
      print("cubeUser.password");
      print(cubeUser.password);

      SharedPrefs.saveNewUser(user);
      if (onTap != null) {
        onTap();
      }
    }).catchError((exception) {
      print("catchError2 :: $exception");
      Get.back();
      customDialog(
        s1: 'error'.tr,
        s2: '$exception',
        onPressed: onTap,
      );
    });
  }
}
