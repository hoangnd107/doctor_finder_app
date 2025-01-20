import 'package:flutter/material.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';

class DoctorGrid extends StatelessWidget {
  final VoidCallback onTap;
  final String imgPath;
  final String name;
  final String departmentName;
  final int type;

  const DoctorGrid({
    super.key,
    required this.onTap,
    required this.name,
    required this.imgPath,
    required this.departmentName,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),

                child: CachedNetworkImage(
                  imageUrl: imgPath,
                  fit: BoxFit.cover,
                  width: 250,
                  placeholder: (context, url) => Container(
                    color: Theme.of(context).primaryColorLight,
                    child: Center(
                      child: Image.asset(
                        AppImages.tab3dUnselect,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, err) => Container(
                    color: Theme.of(context).primaryColorLight,
                    child: Center(
                      child: Image.asset(
                        AppImages.tab3dUnselect,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),

              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: AppFontStyleTextStrings.medium,
                color: AppColors.BLACK,
                fontSize: 13,
              ),
            ),
            type == 2
                ? Text(
                    departmentName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFontStyleTextStrings.medium,
                      color: AppColors.LIGHT_GREY_TEXT,
                      fontSize: 9.5,
                    ),
                  )
                : AppTextWidgets.mediumText(
                    text: departmentName,
                    color: AppColors.LIGHT_GREY_TEXT,
                    size: 9.5,
                  ),
          ],
        ),
      ),
    );
  }
}
