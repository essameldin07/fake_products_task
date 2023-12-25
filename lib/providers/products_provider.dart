import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:products/models/product_model.dart';
import 'package:products/models/rate_model.dart';
import 'package:products/utils/global_values.dart';

class ProductsProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<PorductModel> _products = [];

  List<PorductModel> productsList() {
    return _products;
  }

  bool isLoading() {
    return _isLoading;
  }

  Future<void> fetchData(context) async {
    _isLoading = true;
    notifyListeners();
    Dio dio = Dio();

    final response = await dio.get("${GlobalValues.BASE_URL}/products");
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      for (var element in response.data) {
        print(element.toString());
        PorductModel model = PorductModel(
            category: element["category"],
            id: element["id"],
            title: element["title"] ?? "N/A",
            price: element["price"].toDouble() ?? 0.0,
            description: element["description"] ?? "N/A",
            image: element["image"] ?? "N/A",
            rateModel: RateModel.fromJSON(element["rating"]));
        _products.add(model);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something Error Please Contant us")));
    }
    _isLoading = false;
    notifyListeners();

    print("object" + _isLoading.toString());
  }

  PorductModel? findById(int id) {
    for (var element in _products) {
      if (element.id == id) {
        return element;
      }
    }
    return null;
  }
}
