import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/screens/uadd_image.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class RegisterAsPatient extends GetView<RegisterPatientController> {
  final RegisterPatientController registerController =
      Get.put(RegisterPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: CustomAppBar(
          title: 'register'.tr,
          onPressed: () {
            Get.back();
          },
          isBackArrow: true,
        ),
        leading: Container(),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextWidgets.regularText(
                      text: 'already_have_an_account'.tr,
                      size: 12,
                      color: AppColors.BLACK),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppTextWidgets.mediumText(
                      text: " ${'login_now'.tr}",
                      color: AppColors.AMBER,
                      size: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
          SingleChildScrollView(
              child: Container(
            height: MediaQuery.of(context).size.height - 150,
            decoration: const BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Obx(() => Form(
                    key: registerController.formKey,
                    child: Column(
                      children: [
                        EditTextFormField(
                          labelText: 'enter_name'.tr,
                          errorText: registerController.isNameError.value
                              ? 'enter_name'.tr
                              : null,
                          onChanged: (val) {
                            registerController.name.value = val;
                            registerController.isNameError.value = false;
                          },
                          validator: (value) {
                            registerController.name.value = value ?? "";
                            if (registerController.name.value.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        EditTextFormField(
                          labelText: 'enter_number'.tr,
                          errorText: registerController.isPhoneNumberError.value
                              ? registerController.phnNumberError.value
                              : null,
                          onChanged: (val) {
                            registerController.phoneNumber.value = val;
                            registerController.isPhoneNumberError.value = false;
                          },
                          validator: (value) {
                            registerController.phoneNumber.value = value!;
                            if (registerController.phoneNumber.value.isEmpty) {
                              return 'mobile_error_1'.tr;
                            } else if (registerController.phoneNumber.value.length <
                                PHONE_LENGTH) {
                              return 'mobile_error_2'
                                  .trParams({'length': PHONE_LENGTH.toString()});
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        EditTextFormField(
                          labelText: 'enter_email_hint'.tr,
                          errorText: registerController.isEmailError.value
                              ? 'enter_email_error'.tr
                              : null,
                          onChanged: (val) {
                            registerController.email.value = val;
                            registerController.isEmailError.value = false;
                          },
                          validator: (value) {
                            registerController.email.value = value!;
                            if (registerController.email.value.isEmpty) {
                              return 'enter_email_hint'.tr;
                            } else if (!GetUtils.isEmail(
                                registerController.email.value)) {
                              return 'enter_email_error'.tr;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        EditTextFormField(
                          suffixIcon: IconButton(
                            icon: Icon(
                              registerController.passwordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              registerController.passwordVisible.value =
                                  !registerController.passwordVisible.value;
                            },
                          ),
                          labelText: 'password'.tr,
                          errorText: registerController.isPassError.value
                              ? 'password_error'.tr
                              : null,
                          onChanged: (val) {
                            registerController.password.value = val;
                            registerController.isPassError.value = false;
                          },
                          validator: (value) {
                            registerController.password.value = value!;
                            if (registerController.password.value.isEmpty) {
                              return 'password_error1'.tr;
                            } else if (registerController.password.value.length <
                                PASS_LENGTH) {
                              return 'password_error2'
                                  .trParams({'length': '$PASS_LENGTH'});
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: registerController.passwordVisible.value,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        EditTextFormField(
                          suffixIcon: IconButton(
                            icon: Icon(
                              registerController.passwordVisible1.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              registerController.passwordVisible1.value =
                                  !registerController.passwordVisible1.value;
                            },
                          ),
                          labelText: 'confirm_password'.tr,
                          errorText: registerController.isPassError.value
                              ? 'password_error'.tr
                              : null,
                          onChanged: (val) {
                            registerController.confirmPassword.value = val;
                            registerController.isPassError.value = false;
                          },
                          validator: (value) {
                            registerController.confirmPassword.value = value!;
                            if (registerController.confirmPassword.value.isEmpty) {
                              return 'password_error1'.tr;
                            } else if (registerController.confirmPassword.value.length <
                                PASS_LENGTH) {
                              return 'password_error2'
                                  .trParams({'length': '$PASS_LENGTH'});
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: registerController.passwordVisible1.value,
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        Container(
                          height: 50,
                          child: InkWell(
                            onTap: () {
                              Get.focusScope?.unfocus();
                              // Get.off(UserAddImage());

                              if (registerController.formKey.currentState!.validate()) {
                                registerController.registerUser();
                              }
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
                                  child: AppTextWidgets.mediumText(
                                    text: 'register'.tr,
                                    color: AppColors.WHITE,
                                    size: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )),
            ),
          )),
        ],
      ),
    );
  }
}
