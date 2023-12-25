import 'package:flutter/material.dart';
import 'package:products/providers/cart_provider.dart';
import 'package:products/providers/products_provider.dart';
import 'package:products/screens/cart_screen.dart';
import 'package:products/widgets/product_item.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  bool isLoaded = false;

  HomeScreen({super.key}) {
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print(
        "=====================================================================================================================");
    if (!widget.isLoaded) {
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchData(context)
          .then((value) => {widget.isLoaded = true});
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Products',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Badge(
                    label: Text(value.itemCount.toString()),
                    backgroundColor: Colors.red,
                    isLabelVisible: true,
                    alignment: Alignment.topRight,
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            )
          ],
        ),
        body: Consumer<ProductsProvider>(
          builder: (context, productsProvider, child) {
            return productsProvider.isLoading()
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: productsProvider.productsList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductWidget(
                          product: productsProvider.productsList()[index]);
                    },
                  );
          },
        ));
  }
}
