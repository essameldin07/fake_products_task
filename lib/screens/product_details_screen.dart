import 'package:flutter/material.dart';
import 'package:products/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments as int;
    final loadedProduct =
        Provider.of<ProductsProvider>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(loadedProduct!.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\$${loadedProduct.price}",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ))
          ],
        ),
      ),
    );
  }
}
