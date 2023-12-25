import 'package:floor/floor.dart';

@entity
class CartModel {
  @primaryKey
  int id;
  int productId;
  String title;
  int quantity;
  double price;
  String image;

  CartModel(
      {required this.id,
      required this.productId,
      required this.title,
      required this.price,
      required this.image,
      required this.quantity});

  double getTotalPrice() {
    return quantity * price;
  }
}
