import 'package:videocalling_medical/common/utils/app_imports.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onTap;
  String btnText;
  EdgeInsetsGeometry? margin;
  TextStyle? textStyle;

  CustomButton({
    super.key,
    required this.onTap,
    required this.btnText,
    this.margin,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin ?? const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Center(
              child: Text(
                btnText,
                style: textStyle ??
                    const TextStyle(
                      fontFamily: AppFontStyleTextStrings.medium,
                      color: AppColors.WHITE,
                      fontSize: 18,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class CustomButton1 extends StatelessWidget {
  VoidCallback onTap;
  String btnText;
  EdgeInsetsGeometry? margin;
  TextStyle? textStyle;

  CustomButton1({
    super.key,
    required this.onTap,
    required this.btnText,
    this.margin,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin ?? const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
                width: MediaQuery.of(context).size.width / 2.6,
              ),
            ),
            Center(
              child: Text(
                btnText,
                style: textStyle ??
                    const TextStyle(
                      fontFamily: AppFontStyleTextStrings.medium,
                      color: AppColors.WHITE,
                      fontSize: 18,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomButtontextfeild extends StatelessWidget {
  VoidCallback onTap;
  String btnText;
  EdgeInsetsGeometry? margin;
  TextStyle? textStyle;

  CustomButtontextfeild({
    super.key,
    required this.onTap,
    required this.btnText,
    this.margin,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin ?? const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Center(
              child:
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        btnText,
                        style: textStyle ??
                            const TextStyle(
                              fontFamily: AppFontStyleTextStrings.medium,
                              color: AppColors.WHITE,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    const SizedBox(width: 10), // Space between button and TextField
                    Expanded(
                      flex: 3,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your text',
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Space between TextField and icon
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        // Send action here
                      },
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}

class CustomButtonExpanded extends StatelessWidget {
  VoidCallback onTap;
  String btnText;

  CustomButtonExpanded({
    super.key,
    required this.onTap,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: Get.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
            colors: [
              AppColors.color1,
              AppColors.color2,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: const TextStyle(
            color: AppColors.WHITE,
            fontSize: 16,
            fontFamily: AppFontStyleTextStrings.regular,
          ),
        ),
      ),
    );
  }
}
