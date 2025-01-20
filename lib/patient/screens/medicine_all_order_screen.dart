import 'package:videocalling_medical/patient/utils/patient_imports.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import '../controllers/medicine_all_order_controller.dart';


class MedicineAllOrderScreen extends GetView<MedicineAllOrderController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       flexibleSpace: CustomAppBar(
         title: 'view_cart'.tr,
         textStyle: TextStyle(
           color: Theme.of(context).scaffoldBackgroundColor,
           fontSize: 22,
           fontFamily: AppFontStyleTextStrings.medium,
         ),
         isBackArrow: true,
         onPressed: () => Get.back(),
       ),
       leading: Container(),
     ),
      body:Column(

      ) ,
    );
    }
}
