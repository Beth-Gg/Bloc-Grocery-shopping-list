import 'dart:convert';
import '/Infrastructure/models/shop.dart';
import 'package:http/http.dart' as http;
class ShopRepository {
  final String baseUrl = 'http://localhost:6036/shop';

  Future<List<Shop>> fetchShops() async {
    print('Fetching shops...');
    final response = await http.get(Uri.parse('$baseUrl/allshops'));
    if (response.statusCode == 200) {
      final List<dynamic> shopsJson = jsonDecode(response.body);
      final List<Shop> shops = shopsJson.map((shopJson) => Shop.fromJson(shopJson)).toList();
      print('Fetched ${shops.length} shops');
      return shops;
    } else {
      throw Exception('Failed to load shops');
    }
  }

}