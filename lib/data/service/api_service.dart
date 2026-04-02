import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/data/model/product.dart';

class ApiService {
  static String api =
      "https://chanvimean.github.io/Otaku-Vault-Data/index.json";
  static Future<List<Product>> getProduct() async {
    final res = await http.get(Uri.parse(api));
    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Error Api");
    }
  }
}
