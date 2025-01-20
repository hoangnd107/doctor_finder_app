class PharmacyOrder {
  int? status;
  String? msg;
  List<orderdata>? data;

  PharmacyOrder({this.status, this.msg, this.data});

  PharmacyOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <orderdata>[];
      json['data'].forEach((v) {
        data!.add(new orderdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class orderdata {
  int? id;
  int? pharmacyId;
  dynamic pharmacyName;
  dynamic pharmacyImage;
  dynamic pharmacyAddress;
  dynamic pharmacyPhoneno;
  dynamic pharmacyEmail;
  int? userId;
  int? orderType;
  String? paymentType;
  dynamic transactionId;
  int? status;
  dynamic prescription;
  int? phone;
  dynamic address;
  dynamic message;
  dynamic total;
  dynamic subtotal;
  dynamic delivery_charge;
  dynamic tax_pr;
  String? createdAt;
  String? updatedAt;
  int? isCompleted;
  List<Medicine>? medicine;

  orderdata(
      {this.id,
        this.pharmacyId,
        this.pharmacyName,
        this.pharmacyImage,
        this.pharmacyAddress,
        this.pharmacyPhoneno,
        this.pharmacyEmail,
        this.userId,
        this.orderType,
        this.paymentType,
        this.transactionId,
        this.status,
        this.prescription,
        this.phone,
        this.address,
        this.message,
        this.total,
        this.subtotal,
        this.delivery_charge,
        this.tax_pr,
        this.createdAt,
        this.updatedAt,
        this.isCompleted,
        this.medicine});

  orderdata.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    pharmacyId = json['Pharmacy_id'];
    pharmacyName = json['Pharmacy_name'];
    pharmacyImage = json['Pharmacy_image'];
    pharmacyAddress = json['Pharmacy_address'];
    pharmacyEmail = json['Pharmacy_email'];
    pharmacyPhoneno = json['Pharmacy_phoneno'];
    userId = json['user_id'];
    orderType = json['order_type'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    status = json['status'];
    prescription = json['prescription'];
    phone = json['phone'];
    address = json['address'];
    message = json['message'];
    total = json['total'];
    subtotal = json['subtotal'];
    delivery_charge = json['delivery_charge'];
    tax_pr = json['tax_pr'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isCompleted = json['is_completed'];
    if (json['medicine'] != null) {
      medicine = <Medicine>[];
      json['medicine'].forEach((v) {
        medicine!.add(new Medicine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Pharmacy_id'] = this.pharmacyId;
    data['Pharmacy_name'] = this.pharmacyName;
    data['Pharmacy_image'] = this.pharmacyImage;
    data['Pharmacy_address'] = this.pharmacyAddress;
    data['Pharmacy_email'] = this.pharmacyEmail;
    data['Pharmacy_phoneno'] = this.pharmacyPhoneno;
    data['user_id'] = this.userId;
    data['order_type'] = this.orderType;
    data['payment_type'] = this.paymentType;
    data['transaction_id'] = this.transactionId;
    data['status'] = this.status;
    data['prescription'] = this.prescription;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['message'] = this.message;
    data['total'] = this.total;
    data['subtotal'] = this.subtotal;
    data['delivery_charge'] = this.delivery_charge;
    data['tax_pr'] = this.tax_pr;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_completed'] = this.isCompleted;
    if (this.medicine != null) {
      data['medicine'] = this.medicine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicine {
  int? id;
  int? orderId;
  int? serviceId;
  int? qty;
  String? name;
  String? medicine_img;
  dynamic? price;
  String? createdAt;
  String? updatedAt;


  Medicine(
      {this.id,
        this.orderId,
        this.serviceId,
        this.qty,
        this.name,
        this.medicine_img,
        this.price,
        this.createdAt,
        this.updatedAt});

  Medicine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    serviceId = json['service_id'];
    qty = json['qty'];
    name = json['name'];
    medicine_img = json['medicine_img'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['service_id'] = this.serviceId;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['medicine_img'] = this.medicine_img;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

//
// class PharmacyOrder {
//   int? status;
//   String? msg;
//   List<orderdata>? data;
//
//   PharmacyOrder({this.status, this.msg, this.data});
//
//   PharmacyOrder.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     if (json['data'] != null) {
//       data = <orderdata>[];
//       json['data'].forEach((v) {
//         data!.add(new orderdata.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['msg'] = this.msg;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class orderdata {
//   int? id;
//   int? pharmacyId;
//   int? userId;
//   int? orderType;
//   String? paymentType;
//   Null? transactionId;
//   int? status;
//   String? prescription;
//   int? phone;
//   String? address;
//   String? message;
//   Null? tax;
//   Null? deliveryCharge;
//   double? total;
//   String? createdAt;
//   String? updatedAt;
//   int? isCompleted;
//   Medicine? medicine;
//   String? pharmacyName;
//   String? pharmacyAddress;
//   String? pharmacyEmail;
//   int? pharmacyPhoneno;
//   String? pharmacyImage;
//
//   orderdata(
//       {this.id,
//         this.pharmacyId,
//         this.userId,
//         this.orderType,
//         this.paymentType,
//         this.transactionId,
//         this.status,
//         this.prescription,
//         this.phone,
//         this.address,
//         this.message,
//         this.tax,
//         this.deliveryCharge,
//         this.total,
//         this.createdAt,
//         this.updatedAt,
//         this.isCompleted,
//         this.medicine,
//         this.pharmacyName,
//         this.pharmacyAddress,
//         this.pharmacyEmail,
//         this.pharmacyPhoneno,
//         this.pharmacyImage});
//
//   orderdata.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     pharmacyId = json['Pharmacy_id'];
//     userId = json['user_id'];
//     orderType = json['order_type'];
//     paymentType = json['payment_type'];
//     transactionId = json['transaction_id'];
//     status = json['status'];
//     prescription = json['prescription'];
//     phone = json['phone'];
//     address = json['address'];
//     message = json['message'];
//     tax = json['tax'];
//     deliveryCharge = json['delivery_charge'];
//     total = json['total'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     isCompleted = json['is_completed'];
//     medicine = json['medicine'] != null
//         ? new Medicine.fromJson(json['medicine'])
//         : null;
//     pharmacyName = json['Pharmacy_name'];
//     pharmacyAddress = json['Pharmacy_address'];
//     pharmacyEmail = json['Pharmacy_email'];
//     pharmacyPhoneno = json['Pharmacy_phoneno'];
//     pharmacyImage = json['Pharmacy_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['Pharmacy_id'] = this.pharmacyId;
//     data['user_id'] = this.userId;
//     data['order_type'] = this.orderType;
//     data['payment_type'] = this.paymentType;
//     data['transaction_id'] = this.transactionId;
//     data['status'] = this.status;
//     data['prescription'] = this.prescription;
//     data['phone'] = this.phone;
//     data['address'] = this.address;
//     data['message'] = this.message;
//     data['tax'] = this.tax;
//     data['delivery_charge'] = this.deliveryCharge;
//     data['total'] = this.total;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['is_completed'] = this.isCompleted;
//     if (this.medicine != null) {
//       data['medicine'] = this.medicine!.toJson();
//     }
//     data['Pharmacy_name'] = this.pharmacyName;
//     data['Pharmacy_address'] = this.pharmacyAddress;
//     data['Pharmacy_email'] = this.pharmacyEmail;
//     data['Pharmacy_phoneno'] = this.pharmacyPhoneno;
//     data['Pharmacy_image'] = this.pharmacyImage;
//     return data;
//   }
// }
//
// class Medicine {
//   int? id;
//   int? orderId;
//   int? serviceId;
//   int? qty;
//   String? name;
//   double? price;
//   String? createdAt;
//   String? updatedAt;
//   String? madicineImg;
//
//   Medicine(
//       {this.id,
//         this.orderId,
//         this.serviceId,
//         this.qty,
//         this.name,
//         this.price,
//         this.createdAt,
//         this.updatedAt,
//         this.madicineImg});
//
//   Medicine.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     orderId = json['order_id'];
//     serviceId = json['service_id'];
//     qty = json['qty'];
//     name = json['name'];
//     price = json['price'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     madicineImg = json['madicine_img'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['order_id'] = this.orderId;
//     data['service_id'] = this.serviceId;
//     data['qty'] = this.qty;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['madicine_img'] = this.madicineImg;
//     return data;
//   }
// }

