import 'package:videocalling_medical/common/utils/app_imports.dart';

class AddressAddUpdateController extends GetxController {
  bool isEdit = Get.arguments['isEdit'];

  late GoogleMapController mapController;
  LatLng? center;
  late BitmapDescriptor pinLocationIcon;
  final Map<String, Marker> markers = {};
  RxBool isGoogleMapLoading = true.obs;
  RxBool sLocationUpdated = false.obs;
  RxBool test = true.obs;

  TextEditingController tcAddress = TextEditingController();
  RxBool isTcAddressError = false.obs;
  TextEditingController saveAs = TextEditingController();
  RxBool isSaveAsError = false.obs;

  RxBool isDefault = false.obs;
  RxBool mapChange = false.obs;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  onMapTap(LatLng latLng) {
    center = latLng;
    getAddress();
    locateMarker(latLng);
  }

  updateMarkers(LatLng position) async {
    final MarkerId markerId = MarkerId(position.toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: position,
      icon: await BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      // Change color
      infoWindow: InfoWindow(
          title: 'New Marker', snippet: '${position.latitude}, ${position.longitude}'),
    );
    // Update marker in the map
    markers[markerId.value] = marker;
    // Print updated marker values
    print('Updated Markers: ${markers.values.toList()}');
  }
Widget map(){
    return
      Obx(() => GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: CameraPosition(
        target: (sLocationUpdated.value ? center : center) ??
            const LatLng(40.7731125115069, -73.96187393112228),
        zoom: 15.0,
      ),
      onTap: (latLang) {
        print('Tapped Location: $latLang');
        sLocationUpdated.value = false;
        center = latLang;
        onMapTap(latLang);
        locateMarker(center!);
      },
      buildingsEnabled: true,
      compassEnabled: true,
      markers: markers.values.toSet(),
    ));
}
  getAddress() async {
    if (center == null) {
      var position = await Geolocator.getCurrentPosition();
      center = LatLng(position.latitude, position.longitude);
    }

    List<Placemark> placemarks =
        await placemarkFromCoordinates(center!.latitude, center!.longitude);
    Placemark place = placemarks.first;

    String address =
        '${place.street}, ${place.postalCode}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
    tcAddress.text = address;
    locateMarker(center!);
    isGoogleMapLoading.value = false;
    update();
  }

  locateMarker(LatLng latLng) async {
    mapChange.value = !mapChange.value;
    final marker = Marker(
      draggable: true,
      alpha: 1,
      markerId: const MarkerId("curr_loc"),
      position: latLng,
      infoWindow: InfoWindow(title: 'your_location'.tr),
    );
    markers["Current Location"] = marker;
    sLocationUpdated.value = true;
    print("marker");
    mapChange.value = !mapChange.value;
  }

  // locateMarker(LatLng latLng) async {
  //   final marker = Marker(
  //     markerId: const MarkerId("curr_loc"),
  //     position: latLng,
  //     infoWindow: const InfoWindow(title: 'Doctor location'),
  //   );
  //
  //   // Update the marker in the map
  //   markers["Current Location"] = marker;
  //
  //   // This variable should be used to conditionally display something or trigger updates
  //   sLocationUpdated.value = true;
  //
  //   // Retrieve the address based on the coordinates
  //   List<Placemark> placemarks =
  //   await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
  //
  //   var first = placemarks.first;
  //
  //   // Update the text controller with the new address
  //   tcAddress.text =
  //   "${first.name}, ${first.postalCode}, ${first.locality}, ${first.subAdministrativeArea}, ${first.administrativeArea}";
  //
  //   // Ensure the UI updates with the new marker and address
  //   update();
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initMap();
  }

  initMap() async {
    await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppImages.pinSvg,
    ).then((onValue) {
      pinLocationIcon = onValue;
    });
    if (!isEdit) {
      getAddress();
    } else {
      AddressModel editData = Get.arguments['addressData'];
      tcAddress.text = editData.address ?? '';
      saveAs.text = editData.tag ?? '';
      isDefault.value = editData.defaultAddress == 1;
      center = LatLng(
        double.parse(editData.lat ?? "0.0"),
        double.parse(editData.long ?? "0.0"),
      );
      locateMarker(center!);
      isGoogleMapLoading.value = false;
    }
  }

  preformAction() async {
    isTcAddressError.value = false;
    isSaveAsError.value = false;
    if (tcAddress.text.isEmpty) {
      isTcAddressError.value = true;
      update();
    } else if (saveAs.text.isEmpty) {
      isSaveAsError.value = true;
      update();
    } else {
      if (isEdit) {
        AddressModel editData = Get.arguments['addressData'];
        int i = await DBHelperCart().updateAddress(
          id: editData.id ?? 0,
          img: AddressModel(
            address: tcAddress.text,
            tag: saveAs.text,
            defaultAddress: isDefault.value ? 1 : 0,
            lat: "${center!.latitude}",
            long: "${center!.longitude}",
          ),
        );

        if (i != 0) {
          Get.back();
        }
      } else {
        int i = await DBHelperCart().saveAddress(
          AddressModel(
            address: tcAddress.text,
            tag: saveAs.text,
            defaultAddress: isDefault.value ? 1 : 0,
            lat: "${center!.latitude}",
            long: "${center!.longitude}",
          ),
        );

        if (i != 0) {
          Get.back();
        }
      }
    }
  }
}
