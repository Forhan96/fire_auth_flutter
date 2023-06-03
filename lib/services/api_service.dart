import 'dart:convert';
import 'dart:developer';

import 'package:fire_auth/models/product_list_response.dart';
import 'package:fire_auth/utils/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<ProductListResponse?> getProductList() async {
    try {
      Uri url = Uri.parse(ApiConstants.baseUrl + ApiConstants.productList);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        ProductListResponse productListResponse = ProductListResponse.fromJson(jsonDecode(response.body));
        return productListResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
