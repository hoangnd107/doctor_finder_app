class AddressModel {
  int? id;
  String? address;
  String? tag;
  int? defaultAddress;
  String? lat;
  String? long;

  AddressModel({
    required this.address,
    required this.tag,
    required this.defaultAddress,
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'address': address,
      'tag': tag,
      'defaultAddress': defaultAddress,
      'lat': lat,
      'lon': long,
    };
    return map;
  }

  AddressModel.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    address = map['address'].toString();
    tag = map['tag'].toString();
    defaultAddress = map['defaultAddress'];
    lat = map['lat'];
    long = map['lon'];
  }
}
