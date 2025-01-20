import 'package:videocalling_medical/common/utils/app_imports.dart';

class HomeGrid extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const HomeGrid({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: AppFontStyleTextStrings.regular,
              color: AppColors.BLACK,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
