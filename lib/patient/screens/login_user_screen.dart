import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class LoginAsUser extends GetView<UserLoginController> {
  final UserLoginController loginController = Get.put(UserLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: CustomAppBar(
          textStyle: Theme.of(context).textTheme.headlineSmall!.apply(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeightDelta: 2,
              ),
          title: 'login'.tr,
          onPressed: () {
            SharedPreferences.getInstance().then((value) {
              if (value.getString("isBack") == "1") {
                value.setString("isBack", "0");
                Navigator.of(context).popUntil((route) => route.isFirst);
                Get.offAllNamed(Routes.userTabScreen);
              } else {
                Get.back();
              }
            });
          },
          isBackArrow: true,
        ),
        leading: Container(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      20.hs,
                      Image.asset(
                        AppImages.loginIcon,
                        height: 180,
                        width: 180,
                      ),
                      20.hs,
                      Obx(
                        () => EditTextField(
                          keyboardType: TextInputType.emailAddress,
                          editingController: loginController.emailT,
                          labelText: 'enter_email_hint'.tr,
                          errorText: loginController.isPhoneNumberError.value
                              ? 'enter_email_error'.tr
                              : null,
                          onChanged: (val) {
                            loginController.phoneNumber.value = val;
                            loginController.isPhoneNumberError.value = false;
                          },
                        ),
                      ),
                      10.hs,
                      Obx(
                        () => EditTextField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          editingController: loginController.passwordT,
                          labelText: 'password'.tr,
                          errorText: loginController.isPasswordError.value
                              ? loginController.passErrorText.value
                              : null,
                          onChanged: (val) {
                            loginController.pass.value = val;
                            loginController.isPasswordError.value = false;
                          },
                        ),
                      ),
                      10.hs,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              await Get.toNamed(Routes.forgetPasswordScreen,
                                  arguments: {"id": "1"});
                              Get.delete<ForgetPasswordController>();
                            },
                            child: AppTextWidgets.semiBoldText(
                              text: 'forget_password'.tr,
                              color: AppColors.BLACK,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                      20.hs,
                      SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            Get.focusScope?.unfocus();
                            loginController.loginInto(1);
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
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Center(
                                child: Text('login'.tr,
                                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                                        fontSizeDelta: 5,
                                        color:
                                            Theme.of(context).scaffoldBackgroundColor)),
                              )
                            ],
                          ),
                        ),
                      ),
                      25.hs,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('not_have_an_account'.tr,
                              style: Theme.of(context).textTheme.bodyMedium),
                          GestureDetector(
                            onTap: () async {
                              await Get.toNamed(Routes.patientRegisterScreen);
                              Get.delete<RegisterPatientController>();
                            },
                            child: Text('register_now'.tr,
                                style: Theme.of(context).textTheme.bodyLarge!.apply(
                                      color: AppColors.AMBER,
                                    )),
                          ),
                        ],
                      ),
                      25.hs,
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                loginController.googleLogin();
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: AppColors.RED,
                                ),
                                child: Center(
                                  child: AppTextWidgets.mediumText(
                                    text: 'continue_with_google'.tr,
                                    color: AppColors.WHITE,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      20.hs,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
