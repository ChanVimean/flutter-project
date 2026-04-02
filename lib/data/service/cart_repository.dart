import 'package:project/data/model/product.dart';
import 'package:sembast/sembast.dart';

class CartRepository {
  static Database? _db;
  static final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store('carts');

  static void init(Database database) {
    _db = database;
  }

  static Database get db {
    if (_db == null) throw Exception("Cart Repository not initialized");
    return _db!;
  }

  static Future<void> saveToCart(Product product) async {
    final Map<String, dynamic> data = product.toJson();

    data['qty'] = product.qty;

    await _store.record(product.uuid).put(_db!, data);
  }

  static Future<void> removeFromCart(String uuid) async {
    await _store.record(uuid).delete(_db!);
  }

  static Future<List<Product>> loadCart() async {
    final snapshots = await _store.find(_db!);

    return snapshots.map((s) {
      final map = s.value;
      return Product.fromJson(map).copyWith(qty: map['qty'] as int? ?? 0);
    }).toList();
  }
}
