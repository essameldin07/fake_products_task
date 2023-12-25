import 'package:flutter/material.dart';
import 'package:products/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    cart.getItems();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Your Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      "\$${cart.getTotalPrice().toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) => ci.CartItem(
                cart.items[index].id,
                cart.items[index].productId,
                cart.items[index].price,
                cart.items[index].quantity,
                cart.items[index].title,
                cart.items[index].image),
          ))
        ],
      ),
    );
  }
}
