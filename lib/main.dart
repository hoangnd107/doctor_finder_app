import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBcwCVpAtg6A2xPviZUpvNBcqkvDqKZgJM',
      appId: '1:165951998428:android:90e2aabf97d0e513e66719',
      messagingSenderId: '165951998428',
      projectId: 'doctorfindernew-dd44b',
    ),
  );
  if (Platform.isAndroid) {
  } else {
    await Firebase.initializeApp();
  }
  await GetStorage.init();
  await Get.putAsync<DBHelperCart>(() async {
    DBHelperCart cart = DBHelperCart();
    await cart.initDb();
    return cart;
  });

  notificationHelper.initialize();

  Stripe.publishableKey = stripePublisherKey;

  ConnectycubeFlutterCallKit.onCallAcceptedWhenTerminated =
      onCallAcceptedWhenTerminated;
  ConnectycubeFlutterCallKit.onCallRejectedWhenTerminated =
      onCallRejectedWhenTerminated;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}
