// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:products/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

import 'package:products/models/product_model.dart';
import 'package:products/providers/cart_provider.dart';

class ProductWidget extends StatelessWidget {
  PorductModel product;
  ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(
                    product.id, product.price, product.title, product.image);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(
                    'Added to Cart!',
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ));
              },
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          child: Image.network(
            product.image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
