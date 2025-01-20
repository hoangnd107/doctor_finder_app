import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:path/path.dart';

class DBHelperCart extends GetxService {
  static const String ID = 'id';
  static const String TABLE = 'cart_db';
  static const String DB_NAME = 'doctor_finder.db';
  static const String mId = 'medicine_id';
  static const String name = 'name';
  static const String price = 'price';
  static const String descriptions = 'descriptions';

  static const String TABLE1 = 'address_data';
  static const String address = 'address';
  static const String tag = 'tag';
  static const String defaultAddress = 'defaultAddress';
  static const String lat = 'lat';
  static const String lon = 'lon';

  Future<Database> get db async {
    return await initDb();
  }

  initDb() async {
    Directory applicationDirectory = await getApplicationDocumentsDirectory();

    String dbPathEnglish = join(applicationDirectory.path, DB_NAME);

    bool dbExistsEnglish = await File(dbPathEnglish).exists();
    if (!dbExistsEnglish) {
      ByteData data =
          await rootBundle.load(join("assets", "database/doctor_finder.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(dbPathEnglish).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(dbPathEnglish);
  }

  Future<CartMedicine> save(CartMedicine img) async {
    var dbClient = await db;
    img.id = await dbClient.insert(TABLE, img.toMap());
    return img;
  }

  Future<int> delete({required int id}) async {
    var dbClient = await db;
    id = await dbClient.rawDelete(
      "DELETE FROM $TABLE WHERE $ID = $id",
    );
    return id;
  }

  Future<List<CartMedicine>> getCartList() async {
    var dbClient = await db;

    List<Map> maps = await dbClient.query(
      TABLE,
    );

    return maps.map((e) => CartMedicine.fromMap(e)).toList();
  }

  Future<int> saveAddress(AddressModel img) async {
    var dbClient = await db;
    if (img.defaultAddress == 1) {
      await dbClient.update(
        TABLE1,
        {'defaultAddress': 0},
      );
    }
    return await dbClient.insert(TABLE1, img.toMap());
  }

  Future<int> updateAddress(
      {required int id, required AddressModel img}) async {
    var dbClient = await db;
    if (img.defaultAddress == 1) {
      await dbClient.update(
        TABLE1,
        {'default': 0},
      );
    }
    return await dbClient.rawUpdate(
        "UPDATE $TABLE1 SET $address = '${img.address}', $tag = '${img.tag}', $defaultAddress = ${img.defaultAddress}, $lat = '${img.lat}', $lon = '${img.long}' WHERE id = $id");
  }

  Future<int> deleteAddress({required int id}) async {
    var dbClient = await db;
    return await dbClient.rawDelete("DELETE FROM $TABLE1 WHERE $ID = '$id'");
  }

  Future<List<AddressModel>> getAddressList() async {
    var dbClient = await db;

    List<Map> maps = await dbClient.query(
      TABLE1,
    );

    return maps.map((e) => AddressModel.fromMap(e)).toList();
  }

  Future<int> deleteTable({required String TABLE}) async {
    var dbClient = await db;

    int maps = await dbClient.delete(
      TABLE,
    );

    return maps;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  Future truncateTable() async {
    var dbClient = await db;
    await dbClient.rawQuery("DELETE FROM $TABLE");
  }
}
