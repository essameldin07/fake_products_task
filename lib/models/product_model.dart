import 'package:products/models/rate_model.dart';

class PorductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RateModel rateModel;

  PorductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rateModel});
}
