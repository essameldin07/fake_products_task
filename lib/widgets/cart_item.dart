import 'package:flutter/material.dart';
import 'package:products/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final int id;
  final int productId;
  final double price;
  final int quantity;
  final String title;
  final String image;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title,
      this.image);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Are you Sure?'),
                content: Text('Do you want remove the item from cart ? '),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('No')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text('Yes')),
                ],
              );
            });
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
            title: Text(title),
            subtitle: Text('Total:\$${(price * quantity).toStringAsFixed(2)} '),
            trailing: Text("${quantity}x"),
          ),
        ),
      ),
    );
  }
}
