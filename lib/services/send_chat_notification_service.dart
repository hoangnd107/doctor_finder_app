import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class SendNotification {

  sendNotificationFinalStep({required Map mm}) async {
    print("object11");
    List<String> ll = await generateToken();
print(ll.first);
print(ll.last);
    final http.Response response = await http.post(
      Uri.parse(
        'https://fcm.googleapis.com/v1/projects/${ll.last}/messages:send',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ll.first}'
      },
      body: jsonEncode(mm),
    );

    print("Request URL: ${response.request!.url}");
    print("Request Body: ${jsonEncode(mm)}");
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");


    if (response.statusCode == 200) {
      print('FCM message sent successfully');
    } else {
      print('Failed to send FCM message: ${response.statusCode}');
    }
  }

  Future<List<String>> generateToken() async {
    final serviceAccountJson = await getJson();
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
 
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();

    return [credentials.accessToken.data, serviceAccountJson['project_id']];
  }

  Future<Map<String, dynamic>> getJson() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('assets/json'))
        .where((String key) => key.contains('.json'))
        .toList();
    print("imagePaths :: $imagePaths");
    if (imagePaths.isNotEmpty) {
      String s = await rootBundle.loadString(imagePaths.first);
      return jsonDecode(s);
    }
    return {};
  }
}
