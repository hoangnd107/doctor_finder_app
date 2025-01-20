class DoctorProfileDetails {
  dynamic success;
  String? register;
  MyData? data;

  DoctorProfileDetails({this.success, this.register, this.data});

  DoctorProfileDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    register = json['register'];
    data = json['data'] != null ? new MyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['register'] = this.register;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MyData {
  int? id;
  String? name;
  String? email;
  String? aboutus;
  String? workingTime;
  String? address;
  dynamic? cityId;
  String? lat;
  String? lon;
  dynamic phoneno;
  String? services;
  String? healthcare;
  String? image;
  dynamic password;
  String? createdAt;
  String? updatedAt;
  dynamic? isApprove;
  dynamic consultationFees;
  String? departmentName;
  int? avgratting;

  MyData(
      {this.id,
      this.name,
      this.email,
      this.aboutus,
      this.workingTime,
      this.address,
      this.cityId,
      this.lat,
      this.lon,
      this.phoneno,
      this.services,
      this.healthcare,
      this.image,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.isApprove,
      this.consultationFees,
      this.departmentName,
      this.avgratting});

  MyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    aboutus = json['aboutus'] ?? "";
    workingTime = json['working_time'].toString();
    address = json['address'] ?? "";
    cityId = json['city_id'] ?? "";
    lat = json['lat'] == null ? "" : json['lat'].toString();
    lon = json['lon'] == null ? "" : json['lon'].toString();
    phoneno = json['phoneno'].toString();
    services = json['services'] ?? "";
    healthcare = json['healthcare'] ?? "";
    image = json['image'].toString();
    password = json['password'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isApprove = json['is_approve'];
    consultationFees = json['consultation_fees'].toString();
    departmentName = json['department_name'] ?? "";
    avgratting = json['avgratting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['aboutus'] = this.aboutus;
    data['working_time'] = this.workingTime;
    data['address'] = this.address;
    data['city_id'] = this.cityId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['phoneno'] = this.phoneno;
    data['services'] = this.services;
    data['healthcare'] = this.healthcare;
    data['image'] = this.image;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_approve'] = this.isApprove;
    data['consultation_fees'] = this.consultationFees;
    data['department_name'] = this.departmentName;
    data['avgratting'] = this.avgratting;
    return data;
  }
}
