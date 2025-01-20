//   class MedicineAllData1 {
//   int? status;
//   String? msg;
//   dynamic? success;
//   Data? data;
//   dynamic? pharmacyTax;
//   dynamic? pharmacyDeliveryCharge;
//
//   MedicineAllData1(
//       {this.status,
//         this.msg,
//         this.success,
//         this.data,
//         this.pharmacyTax,
//         this.pharmacyDeliveryCharge});
//
//   MedicineAllData1.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     success = json['success'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     pharmacyTax = json['pharmacy_tax'];
//     pharmacyDeliveryCharge = json['pharmacy_delivery_charge'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['msg'] = this.msg;
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['pharmacy_tax'] = this.pharmacyTax;
//     data['pharmacy_delivery_charge'] = this.pharmacyDeliveryCharge;
//     return data;
//   }
// }
//
// class Data {
//   int? currentPage;
//   List<Data1>? data1;
//   String? firstPageUrl;
//   dynamic? from;
//   dynamic? lastPage;
//   String? lastPageUrl;
//   dynamic? nextPageUrl;
//   String? path;
//   dynamic? perPage;
//   dynamic? prevPageUrl;
//   dynamic? to;
//   dynamic total;
//
//   Data(
//       {this.currentPage,
//         this.data1,
//         this.firstPageUrl,
//         this.from,
//         this.lastPage,
//         this.lastPageUrl,
//         this.nextPageUrl,
//         this.path,
//         this.perPage,
//         this.prevPageUrl,
//         this.to,
//         this.total});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data1 = <Data1>[];
//       json['data'].forEach((v) {
//         data1!.add(new Data1.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     if (this.data1 != null) {
//       data['data'] = this.data1!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = this.firstPageUrl;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['last_page_url'] = this.lastPageUrl;
//
//     data['next_page_url'] = this.nextPageUrl;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['prev_page_url'] = this.prevPageUrl;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }
//
// class Data1 {
//   int? id;
//   int? pharmacyId;
//   String? name;
//   String? description;
//   dynamic? price;
//   String? image;
//   String? createdAt;
//   String? updatedAt;
//
//   Data1(
//       {this.id,
//         this.pharmacyId,
//         this.name,
//         this.description,
//         this.price,
//         this.image,
//         this.createdAt,
//         this.updatedAt});
//
//   Data1.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     pharmacyId = json['pharmacy_id'];
//     name = json['name'];
//     description = json['description'];
//     price = json['price'];
//     image = json['image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['pharmacy_id'] = this.pharmacyId;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['image'] = this.image;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

  class MedicineAllData1 {
    int? status;
    String? msg;
    int? success;
    List<Data>? data;
    int? pharmacyTax;
    int? pharmacyDeliveryCharge;

    MedicineAllData1(
        {this.status,
          this.msg,
          this.success,
          this.data,
          this.pharmacyTax,
          this.pharmacyDeliveryCharge});

    MedicineAllData1.fromJson(Map<String, dynamic> json) {
      status = json['status'];
      msg = json['msg'];
      success = json['success'];
      if (json['data'] != null) {
        data = <Data>[];
        json['data'].forEach((v) {
          data!.add(new Data.fromJson(v));
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

  class Data {
    int? id;
    int? pharmacyId;
    String? name;
    String? description;
    dynamic? price;
    String? image;
    String? createdAt;
    String? updatedAt;

    Data(
        {this.id,
          this.pharmacyId,
          this.name,
          this.description,
          this.price,
          this.image,
          this.createdAt,
          this.updatedAt});

    Data.fromJson(Map<String, dynamic> json) {
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
