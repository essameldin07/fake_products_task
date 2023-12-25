import 'package:flutter/material.dart';
import 'package:products/database/database.dart';
import 'package:products/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> _items = [];

  Future<List<CartModel>> getItems() async {
    List<CartModel> items = [];
    final database = await AppDatabase.getInctance();
    items = await database.cartDao.findAllCart();
    this._items = items;
    notifyListeners();
    return [...items];
  }

  List<CartModel> get items {
    return [..._items];
  }

  int get itemCount {
    int count = 0;
    for (var element in items) {
      count = element.quantity + count;
    }
    return count;
  }

  double getTotalPrice() {
    double price = 0;
    for (var element in items) {
      price = element.price * element.quantity + price;
    }
    return price;
  }

  Future<double> get totalAmount async {
    double total = 0.0;
    List<CartModel> items = [];
    final database = await AppDatabase.getInctance();
    items = await database.cartDao.findAllCart();
    items.forEach((value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  void addItem(int productId, double price, String title, String image) async {
    final database = await AppDatabase.getInctance();

    CartModel? model;
    await database.cartDao
        .findCartById(productId)
        .then((value) => model = value);
    if (model != null) {
      model!.quantity++;
      database.cartDao.updateCart(model!);
    } else {
      model = CartModel(
          id: productId,
          productId: productId,
          title: title,
          price: price,
          image: image,
          quantity: 1);
      database.cartDao.insertCart(model!);
    }
    notifyListeners();
  }

  void removeItem(int id) async {
    final database = await AppDatabase.getInctance();
    database.cartDao.deleteById(id);
    notifyListeners();
  }

  void removeSingleItem(int productId) async {
    final database = await AppDatabase.getInctance();
    CartModel model =
        (await database.cartDao.findCartById(productId)) as CartModel;

    // ignore: unnecessary_null_comparison
    if (model == null) {
      return;
    }

    if (model.quantity > 1) {
      model.quantity--;
      database.cartDao.updateCart(model);
    } else {
      removeItem(productId);
    }
    notifyListeners();
  }

  void clear() async {
    final database = await AppDatabase.getInctance();
    database.cartDao.deleteAll();
    notifyListeners();
  }
}
