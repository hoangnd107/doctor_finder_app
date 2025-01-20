class SearchAddMedicineModel {
  int? status;

  String? msg;
  List<MedicineData>? data;

  SearchAddMedicineModel({this.status, this.msg, this.data});

  SearchAddMedicineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <MedicineData>[];
      json['data'].forEach((v) {
        data!.add(new MedicineData.fromJson(v));
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

class MedicineData {
  int? id;
  String? name;
  dynamic dosage;
  String? medicineType;
  String? description;

  MedicineData(
      {this.id, this.name, this.dosage, this.medicineType, this.description});

  MedicineData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dosage = json['dosage'];
    medicineType = json['medicine_type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dosage'] = this.dosage;
    data['medicine_type'] = this.medicineType;
    data['description'] = this.description;
    return data;
  }
}
//
// class PharmacyMedicineData {
//   int? status;
//   int? pharmacy_tax;
//   int? pharmacy_delivery_charge;
//   String? msg;
//   int? success;
//   PMAData? data;
//
//   PharmacyMedicineData({this.status, this.msg, this.success, this.data,this.pharmacy_tax,this.pharmacy_delivery_charge});
//
//   PharmacyMedicineData.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     pharmacy_tax = json['pharmacy_tax'];
// pharmacy_delivery_charge = json['pharmacy_delivery_charge'];
//     msg = json['msg'];
//     success = json['success'];
//     data = json['data'] != null ? new PMAData.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
// data['pharmacy_tax'] = this.pharmacy_tax;
// data['pharmacy_delivery_charge'] = this.pharmacy_delivery_charge;
// data['msg'] = this.msg;
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class PMAData {
//   int? currentPage;
//   List<PMData>? pharmacyData;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<PDLinks>? links;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   String? prevPageUrl;
//   int? to;
//   int? total;
//
//   PMAData(
//       {this.currentPage,
//       this.pharmacyData,
//       this.firstPageUrl,
//       this.from,
//       this.lastPage,
//       this.lastPageUrl,
//       this.links,
//       this.nextPageUrl,
//       this.path,
//       this.perPage,
//       this.prevPageUrl,
//       this.to,
//       this.total});
//
//   PMAData.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       pharmacyData = <PMData>[];
//       json['data'].forEach((v) {
//         pharmacyData!.add(new PMData.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     if (json['links'] != null) {
//       links = <PDLinks>[];
//       json['links'].forEach((v) {
//         links!.add(new PDLinks.fromJson(v));
//       });
//     }
//     nextPageUrl = json['next_page_url'].toString();
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'].toString();
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     if (this.pharmacyData != null) {
//       data['data'] = this.pharmacyData!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = this.firstPageUrl;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['last_page_url'] = this.lastPageUrl;
//     if (this.links != null) {
//       data['links'] = this.links!.map((v) => v.toJson()).toList();
//     }
//     data['next_page_url'] = this.nextPageUrl;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['prev_page_url'] = this.prevPageUrl;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }


class PharmacyMedicineData {
  int? status;
  String? msg;
  int? success;
  List<PMAData>? data;
  int? pharmacyTax;
  int? pharmacyDeliveryCharge;

  PharmacyMedicineData(
      {this.status,
        this.msg,
        this.success,
        this.data,
        this.pharmacyTax,
        this.pharmacyDeliveryCharge});

  PharmacyMedicineData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    success = json['success'];
    if (json['data'] != null) {
      data = <PMAData>[];
      json['data'].forEach((v) {
        data!.add(new PMAData.fromJson(v));
      });
    }
    pharmacyTax = json['pharmacy_tax'];
    pharmacyDeliveryCharge = json['pharmacy_delivery_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['pharmacy_tax'] = this.pharmacyTax;
    data['pharmacy_delivery_charge'] = this.pharmacyDeliveryCharge;
    return data;
  }
}

class PMAData {
  int? id;
  int? pharmacyId;
  dynamic? name;
  dynamic? description;
  dynamic? price;
  String? image;
  String? createdAt;
  String? updatedAt;


  PMAData(
      {this.id,
        this.pharmacyId,
        this.name,
        this.description,
        this.price,
        this.image,
        this.createdAt,
        this.updatedAt});

  PMAData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyId = json['pharmacy_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pharmacy_id'] = this.pharmacyId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



class PMData {
  int? id;
  int? userId;
  String? name;
  String? description;
  String? price;
  String? image;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  PMData(
      {this.id,
      this.userId,
      this.name,
      this.description,
      this.price,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  PMData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'].toString();
    description = json['description'].toString();
    price = json['price'].toString();
    image = json['image'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class PDLinks {
  String? url;
  String? label;
  bool? active;

  PDLinks({this.url, this.label, this.active});

  PDLinks.fromJson(Map<String, dynamic> json) {
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
