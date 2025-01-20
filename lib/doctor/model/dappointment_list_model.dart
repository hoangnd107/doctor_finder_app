class DoctorPastAppointmentsClass {
  String? success;
  String? register;
  DAData? data;

  DoctorPastAppointmentsClass({this.success, this.register, this.data});

  DoctorPastAppointmentsClass.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    register = json['register'];
    data = json['data'] != null ? new DAData.fromJson(json['data']) : null;
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

class DAData {
  int? currentPage;
  List<DoctorAppointmentData>? doctorAppointmentData;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<DALinks>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  DAData(
      {this.currentPage,
      this.doctorAppointmentData,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  DAData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      doctorAppointmentData = <DoctorAppointmentData>[];
      json['data'].forEach((v) {
        doctorAppointmentData!.add(new DoctorAppointmentData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <DALinks>[];
      json['links'].forEach((v) {
        links!.add(new DALinks.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'].toString();
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'].toString();
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.doctorAppointmentData != null) {
      data['data'] =
          this.doctorAppointmentData!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class DoctorAppointmentData {
  String? date;
  int? id;
  String? slot;
  String? phone;
  String? status;
  String? name;
  String? image;

  DoctorAppointmentData(
      {this.date,
      this.id,
      this.slot,
      this.phone,
      this.status,
      this.name,
      this.image});

  DoctorAppointmentData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    id = json['id'];
    slot = json['slot'].toString();
    phone = json['phone'].toString();
    status = json['status'].toString();
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['id'] = this.id;
    data['slot'] = this.slot;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class DALinks {
  String? url;
  String? label;
  bool? active;

  DALinks({this.url, this.label, this.active});

  DALinks.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'].toString();
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}


///pharmacy data model

class PharmacyOrderClass {
  int? status;
  String? msg;
  List<DataPharmacy>? data;

  PharmacyOrderClass({this.status, this.msg, this.data});

  PharmacyOrderClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <DataPharmacy>[];
      json['data'].forEach((v) {
        data!.add(new DataPharmacy.fromJson(v));
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

class DataPharmacy {
  int? id;
  int? pharmacyId;
  int? userId;
  int? orderType;
  String? paymentType;
  String? name;
  String? image;
  String? email;
  String? transactionId;
  dynamic? status;
  dynamic? prescription;
  dynamic? phone;
  String? address;
  String? message;
  dynamic? taxPr;
  dynamic? tax;
  dynamic? deliveryCharge;
  dynamic? total;
  String? createdAt;
  String? updatedAt;
  int? isCompleted;
  List<Medicinedata>? medicine;

  DataPharmacy(
      {this.id,
        this.pharmacyId,
        this.userId,
        this.orderType,
        this.paymentType,
        this.name,
        this.image,
        this.email,
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
        this.medicine});

  DataPharmacy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyId = json['Pharmacy_id'];
    userId = json['user_id'];
    orderType = json['order_type'];
    paymentType = json['payment_type'];
    name = json['user_name'];
    image = json['user_image'];
    email = json['user_image'];
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
    if (json['medicine'] != null) {
      medicine = <Medicinedata>[];
      json['medicine'].forEach((v) {
        medicine!.add(new Medicinedata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Pharmacy_id'] = this.pharmacyId;
    data['user_id'] = this.userId;
    data['order_type'] = this.orderType;
    data['payment_type'] = this.paymentType;
    data['user_name'] = this.name;
    data['user_image'] = this.image;
    data['user_image'] = this.email;
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
    if (this.medicine != null) {
      data['medicine'] = this.medicine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicinedata {
  int? id;
  int? orderId;
  int? serviceId;
  dynamic? qty;
  String? name;
  dynamic? price;
  String? createdAt;
  String? updatedAt;

  Medicinedata(
      {this.id,
        this.orderId,
        this.serviceId,
        this.qty,
        this.name,
        this.price,
        this.createdAt,
        this.updatedAt});

  Medicinedata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    serviceId = json['service_id'];
    qty = json['qty'];
    name = json['name'];
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
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
