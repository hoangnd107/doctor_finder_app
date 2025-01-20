import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class SelectAddressController extends GetxController {
  RxBool isDataLoaded = false.obs;
  RxInt indexval = 0.obs;
  RxList<AddressModel> aList = <AddressModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAddressList();
  }

  AddressModel? selected;
  RxInt selectedId = 0.obs;

  getAddressList() async {
    isDataLoaded.value = false;
    selectedId.value = 0;
    aList.value = await Get.find<DBHelperCart>().getAddressList();
    // print(await Get.find<DBHelperCart>().getAddressList());
    if (aList.length == 1) {
      selectedId.value = aList.first.id ?? 0;
    } else if (aList.isNotEmpty) {
      for (var e in aList) {
        if (e.defaultAddress == 1) {
          selectedId.value = e.id ?? 0;
          break;
        }
      }
      if (selectedId.value == 0) {
        selectedId.value = aList.first.id ?? 0;
      }
    }
    isDataLoaded.value = true;
  }

  performDelete({required int index}) async {
    int i = await DBHelperCart().deleteAddress(
      id: aList[index].id ?? 0,
    );
    if (i == 1) {
      aList.removeAt(index);
      if (selectedId.value != 0) {
        selectedId.value = 0;
      }
    }
  }

  performUpdate({required int index}) async {
    await Get.toNamed(
      Routes.addressAddUpdateScreen,
      arguments: {'isEdit': true, 'addressData': aList[index]},
    );
    Get.delete<AddressAddUpdateController>();
    getAddressList();
    update();
  }
}
