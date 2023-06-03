import 'package:fire_auth/models/product.dart';
import 'package:fire_auth/models/product_list_response.dart';
import 'package:fire_auth/services/api_service.dart';
import 'package:fire_auth/utils/common_util.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  late ApiService _apiService;

  HomeProvider() {
    _apiService = ApiService();
  }

  ProductListResponse? _productListResponse;
  List<Product> _productList = [];


  ///Getters

  List<Product> get productList => _productList;

  Future<void> getProductList({bool refresh = false}) async {
    CommonUtil.internetCheck().then((value) async {
      if(refresh){
        _productList = [];
      }
      _productListResponse = await _apiService.getProductList();
      notifyListeners();
      _productList.addAll(_productListResponse?.products ?? []);
      print(_productList);
      notifyListeners();
    });
  }
}
