class OrderMedicine {
  int? status;
  String? msg;
  Data? data;

  OrderMedicine({this.status, this.msg, this.data});

  OrderMedicine.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? pharmacyId;
  String? total;
  String? phone;
  String? message;
  String? address;
  String? paymentType;
  int? isCompleted;
  int? orderType;
  int? status;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.pharmacyId,
      this.total,
      this.phone,
      this.message,
      this.address,
      this.paymentType,
      this.isCompleted,
      this.orderType,
      this.status,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    pharmacyId = json['Pharmacy_id'];
    total = json['total'].toString();
    phone = json['phone'].toString();
    message = json['message'].toString();
    address = json['address'].toString();
    paymentType = json['payment_type'].toString();
    isCompleted = json['is_completed'];
    orderType = json['order_type'];
    status = json['status'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Pharmacy_id'] = this.pharmacyId;
    data['total'] = this.total;
    data['phone'] = this.phone;
    data['message'] = this.message;
    data['address'] = this.address;
    data['payment_type'] = this.paymentType;
    data['is_completed'] = this.isCompleted;
    data['order_type'] = this.orderType;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
