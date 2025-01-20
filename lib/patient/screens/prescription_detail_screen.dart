import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/screens/report_image_screen.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class PrescriptionDetailScreen extends StatefulWidget {
  const PrescriptionDetailScreen({super.key});

  @override
  State<PrescriptionDetailScreen> createState() => _PrescriptionDetailScreenState();
}

class _PrescriptionDetailScreenState extends State<PrescriptionDetailScreen> {
  RxString url = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    url.value = Get.arguments['url'];
    print(Get.arguments['url']);
    print(Apis.prescription+url.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomAppBar(
          title: 'prescription_detail'.tr,
          isBackArrow: true,
          onPressed: () => Get.back(),
          textStyle: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: 22,
            fontFamily: AppFontStyleTextStrings.medium,
          ),
        ),
        elevation: 0,
        leading: Container(),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(),
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: Apis.prescription+url.value,
              // imageUrl: url.value,
              fit: BoxFit.fill,
              placeholder: (context, url) => Container(
                color: Theme.of(context).primaryColorLight,
                child: Image.asset(
                  AppImages.tab3dUnselect,
                ),
              ),
              errorWidget: (context, url, err) => Container(
                  color: Theme.of(context).primaryColorLight,
                  child: Image.asset(
                    AppImages.tab3dUnselect,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
