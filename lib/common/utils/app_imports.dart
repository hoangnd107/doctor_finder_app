export 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState,CarouselController;
export 'package:flutter/services.dart';
export 'package:flutter/foundation.dart' hide kIsWasm;
export 'dart:async';
export 'dart:typed_data';
export 'dart:io' hide X509Certificate, Cookie, HttpClient;
export 'dart:convert';
export 'dart:math' hide log;
export 'dart:collection' hide IterableExtensions;

/// services
export 'package:videocalling_medical/services/localstorage_service.dart';
export 'package:videocalling_medical/services/string_services.dart';
export 'package:videocalling_medical/services/connectycube_session_service.dart';
export 'package:videocalling_medical/services/add_to_cart_db_service.dart';

/// utils
export 'package:videocalling_medical/common/utils/app_colors.dart';
export 'package:videocalling_medical/common/utils/app_images.dart';
export 'package:videocalling_medical/common/utils/app_words.dart';
export 'package:videocalling_medical/common/utils/extention.dart';
export 'package:videocalling_medical/common/utils/app_text_widgets.dart';
export 'package:videocalling_medical/common/utils/app_apis.dart';
export 'package:videocalling_medical/common/utils/notification_background_message_helper.dart';
export 'package:videocalling_medical/common/components/textfield.dart';
export 'package:videocalling_medical/common/components/option_tile.dart';
export 'package:videocalling_medical/common/utils/app_variales.dart';
export 'package:videocalling_medical/common/routes/app_pages.dart';

/// model
export 'package:videocalling_medical/common/model/chat_list_model.dart';
export 'package:videocalling_medical/common/model/appointment_model.dart';
export 'package:videocalling_medical/common/model/appointment_details_model.dart';
export 'package:videocalling_medical/common/model/speciality_model_class.dart';
export 'package:videocalling_medical/common/model/cart_medicine_model.dart';
export 'package:videocalling_medical/common/model/address_model.dart';

/// components
export 'package:videocalling_medical/common/components/dialog.dart';
export 'package:videocalling_medical/common/components/home_grids.dart';
export 'package:videocalling_medical/common/components/doctor_grid.dart';
export 'package:videocalling_medical/common/components/button.dart';
export 'package:videocalling_medical/common/components/appbar.dart';
export 'package:videocalling_medical/common/components/no_chats.dart';

/// packages
export 'package:get/get.dart'
    hide Response, FormData, MultipartFile, HeaderValue;
export 'package:shared_preferences/shared_preferences.dart';
export 'package:sqflite/sqflite.dart' hide Transaction;
export 'package:pull_to_refresh/pull_to_refresh.dart';
export 'package:flutter_stripe/flutter_stripe.dart' hide Card, Address;
export 'package:get_storage/get_storage.dart' hide Data;
export 'package:dotted_border/dotted_border.dart';
export 'package:google_maps_flutter/google_maps_flutter.dart';
export 'package:geocode/geocode.dart';
export 'package:geocoding/geocoding.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:path_provider/path_provider.dart';
export 'package:auto_size_text/auto_size_text.dart';
export 'package:package_info_plus/package_info_plus.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:photo_view/photo_view.dart';
export 'package:video_player/video_player.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:http/http.dart' hide MultipartFile;
// export 'package:carousel_slider/carousel_slider.dart' ;
export 'package:firebase_database/firebase_database.dart' hide Query;
export 'package:url_launcher/url_launcher.dart';
export 'package:flutter_html/flutter_html.dart' hide OnTap, Marker;
export 'package:cached_network_image/cached_network_image.dart';
export 'package:image_picker/image_picker.dart';
export 'package:firebase_messaging/firebase_messaging.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:external_path/external_path.dart';
export 'package:sn_progress_dialog/sn_progress_dialog.dart';
export 'package:device_info_plus/device_info_plus.dart';
export 'package:table_calendar/table_calendar.dart';
export 'package:syncfusion_flutter_datepicker/datepicker.dart';
export 'package:flutter_pdfview/flutter_pdfview.dart';
export 'package:flutter_inappwebview/flutter_inappwebview.dart';
export 'package:geolocator/geolocator.dart';
export 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
export 'package:permission_handler/permission_handler.dart' hide ServiceStatus;
export 'package:flutter_uploader/flutter_uploader.dart';
export 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
export 'package:cloud_firestore/cloud_firestore.dart'
    hide Query, Transaction, TransactionHandler;

/// splash screen
export 'package:videocalling_medical/common/controllers/splash_controller.dart';
export 'package:videocalling_medical/common/bindings/splash_screen_binding.dart';
export 'package:videocalling_medical/common/screens/splash_screen.dart';

/// my app screen
export 'package:videocalling_medical/common/controllers/myapp_controller.dart';
export 'package:videocalling_medical/common/bindings/myapp_screen_binding.dart';
export 'package:videocalling_medical/common/screens/myapp_screen.dart';

/// incoming call screen
export 'package:videocalling_medical/common/controllers/incoming_call_controller.dart';
export 'package:videocalling_medical/common/bindings/incoming_call_binding.dart';
export 'package:videocalling_medical/common/screens/incoming_call_screen.dart';

/// video player screen
export 'package:videocalling_medical/common/controllers/video_player_controller.dart';
export 'package:videocalling_medical/common/bindings/video_player_binding.dart';
export 'package:videocalling_medical/common/screens/video_player_screen.dart';

/// photo viewer screen
export 'package:videocalling_medical/common/controllers/photo_viewer_controller.dart';
export 'package:videocalling_medical/common/bindings/photo_viewer_binding.dart';
export 'package:videocalling_medical/common/screens/photo_viewer_screen.dart';
export 'package:videocalling_medical/common/model/upload_image_model.dart';

/// video thumbnail screen
export 'package:videocalling_medical/common/controllers/video_thumbnail_controller.dart';
export 'package:videocalling_medical/common/bindings/video_thumbnail_binding.dart';
export 'package:videocalling_medical/common/screens/video_thumbnail_screen.dart';

/// chat screen
export 'package:videocalling_medical/common/controllers/chat_screen_controller.dart';
export 'package:videocalling_medical/common/bindings/chat_screen_binding.dart';
export 'package:videocalling_medical/common/screens/chat_screen.dart';

/// in app web view screen
export 'package:videocalling_medical/common/controllers/in_app_webview_controller.dart';
export 'package:videocalling_medical/common/bindings/in_app_webview_binding.dart';
export 'package:videocalling_medical/common/screens/in_app_webview_screen.dart';

/// forget password screen
export 'package:videocalling_medical/common/controllers/forget_password_controller.dart';
export 'package:videocalling_medical/common/bindings/forget_password_binding.dart';
export 'package:videocalling_medical/common/screens/forget_password_screen.dart';