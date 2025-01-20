import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

class LoginAsDoctor extends GetView<DoctorLoginController> {
  final DoctorLoginController doctorLoginController = Get.put(DoctorLoginController());

  List departmentList = ['login_as_doctor'.tr, 'login_as_pharmacy'.tr,];

  @override
  Widget build(BuildContext context) {
    doctorLoginController.selectedValue.value = departmentList.first;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomAppBar(
          // title: 'doctor_login'.tr,
          title: 'login'.tr,
          titleCenter: true,
        ),
        leading: Container(),
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.WHITE,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: const Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        Obx(() {
                          return Image.asset(
                            doctorLoginController.selectedValue.value.toString() == 'login_as_doctor'.tr
                                ? AppImages.doctornewimage
                                : AppImages.pharmacy,
                            fit: BoxFit.cover,
                            height: 210,
                            width: 210,
                          );
                        }),
                        const SizedBox(height: 20),
                        Obx(() {
                          return DropdownButton(
                            elevation: 0,
                            hint: Text('select_login_type'.tr),
                            style: TextStyle(
                                color: AppColors.BLACK,
                                fontSize: 15,
                                fontFamily: AppFontStyleTextStrings.medium
                            ),
                            items: departmentList.map((x) {
                              return DropdownMenuItem(
                                value: x,
                                child: Text(
                                  x,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            value: doctorLoginController.selectedValue.value.isNotEmpty
                                ? doctorLoginController.selectedValue.value
                                : null,
                            onTap: () {},
                            onChanged: (val) {
                              if (val == null) return;
                              doctorLoginController.selectedValue.value = val.toString();
                              print(doctorLoginController.selectedValue.value);
                            },
                            isExpanded: true,
                            underline: Container(),
                            icon: Image.asset(
                              AppImages.dropdownIcon,
                              height: 15,
                              width: 15,
                            ),
                          );
                        }),
                        Divider(thickness: 1,color: AppColors.LIGHT_GREY_TEXT),
                        Obx(() =>
                            EditTextField(
                              keyboardType: TextInputType.emailAddress,
                              editingController: doctorLoginController.email,
                              labelText: 'enter_email_hint'.tr,
                              errorText: doctorLoginController.isPhoneNumberError.value
                                  ? 'enter_email_error'.tr
                                  : null,
                              onChanged: (val) {
                                doctorLoginController.emailAddress.value = val;
                                doctorLoginController.isPhoneNumberError.value = false;
                                doctorLoginController.isPasswordError.value = false;
                              },
                            )),
                        const SizedBox(height: 10),
                        Obx(() =>
                            EditTextField(
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              editingController: doctorLoginController.password,
                              labelText: 'password'.tr,
                              errorText: doctorLoginController.isPasswordError.value
                                  ? doctorLoginController.passErrorText.value
                                  : null,
                              onChanged: (val) {
                                doctorLoginController.pass.value = val;
                                doctorLoginController.isPasswordError.value = false;
                              },
                            )),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                await Get.toNamed(
                                  Routes.forgetPasswordScreen,
                                  arguments: {
                                    "id": "2",
                                  },
                                );
                                Get.delete<ForgetPasswordController>();
                              },
                              child: AppTextWidgets.boldTextWithColor(
                                text: 'forget_password'.tr,
                                color: AppColors.BLACK,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            height: 50,
                            child: InkWell(
                              onTap: () {
                                Get.focusScope?.unfocus();
                                doctorLoginController.selectedValue.value
                                    .toString() ==
                                    'login_as_doctor'.tr
                                ?doctorLoginController.loginInto()
                                // :doctorLoginController.loginInto();
                                :doctorLoginController.loginIntopharmacy();
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
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                    ),
                                  ),
                                  Obx(() {
                                    return Center(
                                      child: AppTextWidgets.mediumText(
                                        text: doctorLoginController.selectedValue.value
                                            .toString() ==
                                            'login_as_doctor'.tr ?
                                        'login_as_doctor'.tr : 'login_as_pharmacy'.tr,
                                        color: AppColors.WHITE,
                                        size: 18,
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),),
                        const SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppTextWidgets.mediumText(
                                    text: 'not_have_an_account'.tr,
                                    size: 12,
                                    color: AppColors.BLACK),
                                GestureDetector(
                                  onTap: () {

                                    Get.toNamed(Routes.doctorRegisterScreen,
                                        arguments: {
                                      "isPharmacy":   doctorLoginController.selectedValue.value
                                          .toString() ==
                                          'login_as_doctor'.tr ? false : true

                                    });
                                  },
                                  child: AppTextWidgets.mediumText(
                                    text: "register_now".tr,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
