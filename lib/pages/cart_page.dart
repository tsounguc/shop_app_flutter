import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartProvider>(context).cart;
    // provider is triggered by the extension method watch().
    // It gives the same result as the line above
    // watch() is an extension on BuildContext from flutter.
    // It cannot be called outside build function
    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(cartItem['imageUrl'] as String),
              radius: 30,
            ),
            title: Text(
              cartItem["title"].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text("Size: ${cartItem['size']}"),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete Product", style: Theme.of(context).textTheme.titleMedium),
                        content: const Text("Are you sure you want to remove the product from your cart?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
                              // Listen is set to false in the line above, which means we are not watching but reading from provider.
                              // So we do context.read()
                              // read() is an extension on BuildContext from flutter.
                              // It cannot be called inside build function
                              context.read<CartProvider>().removeProduct(cartItem);
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
