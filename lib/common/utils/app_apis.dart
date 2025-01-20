class Apis {
  static const int timeOut = 10;

  // static const String ServerAddress =
  //       'http://192.168.1.21/rutik/book_backend/bookappointment';

  static const String ServerAddress =
      'https://demo.freaktemplate.com/bookappointment';

  /// image paths
  static const String IMAGE = "$ServerAddress/public/upload/banner/";
  static const String medicineImage =
      "$ServerAddress/public/upload/pharmacymedicine/";
  static const String specialityImagePath =
      "$ServerAddress/public/upload/services/";
  static const String reportImagePath =
      "$ServerAddress/public/upload/ap_img_up/";
  static const String chatMediaPath = "$ServerAddress/public/upload/chat/";
  static const String doctorImagePath = "$ServerAddress/public/upload/doctors/";
  static const String userImagePath = "$ServerAddress/public/upload/profile/";
  static const String prescription = "$ServerAddress/public/upload/orderprescription/";

  static const String SUCCESS_PAYMENT_URL = "$ServerAddress/payment_success";
  static const String FAIL_PAYMENT_URL = "$ServerAddress/payment_failed";

  static String razorpay({required amount})=>"$ServerAddress/pay_razorpay?type=3&amount=$amount";
  static String paystack({required amount})=>"$ServerAddress/paystack-payment?type=3&amount=$amount";
  static String braintree({required amount})=>"$ServerAddress/braintree_payment?type=3&amount=$amount";
  static String rave({required amount , required uid})=>"$ServerAddress/rave-payment?type=3&amount=$amount&user_id=$uid";
}
