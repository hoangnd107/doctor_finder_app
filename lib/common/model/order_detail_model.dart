
class orderDetailClass {
  int? status;
  String? msg;
  OrderDetailData? data;

  orderDetailClass({this.status, this.msg, this.data});

  orderDetailClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new OrderDetailData.fromJson(json['data']) : null;
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

class OrderDetailData {
  int? id;
  int? pharmacyId;
  int? userId;
  int? orderType;
  String?paymentType;
  dynamic transactionId;
  dynamic status;
  dynamic prescription;
  dynamic phone;
  String? address;
  String? message;
  dynamic taxPr;
  dynamic tax;
  dynamic deliveryCharge;
  dynamic total;
  String? createdAt;
  String? updatedAt;
  int? isCompleted;
  dynamic subtotal;
  dynamic prescriptionPrice;
  String? pharmacyName;
  String? pharmacyAddress;
  String? pharmacyEmail;
  dynamic pharmacyPhoneno;
  String? pharmacyImage;
  List<OrderMedicine>? medicine;
  String? userImage;
  String? userName;
  String? userEmail;
  dynamic adminDeliveryCharge;
  dynamic adminTax;

  OrderDetailData(
      {this.id,
        this.pharmacyId,
        this.userId,
        this.orderType,
        this.paymentType,
        this.transactionId,
        this.status,
        this.prescription,
        this.phone,
        this.address,
        this.message,
        this.taxPr,
        this.tax,
        this.deliveryCharge,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.isCompleted,
        this.subtotal,
        this.prescriptionPrice,
        this.pharmacyName,
        this.pharmacyAddress,
        this.pharmacyEmail,
        this.pharmacyPhoneno,
        this.pharmacyImage,
        this.medicine,
        this.userImage,
        this.userName,
        this.userEmail,
        this.adminDeliveryCharge,
        this.adminTax,

      });

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyId = json['Pharmacy_id'];
    userId = json['user_id'];
    orderType = json['order_type'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    status = json['status'];
    prescription = json['prescription'];
    phone = json['phone'];
    address = json['address'];
    message = json['message'];
    taxPr = json['tax_pr'];
    tax = json['tax'];
    deliveryCharge = json['delivery_charge'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isCompleted = json['is_completed'];
    subtotal = json['subtotal'];
    prescriptionPrice = json['prescription_price'];
    pharmacyName = json['Pharmacy_name'];
    pharmacyAddress = json['Pharmacy_address'];
    pharmacyEmail = json['Pharmacy_email'];
    pharmacyPhoneno = json['Pharmacy_phoneno'];
    pharmacyImage = json['Pharmacy_image'];
    if (json['medicine'] != null) {
      medicine = <OrderMedicine>[];
      json['medicine'].forEach((v) {
        medicine!.add(new OrderMedicine.fromJson(v));
      });
    }
    userImage = json['user_image'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    adminDeliveryCharge = json['admin_delivery_charge'];
    adminTax = json['admin_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Pharmacy_id'] = this.pharmacyId;
    data['user_id'] = this.userId;
    data['order_type'] = this.orderType;
    data['payment_type'] = this.paymentType;
    data['transaction_id'] = this.transactionId;
    data['status'] = this.status;
    data['prescription'] = this.prescription;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['message'] = this.message;
    data['tax_pr'] = this.taxPr;
    data['tax'] = this.tax;
    data['delivery_charge'] = this.deliveryCharge;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_completed'] = this.isCompleted;
    data['subtotal'] = this.subtotal;
    data['prescription_price'] = this.prescriptionPrice;
    data['Pharmacy_name'] = this.pharmacyName;
    data['Pharmacy_address'] = this.pharmacyAddress;
    data['Pharmacy_email'] = this.pharmacyEmail;
    data['Pharmacy_phoneno'] = this.pharmacyPhoneno;
    data['Pharmacy_image'] = this.pharmacyImage;
    if (this.medicine != null) {
      data['medicine'] = this.medicine!.map((v) => v.toJson()).toList();
    }
    data['user_image'] = this.userImage;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['admin_delivery_charge'] = this.adminDeliveryCharge;
    data['admin_tax'] = this.adminTax;
    return data;
  }
}

class OrderMedicine {
  int? id;
  int? orderId;
  int? serviceId;
  dynamic? qty;
  String? name;
  dynamic? price;
  String? createdAt;
  String? updatedAt;
  String? medicineImg;

  OrderMedicine(
      {this.id,
        this.orderId,
        this.serviceId,
        this.qty,
        this.name,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.medicineImg});

  OrderMedicine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    serviceId = json['service_id'];
    qty = json['qty'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    medicineImg = json['medicine_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['service_id'] = this.serviceId;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['medicine_img'] = this.medicineImg;
    return data;
  }
}
