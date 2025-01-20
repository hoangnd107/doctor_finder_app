import '../../common/utils/app_imports.dart';

class ViewCartController extends GetxController {
  RxList<CartMedicine> cartList = <CartMedicine>[].obs;
  RxList<int> qtyList = <int>[].obs;
  RxBool isDataLoaded = false.obs;
  RxBool loggedIn = false.obs;
  RxDouble total = (0.0).obs;
  RxInt total2 = (0).obs;
  String tax = Get.arguments["tax"].toString() ?? "0";
  String deliveryCharge = Get.arguments["delivery_charge"].toString() ?? "0";

  void removeQuantity(int index) {
    if (index >= 0 && index < qtyList.length) {
      qtyList.removeAt(index);
    } else {
      print("Index out of range");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCartData();
    checkLogin();
  }

  totelcount(){
    total2.value = int.parse(total.toString())+ int.parse(deliveryCharge);
    // "${viewCartController.total.value % 2 == 0 ? viewCartController.total.value.toString().split(".").first : viewCartController.total.value}$CURRENCY",

  }
  checkLogin() {
    loggedIn.value =
        StorageService.readData(key: LocalStorageKeys.isLoggedIn) ?? false;
  }

  getCartData() async {
    cartList.value = await Get.find<DBHelperCart>().getCartList();
    qtyList.value = List.filled(cartList.length, 1);
    calculatePrice();
    isDataLoaded.value = true;
  }

  calculatePrice() {
    total.value = 0;
    for (int i = 0; i < qtyList.length; i++) {
      total.value = total.value +
          double.parse(((double.tryParse("${cartList[i].price}") ??
                      int.parse("${cartList[i].price}")) *
                  qtyList[i])
              .toStringAsFixed(2));
      print(total.value);

    }
    print(total.value);
  }
}
